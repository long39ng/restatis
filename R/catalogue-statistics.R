#' Statistic catalogue
#'
#' Retrieves list of statistics according to selection
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' catalogue_statistics("124*")
#' }
catalogue_statistics <- function(selection,
                                 searchcriterion = c("code", "content"),
                                 sortcriterion = c("code", "content"),
                                 pagelength = 100,
                                 language = "en",
                                 genesis = getOption("genesis")) {
  searchcriterion <- match.arg(searchcriterion)
  sortcriterion <- match.arg(sortcriterion)
  do.call(catalogue_, c(as.list(environment()), method = "statistics"))
}

#' Catalogue of tables related to a statistic
#'
#' Retrieves list of tables based on statistic name
#'
#' @inherit catalogue_variables_by_statistic params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' catalogue_tables_by_statistic("12411")
#' }
catalogue_tables_by_statistic <- function(name,
                                          selection = NULL,
                                          area = c("free", "user", "all"),
                                          pagelength = 100,
                                          language = "en",
                                          genesis = getOption("genesis")) {
  area <- match.arg(area)
  do.call(catalogue_, c(as.list(environment()), method = "tables2statistic"))
}

#' Catalogue of variables related to a statistic
#'
#' Retrieves list of variables based on statistic name
#'
#' @param name Code of the statistic (e.g. retrieved using [catalogue_statistics])
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' catalogue_variables_by_statistic("12411")
#' }
catalogue_variables_by_statistic <- function(name,
                                             selection = NULL,
                                             area = c("free", "user", "all"),
                                             searchcriterion = c("code", "content"),
                                             sortcriterion = c("code", "content"),
                                             pagelength = 100,
                                             language = "en",
                                             genesis = getOption("genesis")) {
  area <- match.arg(area)
  searchcriterion <- match.arg(searchcriterion)
  sortcriterion <- match.arg(sortcriterion)
  do.call(catalogue_, c(as.list(environment()), method = "variables2statistic"))
}
