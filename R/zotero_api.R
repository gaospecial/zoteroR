#' Zotero API Client
#'
#' @description
#' Create a new Zotero API client instance
#'
#' @param library_id User ID or group ID
#' @param library_type Library type, either "user" or "group"
#' @param api_key Zotero API key
#' @param locale Locale for API responses, defaults to "en-US"
#'
#' @examples
#' \dontrun{
#' # Create a client for personal library
#' client <- zotero_client(
#'   library_id = Sys.getenv("ZOTERO_USER_ID"),
#'   library_type = "user",
#'   api_key = Sys.getenv("ZOTERO_API_KEY")
#' )
#' }
#' @export
zotero_client <- function(library_id, 
                      library_type = c("user", "group"), 
                      api_key,
                      locale = "en-US") {
  library_type <- match.arg(library_type)
  
  # Add 's' to make plural form for API path
  library_type <- paste0(library_type, "s")
  
  structure(
    list(
      library_id = library_id,
      library_type = library_type,  # Now will be "users" or "groups"
      api_key = api_key,
      locale = locale,
      base_url = "https://api.zotero.org"
    ),
    class = "zotero_api"
  )
}

#' Make a request to Zotero API
#'
#' @param client Zotero API client object
#' @param endpoint API endpoint
#' @param method HTTP method
#' @param query Query parameters
#' @param body Request body
#' @param format Response format, defaults to "json"
#'
#' @importFrom httr GET POST PUT DELETE add_headers content stop_for_status headers
#' @importFrom jsonlite fromJSON toJSON
#' @keywords internal
make_request <- function(client, endpoint, method = "GET", 
                        query = list(), body = NULL, 
                        format = "json") {
  url <- file.path(client$base_url, endpoint)
  
  # Add default query parameters
  query$format <- format
  query$locale <- client$locale
  query$v <- 3  # API version
  
  # Remove NULL query parameters
  query <- query[!sapply(query, is.null)]
  
  # Create headers according to API docs
  api_headers <- httr::add_headers(
    "Zotero-API-Version" = "3",
    "User-Agent" = "zoteroR - R client for Zotero API"
  )
  
  # Add authorization if API key is provided
  if (!is.null(client$api_key)) {
    api_headers <- c(
      api_headers,
      httr::add_headers("Authorization" = paste("Bearer", client$api_key))
    )
  }
  
  # Make the request
  response <- switch(
    method,
    GET = httr::GET(url, 
                    api_headers, 
                    query = query),
    POST = httr::POST(url, 
                     api_headers, 
                     body = body,
                     encode = "json",
                     query = query),
    PUT = httr::PUT(url, 
                    api_headers, 
                    body = body,
                    encode = "json",
                    query = query),
    DELETE = httr::DELETE(url, 
                         api_headers,
                         query = query)
  )
  
  # Check for errors
  httr::stop_for_status(response)
  
  # For count functions, return the total directly
  if (!is.null(query$limit) && query$limit == 1 && 
      !is.null(response$headers[["total-results"]])) {
    return(as.integer(response$headers[["total-results"]]))
  }
  
  # Handle response based on format
  if (format == "json") {
    content <- httr::content(response, "text", encoding = "UTF-8")
    if (content != "") {
      return(jsonlite::fromJSON(content, simplifyVector = FALSE))
    }
    return(NULL)
  }
  
  # Return raw response for other formats
  response
}
