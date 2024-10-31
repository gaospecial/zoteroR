#' Get file from a specific item
#'
#' @param client Zotero API client object
#' @param item_key Item key
#'
#' @return Raw file content
#' @examples
#' \dontrun{
#' # Get file content
#' file_content <- get_file(client, "ITEM_KEY")
#' }
#' @export
get_file <- function(client, item_key) {
  # First check if item exists and has attachment
  item <- make_request(client, 
                      sprintf("/%s/%s/items/%s", 
                             client$library_type, 
                             client$library_id,
                             item_key))
  
  # Check if item is an attachment
  if (!identical(item$data$itemType, "attachment")) {
    stop("Item is not an attachment. Please provide an attachment item key.")
  }
  
  # Check if item has file
  if (is.null(item$data$contentType)) {
    stop("Item does not have an associated file.")
  }
  
  endpoint <- sprintf("/%s/%s/items/%s/file", 
                     client$library_type, 
                     client$library_id,
                     item_key)
  
  make_request(client, endpoint, format = "raw")
}

#' Download file attachment to disk
#'
#' @param client Zotero API client object
#' @param item_key Item key
#' @param filename Optional filename for saving
#' @param path Optional path for saving
#'
#' @return Path to the saved file
#' @examples
#' \dontrun{
#' # Download file
#' file_path <- download_file(client, "ITEM_KEY", path = "downloads")
#' }
#' @export
download_file <- function(client, item_key, filename = NULL, path = NULL) {
  # First check if item exists and has attachment
  item <- make_request(client, 
                      sprintf("/%s/%s/items/%s", 
                             client$library_type, 
                             client$library_id,
                             item_key))
  
  # Check if item is an attachment
  if (!identical(item$data$itemType, "attachment")) {
    stop("Item is not an attachment. Please provide an attachment item key.")
  }
  
  # Check if item has file
  if (is.null(item$data$contentType)) {
    stop("Item does not have an associated file.")
  }
  
  # Get file content
  response <- get_file(client, item_key)
  
  # If filename not provided, try to get it from item data or headers
  if (is.null(filename)) {
    filename <- item$data$filename
    if (is.null(filename)) {
      content_disposition <- response$headers[["content-disposition"]]
      if (!is.null(content_disposition)) {
        filename <- sub('.*filename="([^"]+)".*', "\\1", content_disposition)
      } else {
        filename <- item_key
      }
    }
  }
  
  # Add path if provided
  if (!is.null(path)) {
    if (!dir.exists(path)) dir.create(path, recursive = TRUE)
    filename <- file.path(path, filename)
  }
  
  # Write file
  writeBin(response$content, filename)
  return(filename)
}

#' Get attachment template
#'
#' @param client Zotero API client object
#' @param link_mode Link mode (imported_file, imported_url, linked_file, linked_url)
#'
#' @return Attachment template
#' @keywords internal
get_attachment_template <- function(client, link_mode) {
  endpoint <- sprintf("/items/new?itemType=attachment&linkMode=%s", link_mode)
  make_request(client, endpoint)
}

#' Create file attachment
#'
#' @param client Zotero API client object
#' @param files Vector of file paths
#' @param parent_key Optional parent item key
#' @param link_mode Link mode (defaults to "imported_file")
#'
#' @return Response from API
#' @examples
#' \dontrun{
#' # Create attachment
#' result <- create_attachment(client, 
#'                           files = "document.pdf",
#'                           parent_key = "PARENT_KEY")
#' }
#' @export
create_attachment <- function(client, files, parent_key = NULL, 
                            link_mode = "imported_file") {
  # Verify files exist
  for (file in files) {
    if (!file.exists(file)) {
      stop(sprintf("File not found: %s", file))
    }
  }
  
  # Get template
  template <- get_attachment_template(client, link_mode)
  
  # Create attachments list
  attachments <- lapply(files, function(file) {
    attachment <- template
    attachment$title <- basename(file)
    attachment$filename <- basename(file)
    if (!is.null(parent_key)) {
      attachment$parentItem <- parent_key
    }
    attachment
  })
  
  # Create items
  response <- make_request(client, 
                         sprintf("/%s/%s/items", 
                                client$library_type, 
                                client$library_id),
                         method = "POST",
                         body = attachments)
  
  # Get upload authorization for each file
  for (i in seq_along(files)) {
    item_key <- response$success[[as.character(i-1)]]
    file_path <- files[i]
    
    # Get file info
    file_info <- list(
      md5 = digest::digest(file = file_path, algo = "md5"),
      filename = basename(file_path),
      filesize = file.size(file_path),
      mtime = as.character(file.mtime(file_path))
    )
    
    # Get authorization
    auth <- make_request(client,
                        sprintf("/%s/%s/items/%s/file", 
                               client$library_type,
                               client$library_id,
                               item_key),
                        method = "POST",
                        body = file_info)
    
    if (!is.null(auth$exists)) {
      next  # File already exists
    }
    
    # Upload file
    upload_file(auth$url, file_path, auth$params)
    
    # Register upload
    make_request(client,
                sprintf("/%s/%s/items/%s/file", 
                       client$library_type,
                       client$library_id,
                       item_key),
                method = "POST",
                body = list(upload = auth$uploadKey))
  }
  
  return(response)
}

#' Upload file to authorized URL
#'
#' @param url Upload URL
#' @param file_path Path to file
#' @param params Upload parameters
#'
#' @return Response from upload
#' @keywords internal
upload_file <- function(url, file_path, params) {
  # Prepare multipart form data
  body <- list()
  for (name in names(params)) {
    body[[name]] <- params[[name]]
  }
  body$file <- httr::upload_file(file_path)
  
  # Upload file
  response <- httr::POST(url, body = body, encode = "multipart")
  httr::stop_for_status(response)
  return(response)
} 