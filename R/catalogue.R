#' Data cube catalogue
#'
#' Retrieve list of data cubes according to selection (not exported because service unavailable)
#'
#' @inherit catalogue_variables params return
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

  res <- genesis_api("catalogue/cubes", query)

  make_df(res$content, "List")
}

#' Quality indicator catalogue
#'
#' Retrieve list of quality indicators
#'
#' @inherit catalogue_variables params return
#'
#' @export
catalogue_qualitysigns <- function(language = "en") {
  check_language(language)

  query <- list(language = language)

  res <- genesis_api("catalogue/qualitysigns", query)

  make_df(res$content, "List")
}

#' Variable catalogue
#'
#' Retrieve list of statistics according to selection
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

  res <- genesis_api("catalogue/statistics", query)

  make_df(res$content, "List")
}

#' Table catalogue
#'
#' Retrieve list of tables according to selection
#'
#' @param selection Code of the table(s) to be returned. Use of wildcard (*) possible.
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

  res <- genesis_api("catalogue/tables", query)

  make_df(res$content, "List")
}

#' Variable catalogue
#'
#' Retrieve list of variables according to selection
#'
#' @param selection Code or content of the object(s) to be returned. Use of wildcard (*) possible.
#' @param area Area in which the object is stored:
#'
#'   - "free" = objects in the public catalogue
#'   - "user" = objects saved to "Meine Tabellen"
#' @param searchcriterion Does `selection` refer to the code or the content of the object(s)?
#' @param sortcriterion Should the results be sorted by the code or the content of the object(s)?
#' @param type Feature type
#'
#' @inherit find_ params return
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
                                type = c("all", "classifiing", "total", "region", "subject", "value", "time", "time identifiing"),
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
    type = match.arg(type),
    pagelength = pagelength,
    language = language
  )

  res <- genesis_api("catalogue/variables", query)

  make_df(res$content, "List")
}
