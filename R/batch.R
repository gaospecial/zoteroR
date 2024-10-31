#' Get a subset of items by their keys
#'
#' @description
#' Retrieve multiple items in a single request by providing their keys.
#'
#' @param client Zotero API client object
#' @param item_keys Vector of item keys
#'
#' @return A list of items
#' @examples
#' \dontrun{
#' # Get specific items
#' items <- get_item_subset(client, c("KEY1", "KEY2", "KEY3"))
#' }
#' @export
get_item_subset <- function(client, item_keys) {
  if (length(item_keys) > 50) {
    stop("You may only retrieve up to 50 items per call")
  }
  
  endpoint <- sprintf("/%s/%s/items", 
                     client$library_type, 
                     client$library_id)
  
  params <- list(
    itemKey = paste(item_keys, collapse = ",")
  )
  
  make_request(client, endpoint, query = params)
}

#' Get all items in the library
#'
#' @description
#' Retrieve all items in the library by making multiple requests if necessary.
#'
#' @param client Zotero API client object
#' @param chunk_size Number of items to retrieve per request
#'
#' @return A list of all items
#' @examples
#' \dontrun{
#' # Get all items
#' all_items <- get_all_items(client)
#' }
#' @export
get_all_items <- function(client, chunk_size = 100) {
  # Get total number of items
  total <- num_all_items(client)
  
  # Initialize result list
  all_items <- list()
  
  # Fetch items in chunks
  for (start in seq(0, total - 1, by = chunk_size)) {
    chunk <- get_items(client, limit = chunk_size, start = start)
    all_items <- c(all_items, chunk)
  }
  
  all_items
}

#' Get all collections in the library
#'
#' @description
#' Retrieve all collections and their subcollections recursively.
#'
#' @param client Zotero API client object
#' @param collection_key Optional. Start from a specific collection
#'
#' @return A list of all collections
#' @examples
#' \dontrun{
#' # Get all collections
#' all_collections <- get_all_collections(client)
#' 
#' # Get all collections under a specific collection
#' sub_collections <- get_all_collections(client, "COLLECTION_KEY")
#' }
#' @export
get_all_collections <- function(client, collection_key = NULL) {
  all_collections <- list()
  
  # Function to recursively get collections
  get_collections_recursive <- function(key = NULL) {
    # Get current level collections
    if (is.null(key)) {
      collections <- get_collections_top(client)
    } else {
      collections <- get_subcollections(client, key)
    }
    
    # Add to result list
    all_collections <<- c(all_collections, collections)
    
    # Recursively get subcollections
    for (coll in collections) {
      if (coll$meta$numCollections > 0) {
        get_collections_recursive(coll$key)
      }
    }
  }
  
  # Start recursion
  get_collections_recursive(collection_key)
  
  all_collections
} 