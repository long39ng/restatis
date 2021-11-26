#' Variable catalogue
#'
#' Retrieves list of variables according to selection
#'
#' @param selection String to filter for the code or content of the object(s) to
#'   be returned. Use of wildcard (*) possible.
#' @param area Area in which the object is stored:
#'
#'   - "free" = objects in the public catalogue
#'   - "user" = objects saved to "Meine Tabellen"
#' @param searchcriterion Does `selection` refer to the code or the content of the object(s)?
#' @param sortcriterion Should the results be sorted by the code or the content of the object(s)?
#'
#' @inherit search_tables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' catalogue_variables("FA*")
#' }
catalogue_variables <- function(selection,
                                area = c("free", "user", "all"),
                                searchcriterion = c("code", "content"),
                                sortcriterion = c("code", "content"),
                                pagelength = 100,
                                language = getOption("genesis_language"),
                                genesis = getOption("genesis")) {
  area <- match.arg(area)
  searchcriterion <- match.arg(searchcriterion)
  sortcriterion <- match.arg(sortcriterion)
  do.call(catalogue_, c(as.list(environment()), method = "variables"))
}

#' Catalogue of statistics related to a variable
#'
#' Retrieves list of statistics based on variable name
#'
#' @param name Code of the variable (e.g. retrieved using [catalogue_variables])
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' catalogue_statistics_by_variable("KREISE")
#' }
catalogue_statistics_by_variable <- function(name,
                                             selection = NULL,
                                             area = c("free", "user", "all"),
                                             searchcriterion = c("code", "content"),
                                             sortcriterion = c("code", "content"),
                                             pagelength = 100,
                                             language = getOption("genesis_language"),
                                             genesis = getOption("genesis")) {
  area <- match.arg(area)
  searchcriterion <- match.arg(searchcriterion)
  sortcriterion <- match.arg(sortcriterion)
  do.call(catalogue_, c(as.list(environment()), method = "statistics2variable"))
}

#' Catalogue of tables related to a variable
#'
#' Retrieves list of tables based on variable name
#'
#' @inherit catalogue_statistics_by_variable params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' catalogue_tables_by_variable("KREISE")
#' }
catalogue_tables_by_variable <- function(name,
                                         selection = NULL,
                                         area = c("free", "user", "all"),
                                         pagelength = 100,
                                         language = getOption("genesis_language"),
                                         genesis = getOption("genesis")) {
  area <- match.arg(area)
  do.call(catalogue_, c(as.list(environment()), method = "tables2variable"))
}

#' Catalogue of values related to a variable
#'
#' Retrieves list of values based on variable name
#'
#' @inherit catalogue_statistics_by_variable params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' catalogue_values_by_variable("KREISE", pagelength = 1000)
#' }
catalogue_values_by_variable <- function(name,
                                         selection = NULL,
                                         area = c("free", "user", "all"),
                                         searchcriterion = c("code", "content"),
                                         sortcriterion = c("code", "content"),
                                         pagelength = 100,
                                         language = getOption("genesis_language"),
                                         genesis = getOption("genesis")) {
  area <- match.arg(area)
  searchcriterion <- match.arg(searchcriterion)
  sortcriterion <- match.arg(sortcriterion)
  do.call(catalogue_, c(as.list(environment()), method = "values2variable"))
}
