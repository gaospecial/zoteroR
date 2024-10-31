#' Get collections from Zotero library
#'
#' @param client Zotero API client object
#' @param limit Maximum number of collections to return
#' @param start Starting position
#'
#' @return A list containing all collections
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get all collections
#' collections <- get_collections(client)
#' }
#' @export
get_collections <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/collections", client$library_type, client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get top-level collections from Zotero library
#'
#' @param client Zotero API client object
#' @param limit Maximum number of collections to return
#' @param start Starting position
#'
#' @return A list containing top-level collections
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get top-level collections
#' top_collections <- get_collections_top(client)
#' }
#' @export
get_collections_top <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/collections/top", client$library_type, client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get a specific collection from Zotero library
#'
#' @param client Zotero API client object
#' @param collection_key Collection key
#'
#' @return A list containing the specified collection
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get specific collection
#' collection <- get_collection(client, "COLLECTION_KEY")
#' }
#' @export
get_collection <- function(client, collection_key) {
  endpoint <- sprintf("/%s/%s/collections/%s", 
                     client$library_type, 
                     client$library_id,
                     collection_key)
  
  make_request(client, endpoint)
}

#' Get subcollections of a specific collection
#'
#' @param client Zotero API client object
#' @param collection_key Parent collection key
#' @param limit Maximum number of subcollections to return
#' @param start Starting position
#'
#' @return A list containing subcollections
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get subcollections
#' subcollections <- get_subcollections(client, "PARENT_COLLECTION_KEY")
#' }
#' @export
get_subcollections <- function(client, collection_key, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/collections/%s/collections", 
                     client$library_type, 
                     client$library_id,
                     collection_key)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Create a new collection in Zotero library
#'
#' @param client Zotero API client object
#' @param name Name of the new collection
#' @param parent_key Optional. Key of the parent collection
#'
#' @return Response from the API containing the new collection details
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Create a new top-level collection
#' new_collection <- create_collection(client, name = "My New Collection")
#' 
#' # Create a sub-collection
#' sub_collection <- create_collection(
#'   client,
#'   name = "Sub Collection",
#'   parent_key = "PARENT_COLLECTION_KEY"
#' )
#' }
#' @export
create_collection <- function(client, name, parent_key = NULL) {
  endpoint <- sprintf("/%s/%s/collections", client$library_type, client$library_id)
  
  body <- list(
    name = name,
    parentCollection = parent_key
  )
  
  make_request(client, endpoint, method = "POST", body = body)
}

#' Delete a collection from Zotero library
#'
#' @param client Zotero API client object
#' @param collection_key Key of the collection to delete
#'
#' @return NULL on success
#' @examples
#' \dontrun{
#' client <- zotero_api(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Delete a collection
#' delete_collection(client, collection_key = "COLLECTION_KEY")
#' }
#' @export
delete_collection <- function(client, collection_key) {
  endpoint <- sprintf("/%s/%s/collections/%s", 
                     client$library_type, 
                     client$library_id, 
                     collection_key)
  
  make_request(client, endpoint, method = "DELETE")
} 