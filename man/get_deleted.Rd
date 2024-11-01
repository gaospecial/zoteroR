% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/syncing.R
\name{get_deleted}
\alias{get_deleted}
\title{Get deleted content since a specific version}
\usage{
get_deleted(client, since)
}
\arguments{
\item{client}{Zotero API client object}

\item{since}{Version number to check from}
}
\value{
List of deleted items, searches, collections, and tags
}
\description{
Get all items, collections, searches, and tags that have been deleted since
a specific version.
}
\examples{
\dontrun{
# Get items deleted since version 1234
deleted <- get_deleted(client, since = 1234)
}
}
