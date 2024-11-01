% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tags.R
\name{get_tag}
\alias{get_tag}
\title{Get tags matching a specific name}
\usage{
get_tag(client, tag_name)
}
\arguments{
\item{client}{Zotero API client object}

\item{tag_name}{Tag name to search for}
}
\value{
A list containing matching tags
}
\description{
Get tags matching a specific name
}
\examples{
\dontrun{
# Get specific tag
tags <- get_tag(client, "machine learning")
}
}
