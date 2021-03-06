% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/catalogue-misc.R
\name{catalogue_terms}
\alias{catalogue_terms}
\title{Term catalogue}
\usage{
catalogue_terms(
  selection,
  pagelength = 100,
  language = getOption("genesis_language"),
  genesis = getOption("genesis")
)
}
\arguments{
\item{selection}{String to filter for the code or content of the object(s) to
be returned. Use of wildcard (*) possible.}

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
Retrieves list of search terms according to selection
}
\examples{
\dontrun{
options(genesis = "destatis")
catalogue_terms("schu*", language = "de")
}
}
