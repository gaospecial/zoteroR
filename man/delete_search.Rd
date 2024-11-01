% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/searches.R
\name{delete_search}
\alias{delete_search}
\title{Delete a saved search from Zotero library}
\usage{
delete_search(client, search_key)
}
\arguments{
\item{client}{Zotero API client object}

\item{search_key}{Key of the saved search to delete}
}
\value{
NULL on success
}
\description{
Delete a saved search from Zotero library
}
\examples{
\dontrun{
client <- zotero_client(
  library_id = "123456",
  library_type = "user",
  api_key = "your_api_key"
)

# Delete a saved search
delete_search(client, search_key = "SEARCH_KEY")
}
}
