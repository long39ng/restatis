% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find.R
\name{search_tables}
\alias{search_tables}
\alias{search_statistics}
\alias{search_variables}
\title{Find statistics, tables or values}
\usage{
search_tables(
  term,
  pagelength = 100,
  language = getOption("genesis_language"),
  genesis = getOption("genesis")
)

search_statistics(
  term,
  pagelength = 100,
  language = getOption("genesis_language"),
  genesis = getOption("genesis")
)

search_variables(
  term,
  pagelength = 100,
  language = getOption("genesis_language"),
  genesis = getOption("genesis")
)
}
\arguments{
\item{term}{Term to search for}

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
Retrieves lists of objects for a search term
(statistics, tables or variables)
}
\examples{
\dontrun{
options(genesis = "destatis")
search_statistics("Abfall", pagelength = 6, language = "de")

search_variables("vote")
}
}
\seealso{
catalogue_terms
}
