#' Get items from Zotero library
#'
#' @param client Zotero API client object
#' @param limit Maximum number of items to return
#' @param start Starting position
#' @param query Search query
#' @param collection_key Optional. Get items from specific collection
#' @param tag Optional. Filter items by tag
#'
#' @return A tibble containing Zotero items with flattened structure
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get all items (maximum 100)
#' items <- get_items(client)
#' }
#' @export
get_items <- function(client, limit = 10, start = 0, query = NULL,
                     collection_key = NULL, tag = NULL) {
  
  # Build endpoint based on collection
  endpoint <- if (!is.null(collection_key)) {
    sprintf("/%s/%s/collections/%s/items",
            client$library_type,
            client$library_id,
            collection_key)
  } else {
    sprintf("/%s/%s/items",
            client$library_type,
            client$library_id)
  }
  
  params <- list(
    limit = limit,
    start = start,
    q = query,
    tag = tag
  )
  
  # Remove NULL parameters
  params <- params[!sapply(params, is.null)]
  
  response <- make_request(client, endpoint, query = params)
  dplyr::as_tibble(response)
}

#' Get total number of top-level items in the library
#'
#' @param client Zotero API client object
#'
#' @return Integer indicating the total number of top-level items
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get total number of top-level items
#' total <- num_items(client)
#' }
#' @export
num_top_items <- function(client) {
  endpoint <- sprintf("/%s/%s/items/top", client$library_type, client$library_id)
  make_request(client, endpoint, query = list(limit = 1))
}

#' Get total number of all items in the library
#'
#' @param client Zotero API client object
#'
#' @return Integer indicating the total number of items
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get total number of all items
#' total <- count_items(client)
#' }
#' @export
num_all_items <- function(client) {
  endpoint <- sprintf("/%s/%s/items", client$library_type, client$library_id)
  response <- make_request(client, endpoint, query = list(limit = 1))
  as.integer(response)
}



#' Get a specific item by key
#'
#' @param client Zotero API client object
#' @param item_key Item key
#'
#' @return A tibble with item details
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get specific item
#' item <- item(client, "ITEM_KEY")
#' }
#' @export
item <- function(client, item_key) {
  endpoint <- sprintf("/%s/%s/items/%s", 
                     client$library_type, 
                     client$library_id,
                     item_key)
  
  response <- make_request(client, endpoint)
  dplyr::as_tibble(list(response))
}

#' Get child items of a specific item
#'
#' @param client Zotero API client object
#' @param item_key Parent item key
#'
#' @return A tibble of child items
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get child items
#' children <- children(client, "PARENT_ITEM_KEY")
#' }
#' @export
children <- function(client, item_key) {
  endpoint <- sprintf("/%s/%s/items/%s/children", 
                     client$library_type, 
                     client$library_id,
                     item_key)
  
  response <- make_request(client, endpoint)
  dplyr::as_tibble(response)
}

#' Get items in trash
#'
#' @param client Zotero API client object
#' @param limit Maximum number of items to return
#' @param start Starting position
#'
#' @return A tibble of items in trash
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get items in trash
#' trash_items <- trash(client)
#' }
#' @export
trash <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/items/trash", client$library_type, client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  response <- make_request(client, endpoint, query = params)
  dplyr::as_tibble(response)
} 