% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/catalogue-statistics.R
\name{catalogue_statistics}
\alias{catalogue_statistics}
\title{Statistic catalogue}
\usage{
catalogue_statistics(
  selection,
  searchcriterion = c("code", "content"),
  sortcriterion = c("code", "content"),
  pagelength = 100,
  language = getOption("genesis_language"),
  genesis = getOption("genesis")
)
}
\arguments{
\item{selection}{String to filter for the code or content of the object(s) to
be returned. Use of wildcard (*) possible.}

\item{searchcriterion}{Does \code{selection} refer to the code or the content of the object(s)?}

\item{sortcriterion}{Should the results be sorted by the code or the content of the object(s)?}

\item{pagelength}{Maximum number of results delivered}

\item{language}{Search terms, returned messages and data descriptions
in German ("de") or English ("en")?

A default value can also be set to the global option \code{genesis_language} via
\code{\link[=options]{options()}}, e.g. \code{options(genesis_language = "de")}.}

\item{genesis}{Which GENESIS database should be used?

One of: "destatis", "regionalstatistik", "bildungsmonitoring", "bayern", "nrw", "sachsen-anhalt".

A default value can also be set to the global option \code{genesis} via
\code{\link[=options]{options()}}, e.g. \code{options(genesis = "destatis")}, so that \code{genesis}
does not have to be specified in the function call.}
}
\value{
A \code{data.frame} (or \code{tbl_df} if tibble package is installed)
}
\description{
Retrieves list of statistics according to selection
}
\examples{
\dontrun{
options(genesis = "destatis")
catalogue_statistics("124*")
}
}
