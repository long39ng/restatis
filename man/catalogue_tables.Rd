% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/catalogue-misc.R
\name{catalogue_tables}
\alias{catalogue_tables}
\title{Table catalogue}
\usage{
catalogue_tables(
  selection,
  area = c("free", "user", "all"),
  pagelength = 100,
  language = getOption("genesis_language"),
  genesis = getOption("genesis")
)
}
\arguments{
\item{selection}{String to filter for the code of the table(s) to be
returned. Use of wildcard (*) possible.}

\item{area}{Area in which the object is stored:
\itemize{
\item "free" = objects in the public catalogue
\item "user" = objects saved to "Meine Tabellen"
}}

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
Retrieves list of tables according to selection
}
\examples{
\dontrun{
options(genesis = "destatis")
catalogue_tables("124*")
}
}
