#' Get all saved searches from Zotero library
#'
#' @param client Zotero API client object
#' @param limit Maximum number of searches to return
#' @param start Starting position
#'
#' @return A list containing all saved searches
#' @examples
#' \dontrun{
#' client <- zotero_client(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get all saved searches
#' searches <- get_searches(client)
#' }
#' @export
get_searches <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/%s/%s/searches", client$library_type, client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}

#' Get a specific saved search from Zotero library
#'
#' @param client Zotero API client object
#' @param search_key Search key
#'
#' @return A list containing the specified saved search
#' @examples
#' \dontrun{
#' client <- zotero_client(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Get specific saved search
#' search <- get_search(client, "SEARCH_KEY")
#' }
#' @export
get_search <- function(client, search_key) {
  endpoint <- sprintf("/%s/%s/searches/%s", 
                     client$library_type, 
                     client$library_id,
                     search_key)
  
  make_request(client, endpoint)
}

#' Create a new saved search in Zotero library
#'
#' @param client Zotero API client object
#' @param name Name of the saved search
#' @param conditions List of search conditions. Each condition should be a list with
#'        'condition', 'operator', and 'value' elements
#'
#' @return Response from the API containing the new saved search details
#' @examples
#' \dontrun{
#' client <- zotero_client(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Create a new saved search
#' conditions <- list(
#'   list(
#'     condition = "title",
#'     operator = "contains",
#'     value = "machine learning"
#'   ),
#'   list(
#'     condition = "itemType",
#'     operator = "is",
#'     value = "journalArticle"
#'   )
#' )
#' 
#' new_search <- create_search(
#'   client, 
#'   name = "ML Articles",
#'   conditions = conditions
#' )
#' }
#' @export
create_search <- function(client, name, conditions) {
  endpoint <- sprintf("/%s/%s/searches", client$library_type, client$library_id)
  
  body <- list(
    name = name,
    conditions = conditions
  )
  
  make_request(client, endpoint, method = "POST", body = body)
}

#' Delete a saved search from Zotero library
#'
#' @param client Zotero API client object
#' @param search_key Key of the saved search to delete
#'
#' @return NULL on success
#' @examples
#' \dontrun{
#' client <- zotero_client(
#'   library_id = "123456",
#'   library_type = "user",
#'   api_key = "your_api_key"
#' )
#' 
#' # Delete a saved search
#' delete_search(client, search_key = "SEARCH_KEY")
#' }
#' @export
delete_search <- function(client, search_key) {
  endpoint <- sprintf("/%s/%s/searches/%s", 
                     client$library_type, 
                     client$library_id, 
                     search_key)
  
  make_request(client, endpoint, method = "DELETE")
} 