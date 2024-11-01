% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/searches.R
\name{get_searches}
\alias{get_searches}
\title{Get all saved searches from Zotero library}
\usage{
get_searches(client, limit = 10, start = 0)
}
\arguments{
\item{client}{Zotero API client object}

\item{limit}{Maximum number of searches to return}

\item{start}{Starting position}
}
\value{
A list containing all saved searches
}
\description{
Get all saved searches from Zotero library
}
\examples{
\dontrun{
client <- zotero_client(
  library_id = "123456",
  library_type = "user",
  api_key = "your_api_key"
)

# Get all saved searches
searches <- get_searches(client)
}
}
