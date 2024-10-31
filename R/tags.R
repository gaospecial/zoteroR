#' Get all tags from Zotero library
#'
#' @param client Zotero API client object
#' @param limit Maximum number of tags to return
#' @param start Starting position
#'
#' @return A list containing all tags
#' @examples
#' \dontrun{
#' client <- zotero_client(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get all tags
#' tags <- get_tags(client)
#' }
#' @export
get_tags <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/tags", client$library_type, client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get tags matching a specific name
#'
#' @param client Zotero API client object
#' @param tag_name Tag name to search for
#'
#' @return A list containing matching tags
#' @examples
#' \dontrun{
#' # Get specific tag
#' tags <- get_tag(client, "machine learning")
#' }
#' @export
get_tag <- function(client, tag_name) {
  endpoint <- sprintf("/%s/%s/tags/%s", 
                     client$library_type, 
                     client$library_id,
                     utils::URLencode(tag_name, reserved = TRUE))
  
  make_request(client, endpoint)
}

#' Get tags for a specific item
#'
#' @param client Zotero API client object
#' @param item_key Item key
#'
#' @return A list containing item tags
#' @examples
#' \dontrun{
#' # Get item tags
#' tags <- get_item_tags(client, "ITEM_KEY")
#' }
#' @export
get_item_tags <- function(client, item_key) {
  endpoint <- sprintf("/%s/%s/items/%s/tags", 
                     client$library_type, 
                     client$library_id,
                     item_key)
  
  make_request(client, endpoint)
}

#' Get tags within a specific collection
#'
#' @param client Zotero API client object
#' @param collection_key Collection key
#'
#' @return A list containing collection tags
#' @examples
#' \dontrun{
#' # Get collection tags
#' tags <- get_collection_tags(client, "COLLECTION_KEY")
#' }
#' @export
get_collection_tags <- function(client, collection_key) {
  endpoint <- sprintf("/%s/%s/collections/%s/tags", 
                     client$library_type, 
                     client$library_id,
                     collection_key)
  
  make_request(client, endpoint)
}

#' Get all item tags with filtering options
#'
#' @param client Zotero API client object
#' @param limit Maximum number of tags to return
#' @param start Starting position
#'
#' @return A list containing filtered tags
#' @examples
#' \dontrun{
#' # Get all item tags
#' tags <- get_items_tags(client)
#' }
#' @export
get_items_tags <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/items/tags", 
                     client$library_type, 
                     client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get tags for top-level items
#'
#' @param client Zotero API client object
#' @param limit Maximum number of tags to return
#' @param start Starting position
#'
#' @return A list containing top-level item tags
#' @examples
#' \dontrun{
#' # Get top-level item tags
#' tags <- get_items_top_tags(client)
#' }
#' @export
get_items_top_tags <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/items/top/tags", 
                     client$library_type, 
                     client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get tags for items in trash
#'
#' @param client Zotero API client object
#' @param limit Maximum number of tags to return
#' @param start Starting position
#'
#' @return A list containing trash item tags
#' @examples
#' \dontrun{
#' # Get trash item tags
#' tags <- get_items_trash_tags(client)
#' }
#' @export
get_items_trash_tags <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/items/trash/tags", 
                     client$library_type, 
                     client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get tags for items in a collection
#'
#' @param client Zotero API client object
#' @param collection_key Collection key
#' @param limit Maximum number of tags to return
#' @param start Starting position
#'
#' @return A list containing collection item tags
#' @examples
#' \dontrun{
#' # Get collection item tags
#' tags <- get_collection_items_tags(client, "COLLECTION_KEY")
#' }
#' @export
get_collection_items_tags <- function(client, collection_key, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/collections/%s/items/tags", 
                     client$library_type, 
                     client$library_id,
                     collection_key)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get tags for top-level items in a collection
#'
#' @param client Zotero API client object
#' @param collection_key Collection key
#' @param limit Maximum number of tags to return
#' @param start Starting position
#'
#' @return A list containing collection top-level item tags
#' @examples
#' \dontrun{
#' # Get collection top-level item tags
#' tags <- get_collection_items_top_tags(client, "COLLECTION_KEY")
#' }
#' @export
get_collection_items_top_tags <- function(client, collection_key, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/collections/%s/items/top/tags", 
                     client$library_type, 
                     client$library_id,
                     collection_key)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get tags for items in My Publications
#'
#' @param client Zotero API client object
#' @param limit Maximum number of tags to return
#' @param start Starting position
#'
#' @return A list containing publication item tags
#' @examples
#' \dontrun{
#' # Get publication item tags
#' tags <- get_publications_tags(client)
#' }
#' @export
get_publications_tags <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/publications/items/tags", 
                     client$library_type, 
                     client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
} 