% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/auth.R
\name{set_login_data}
\alias{set_login_data}
\title{Set your username and password}
\usage{
set_login_data(genesis = getOption("genesis"))
}
\arguments{
\item{genesis}{Which GENESIS database should be used?

One of: "destatis", "regionalstatistik", "bildungsmonitoring", "bayern", "nrw", "sachsen-anhalt".

A default value can also be set to the global option \code{genesis} via
\code{\link[=options]{options()}}, e.g. \code{options(genesis = "destatis")}, so that \code{genesis}
does not have to be specified in the function call.}
}
\description{
Saves the login data for a GENESIS web service
}
\details{
Login data are stored with the \link[=keyring-package]{keyring} package.
Run \code{\link[keyring:key_get]{keyring::key_list()}} to get an overview of the stored credentials.
}
\seealso{
\code{\link{login_check}}
}
