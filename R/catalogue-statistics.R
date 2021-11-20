#' Statistics catalogue
#'
#' Retrieves list of statistics according to selection
#'
#' @inherit catalogue_variables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_statistics("124*")
#' }
catalogue_statistics <- function(selection,
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

  make_df(genesis_api("catalogue/statistics", query), "List")
}

#' Catalogue of data cubes related to a statistic
#'
#' Retrieves list of data cubes based on statistic name
#'
#' @inherit catalogue_variables_by_statistic params return
#'
#' @noRd
#'
#' @examples
#' \dontrun{
#' catalogue_cubes_by_statistic("12411")
#' }
catalogue_cubes_by_statistic <- function(name,
                                         selection = NULL,
                                         area = c("free", "user", "all"),
                                         pagelength = 100,
                                         language = "en") {
  check_str_len1(name)
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    selection = selection,
    area = match.arg(area),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/cubes2statistic", query), "List")
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
#' catalogue_tables_by_statistic("12411")
#' }
catalogue_tables_by_statistic <- function(name,
                                          selection = NULL,
                                          area = c("free", "user", "all"),
                                          pagelength = 100,
                                          language = "en") {
  check_str_len1(name)
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    selection = selection,
    area = match.arg(area),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/tables2statistic", query), "List")
}

#' Catalogue of time series related to a statistic
#'
#' Retrieves list of time series based on statistic name
#'
#' @inherit catalogue_variables_by_statistic params return
#'
#' @noRd
#'
#' @examples
#' \dontrun{
#' catalogue_timeseries_by_statistic("12411")
#' }
catalogue_timeseries_by_statistic <- function(name,
                                              selection = NULL,
                                              area = c("free", "user", "all"),
                                              pagelength = 100,
                                              language = "en") {
  check_str_len1(name)
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    selection = selection,
    area = match.arg(area),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/timeseries2statistic", query), "List")
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
#' catalogue_variables_by_statistic("12411")
#' }
catalogue_variables_by_statistic <- function(name,
                                             selection = NULL,
                                             area = c("free", "user", "all"),
                                             searchcriterion = c("code", "content"),
                                             sortcriterion = c("code", "content"),
                                             pagelength = 100,
                                             language = "en") {
  check_str_len1(name)
  check_str_len1(selection)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    selection = selection,
    area = match.arg(area),
    searchcriterion = match.arg(searchcriterion),
    sortcriterion = match.arg(sortcriterion),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("catalogue/variables2statistic", query), "List")
}
