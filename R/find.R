find_ <- function(term,
                  category = c("tables", "statistics", "variables", "cubes", "time-series"),
                  pagelength = 100,
                  language = "en") {
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

#' Find tables, statistics, variables, data cubes, or time series
#'
#' Retrieves lists of objects for a search term
#' (tables, statistics, characteristics, data cubes or time series)
#'
#' @param term Term to search for
#' @param pagelength Maximum number of results delivered
#' @param language Search terms, returned messages and data descriptions in German ("de") or English ("en")?
#'
#' @return A `data.frame` (or `tbl_df` if tibble package is installed)
#'
#' @rdname find_
#'
#' @export
#'
#' @examples
#' \dontrun{
#' find_statistics("Abfall", pagelength = 6, language = "de")
#'
#' find_variables("vote")
#' }
find_tables <- function(term, pagelength = 100, language = "en") {
  find_(category = "tables", term, pagelength, language)
}

#' @rdname find_
#'
#' @export
find_statistics <- function(term, pagelength = 100, language = "en") {
  find_(category = "statistics", term, pagelength, language)
}

#' @rdname find_
#'
#' @export
find_variables <- function(term, pagelength = 100, language = "en") {
  find_(category = "variables", term, pagelength, language)
}

#' @rdname find_
#'
#' @export
find_cubes <- function(term, pagelength = 100, language = "en") {
  find_(category = "cubes", term, pagelength, language)
}

#' @rdname find_
#'
#' @export
find_timeseries <- function(term, pagelength = 100, language = "en") {
  find_(category = "time-series", term, pagelength, language)
}
