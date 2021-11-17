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
#' @inherit find_tables params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_variables("FA*")
#' }
catalogue_variables <- function(selection,
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

  make_df(genesis_api("catalogue/variables", query), "List")
}

#' Catalogue of data cubes related to a variable
#'
#' Retrieves list of data cubes based on variable name (not exported because service unavailable)
#'
#' @inherit catalogue_statistics2variable params return
#'
#' @noRd
#'
#' @examples
#' \dontrun{
#' catalogue_cubes2variable("KREISE")
#' }
catalogue_cubes2variable <- function(name,
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

  make_df(genesis_api("catalogue/cubes2variable", query), "List")
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
#' catalogue_statistics2variable("KREISE")
#' }
catalogue_statistics2variable <- function(name,
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

  make_df(genesis_api("catalogue/statistics2variable", query), "List")
}

#' Catalogue of tables related to a variable
#'
#' Retrieves list of tables based on variable name
#'
#' @inherit catalogue_statistics2variable params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_tables2variable("KREISE")
#' }
catalogue_tables2variable <- function(name,
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

  make_df(genesis_api("catalogue/tables2variable", query), "List")
}

#' Catalogue of time series related to a variable
#'
#' Retrieves list of time series based on variable name
#'
#' @inherit catalogue_statistics2variable params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_timeseries2variable("KREISE")
#' }
catalogue_timeseries2variable <- function(name,
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

  make_df(genesis_api("catalogue/timeseries2variable", query), "List")
}

#' Catalogue of values related to a variable
#'
#' Retrieves list of values based on variable name
#'
#' @inherit catalogue_statistics2variable params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' catalogue_values2variable("KREISE")
#' }
catalogue_values2variable <- function(name,
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

  make_df(genesis_api("catalogue/values2variable", query), "List")
}
