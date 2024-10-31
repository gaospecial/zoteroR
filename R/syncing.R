#' Get versions of items
#'
#' @description
#' Get a mapping of all item keys to their current versions. This is useful for
#' syncing and determining which items have changed.
#'
#' @param client Zotero API client object
#' @param since Optional. Only return versions modified since this version
#'
#' @return A list of item keys and their versions
#' @examples
#' \dontrun{
#' # Get all item versions
#' versions <- get_item_versions(client)
#' 
#' # Get versions since a specific version
#' versions <- get_item_versions(client, since = 1234)
#' }
#' @export
get_item_versions <- function(client, since = NULL) {
  endpoint <- sprintf("/%s/%s/items", client$library_type, client$library_id)
  
  params <- list(
    format = "versions",
    since = since
  )
  
  make_request(client, endpoint, query = params)
}

#' Get versions of collections
#'
#' @description
#' Get a mapping of all collection keys to their current versions. This is useful
#' for syncing and determining which collections have changed.
#'
#' @param client Zotero API client object
#' @param since Optional. Only return versions modified since this version
#'
#' @return A list of collection keys and their versions
#' @examples
#' \dontrun{
#' # Get all collection versions
#' versions <- get_collection_versions(client)
#' 
#' # Get versions since a specific version
#' versions <- get_collection_versions(client, since = 1234)
#' }
#' @export
get_collection_versions <- function(client, since = NULL) {
  endpoint <- sprintf("/%s/%s/collections", client$library_type, client$library_id)
  
  params <- list(
    format = "versions",
    since = since
  )
  
  make_request(client, endpoint, query = params)
}

#' Get the last modified version of the library
#'
#' @description
#' Get the version number of the last change to the library. This can be used
#' as a starting point for syncing.
#'
#' @param client Zotero API client object
#'
#' @return Integer representing the last modified version
#' @examples
#' \dontrun{
#' # Get last modified version
#' version <- get_last_modified_version(client)
#' }
#' @export
get_last_modified_version <- function(client) {
  endpoint <- sprintf("/%s/%s/items", client$library_type, client$library_id)
  
  # Make a minimal request to get the version header
  response <- make_request(client, endpoint, query = list(limit = 1))
  
  # Extract version from response
  if (!is.null(response$headers) && !is.null(response$headers[["last-modified-version"]])) {
    return(as.integer(response$headers[["last-modified-version"]]))
  }
  
  # If we can't get the version from headers, try to get it from the first item
  if (length(response) > 0 && !is.null(response[[1]]$version)) {
    return(as.integer(response[[1]]$version))
  }
  
  return(0)
}

#' Get deleted content since a specific version
#'
#' @description
#' Get all items, collections, searches, and tags that have been deleted since
#' a specific version.
#'
#' @param client Zotero API client object
#' @param since Version number to check from
#'
#' @return List of deleted items, searches, collections, and tags
#' @examples
#' \dontrun{
#' # Get items deleted since version 1234
#' deleted <- get_deleted(client, since = 1234)
#' }
#' @export
get_deleted <- function(client, since) {
  if (missing(since)) {
    stop("'since' parameter is required")
  }
  
  endpoint <- sprintf("/%s/%s/deleted", client$library_type, client$library_id)
  
  params <- list(since = since)
  
  make_request(client, endpoint, query = params)
}

#' Update an item with version check
#'
#' @description
#' Update an item while ensuring no conflicts with other changes. If the item
#' has been modified since the specified version, the update will fail.
#'
#' @param client Zotero API client object
#' @param item_key Item key to update
#' @param data New item data
#' @param version Current version of the item
#'
#' @return Updated item data
#' @examples
#' \dontrun{
#' # Update an item
#' result <- update_item_version(client, 
#'                              item_key = "ITEM_KEY",
#'                              data = list(title = "New Title"),
#'                              version = 123)
#' }
#' @export
update_item_version <- function(client, item_key, data, version) {
  endpoint <- sprintf("/%s/%s/items/%s", 
                     client$library_type, 
                     client$library_id,
                     item_key)
  
  # Add version header for concurrency control
  headers <- list(
    "If-Unmodified-Since-Version" = as.character(version)
  )
  
  make_request(client, endpoint, 
              method = "PATCH", 
              body = data,
              headers = headers)
}

#' Update multiple items with version check
#'
#' @description
#' Update multiple items while ensuring no conflicts with other changes. If any
#' item has been modified since the specified version, the entire update will fail.
#'
#' @param client Zotero API client object
#' @param items List of items to update
#' @param version Current library version
#'
#' @return Update response
#' @examples
#' \dontrun{
#' # Update multiple items
#' items <- list(
#'   list(key = "KEY1", data = list(title = "New Title 1")),
#'   list(key = "KEY2", data = list(title = "New Title 2"))
#' )
#' result <- update_items_version(client, items, version = 123)
#' }
#' @export
update_items_version <- function(client, items, version) {
  endpoint <- sprintf("/%s/%s/items", client$library_type, client$library_id)
  
  # Add version header for concurrency control
  headers <- list(
    "If-Unmodified-Since-Version" = as.character(version)
  )
  
  make_request(client, endpoint, 
              method = "POST", 
              body = items,
              headers = headers)
} 