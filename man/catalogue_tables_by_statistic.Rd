% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/catalogue-statistics.R
\name{catalogue_tables_by_statistic}
\alias{catalogue_tables_by_statistic}
\title{Catalogue of tables related to a statistic}
\usage{
catalogue_tables_by_statistic(
  name,
  selection = NULL,
  area = c("free", "user", "all"),
  pagelength = 100,
  language = getOption("genesis_language"),
  genesis = getOption("genesis")
)
}
\arguments{
\item{name}{Code of the statistic (e.g. retrieved using \link{catalogue_statistics})}

\item{selection}{String to filter for the code or content of the object(s) to
be returned. Use of wildcard (*) possible.}

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
Retrieves list of tables based on statistic name
}
\examples{
\dontrun{
options(genesis = "destatis")
catalogue_tables_by_statistic("12411")
}
}
