% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zotero_api.R
\name{zotero_client}
\alias{zotero_client}
\title{Zotero API Client}
\usage{
zotero_client(
  library_id,
  library_type = c("user", "group"),
  api_key,
  locale = "en-US"
)
}
\arguments{
\item{library_id}{User ID or group ID}

\item{library_type}{Library type, either "user" or "group"}

\item{api_key}{Zotero API key}

\item{locale}{Locale for API responses, defaults to "en-US"}
}
\description{
Create a new Zotero API client instance
}
\examples{
\dontrun{
# Create a client for personal library
client <- zotero_client(
  library_id = Sys.getenv("ZOTERO_USER_ID"),
  library_type = "user",
  api_key = Sys.getenv("ZOTERO_API_KEY")
)
}
}
