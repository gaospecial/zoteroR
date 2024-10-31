#' Get user groups
#'
#' @description
#' Get all groups that the current API key has access to.
#'
#' @param client Zotero API client object
#' @param limit Maximum number of groups to return
#' @param start Starting position
#'
#' @return A list of groups
#' @examples
#' \dontrun{
#' # Get all accessible groups
#' groups <- get_groups(client)
#' }
#' @export
get_groups <- function(client, limit = 10, start = 0) {
  endpoint <- sprintf("/users/%s/groups", client$library_id)
  
  params <- list(
    limit = limit,
    start = start
  )
  
  make_request(client, endpoint, query = params)
}