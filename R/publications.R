#' Get items from My Publications
#'
#' @description
#' Get items from the user's My Publications collection.
#'
#' @param client Zotero API client object
#' @param limit Maximum number of items to return
#' @param start Starting position
#'
#' @return A list of publication items
#' @examples
#' \dontrun{
#' # Get publications
#' publications <- get_publications(client)
#' }
#' @export
get_publications <- function(client, limit = 10, start = 0) {
  if (client$library_type != "users") {
    stop("My Publications is only available for user libraries")
  }
  
  endpoint <- sprintf("/%s/%s/publications/items", 
                     client$library_type, 
                     client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
} 