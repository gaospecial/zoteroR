% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/items.R
\name{num_all_items}
\alias{num_all_items}
\title{Get total number of all items in the library}
\usage{
num_all_items(client)
}
\arguments{
\item{client}{Zotero API client object}
}
\value{
Integer indicating the total number of items
}
\description{
Get total number of all items in the library
}
\examples{
\dontrun{
client <- zotero_api(
  library_id = "123456",
  library_type = "user",
  api_key = "your_api_key"
)

# Get total number of all items
total <- count_items(client)
}
}
