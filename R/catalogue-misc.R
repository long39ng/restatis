#' Modified data catalogue
#'
#' Retrieves list of tables according to selection
#'
#' @param date List data that have been made available or updated since this date
#'   ("dd.mm.yyyy")
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_modifieddata(date = format(Sys.Date() - 30, "%d.%m.%Y"))
#' }
catalogue_modifieddata <- function(selection = NULL,
                                   date = "01.01.1970",
                                   pagelength = 100,
                                   language = "en") {
  do.call(catalogue_, c(as.list(environment()), method = "modifieddata"))
}

#' Quality indicator catalogue
#'
#' Retrieves list of quality indicators
#'
#' @inherit catalogue_variables params return
#'
#' @export
catalogue_qualitysigns <- function(language = "en") {
  do.call(catalogue_, c(as.list(environment()), method = "qualitysigns"))
}

#' Table catalogue
#'
#' Retrieves list of tables according to selection
#'
#' @param selection String to filter for the code of the table(s) to be
#'   returned. Use of wildcard (*) possible.
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_tables("124*")
#' }
catalogue_tables <- function(selection,
                             area = c("free", "user", "all"),
                             pagelength = 100,
                             language = "en") {
  area <- match.arg(area)
  do.call(catalogue_, c(as.list(environment()), method = "tables"))
}

#' Term catalogue
#'
#' Retrieves list of search terms according to selection
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_terms("schu*", language = "de")
#' }
catalogue_terms <- function(selection,
                            pagelength = 100,
                            language = "en") {
  do.call(catalogue_, c(as.list(environment()), method = "terms"))
}

#' Value catalogue
#'
#' Retrieves list of values according to selection
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_values("*baden*", searchcriterion = "content")
#' }
catalogue_values <- function(selection,
                             searchcriterion = c("code", "content"),
                             sortcriterion = c("code", "content"),
                             pagelength = 100,
                             language = "en") {
  searchcriterion <- match.arg(searchcriterion)
  sortcriterion <- match.arg(sortcriterion)
  do.call(catalogue_, c(as.list(environment()), method = "values"))
}

catalogue_ <- function(method,
                       name = NULL,
                       selection = NULL,
                       area = NULL,
                       searchcriterion = NULL,
                       sortcriterion = NULL,
                       date = NULL,
                       pagelength = NULL,
                       language = NULL) {
  check_str_len1(name)
  check_str_len1(selection)
  check_str_len1(date)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    selection = selection,
    area = area,
    searchcriterion = searchcriterion,
    sortcriterion = sortcriterion,
    date = date,
    pagelength = pagelength,
    language = language
  )

  make_genesis_tbl(genesis_api(paste0("catalogue/", method), query), "List")
}
