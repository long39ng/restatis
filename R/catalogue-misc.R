#' Data cube catalogue
#'
#' Retrieves list of data cubes according to selection (not exported because service unavailable)
#'
#' @inherit catalogue_variables params return
#'
#' @noRd
#'
#' @examples
#' \dontrun{
#' catalogue_cubes("124*")
#' }
catalogue_cubes <- function(selection,
                            area = c("free", "user", "all"),
                            searchcriterion = c("code", "content"),
                            sortcriterion = c("code", "content"),
                            pagelength = 100,
                            language = "en") {
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    selection = selection,
    area = match.arg(area),
    searchcriterion = match.arg(searchcriterion),
    sortcriterion = match.arg(sortcriterion),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/cubes", query), "List")
}

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
  check_str_len1(selection)
  check_str_len1(date)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    selection = selection,
    date = date,
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/modifieddata", query), "List")
}

#' Quality indicator catalogue
#'
#' Retrieves list of quality indicators
#'
#' @inherit catalogue_variables params return
#'
#' @export
catalogue_qualitysigns <- function(language = "en") {
  check_language(language)

  query <- list(language = language)

  make_df(genesis_api("catalogue/qualitysigns", query), "List")
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
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    selection = selection,
    area = match.arg(area),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/tables", query), "List")
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
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    selection = selection,
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/terms", query), "List")
}

#' Time series catalogue
#'
#' Retrieves list of time series according to selection
#'
#' @param selection String to filter for the code of the time series to be
#'   returned. Use of wildcard (*) possible.
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_timeseries("21*")
#' }
catalogue_timeseries <- function(selection,
                                 area = c("free", "user", "all"),
                                 pagelength = 100,
                                 language = "en") {
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    selection = selection,
    area = match.arg(area),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/timeseries", query), "List")
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
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    selection = selection,
    searchcriterion = match.arg(searchcriterion),
    sortcriterion = match.arg(sortcriterion),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/values", query), "List")
}
