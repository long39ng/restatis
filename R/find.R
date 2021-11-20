#' Find tables, statistics, variables, data cubes, or time series
#'
#' Retrieves lists of objects for a search term
#' (tables, statistics, characteristics, data cubes or time series)
#'
#' @param term Term to search for
#' @param pagelength Maximum number of results delivered
#' @param language Search terms, returned messages and data descriptions in German ("de") or English ("en")?
#'
#' @seealso catalogue_terms
#'
#' @return A `data.frame` (or `tbl_df` if tibble package is installed)
#'
#' @rdname search_
#'
#' @export
#'
#' @examples
#' \dontrun{
#' search_statistics("Abfall", pagelength = 6, language = "de")
#'
#' search_variables("vote")
#' }
search_tables <- function(term, pagelength = 100, language = "en") {
  search_(category = "tables", term, pagelength, language)
}

#' @rdname search_
#'
#' @export
search_statistics <- function(term, pagelength = 100, language = "en") {
  search_(category = "statistics", term, pagelength, language)
}

#' @rdname search_
#'
#' @export
search_variables <- function(term, pagelength = 100, language = "en") {
  search_(category = "variables", term, pagelength, language)
}

search_ <- function(category = c("tables", "statistics", "variables", "cubes", "time-series"),
                    term = NULL,
                    pagelength = NULL,
                    language = NULL) {
  check_str_len1(term)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data()

  categories <- c("Tables", "Statistics", "Variables", "Cubes", "Timeseries")
  names(categories) <- c("tables", "statistics", "variables", "cubes", "time-series")

  query <- list(
    username = creds$username,
    password = creds$password,
    term = term,
    category = match.arg(category),
    pagelength = pagelength,
    language = language
  )

  make_df(genesis_api("find/find", query), categories[category])
}
