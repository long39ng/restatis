#' Find tables, statistics, variables, data cubes, or time series
#'
#' Retrieve lists of objects for a search term
#' (tables, statistics, characteristics, data cubes or time series)
#'
#' @param term Term to search for
#' @param category Category to be searched
#' (one of "tables", "statistics", "variables", "cubes" or "time-series")
#' @param pagelength Maximum number of results delivered
#' @param language Messages and data descriptions in German (de) or English (en)?
#'
#' @return A `data.frame` (or `tbl_df` if [tibble][tibble-package] is installed)
#' @export
#'
#' @examples
#' \dontrun{
#' find_("Abfall", category = "statistics", pagelength = 6, language = "de")
#' find_tables("Abfall", language = "de")
#' }
find_ <- function(term,
                  category = c("tables", "statistics", "variables", "cubes", "time-series"),
                  pagelength = 100,
                  language = "en") {
  check_str_len1(term)

  creds <- retrieve_login_data()

  categories <- c("Tables", "Statistics", "Variables", "Cubes", "Timeseries")
  names(categories) <- c("tables", "statistics", "variables", "cubes", "time-series")

  category <- match.arg(category)
  check_pagelength(pagelength)
  check_language(language)

  query <- list(
    username = creds$username,
    password = creds$password,
    term = term,
    category = category,
    pagelength = pagelength,
    language = language
  )

  res <- genesis_api("find/find", query)

  make_df(res$content[[categories[category]]])
}

#' @inheritDotParams find_
#' @rdname find_
#'
#' @export
find_tables <- function(...) {
  find_(category = "tables", ...)
}

#' @rdname find_
#'
#' @export
find_statistics <- function(...) {
  find_(category = "statistics", ...)
}

#' @rdname find_
#'
#' @export
find_variables <- function(...) {
  find_(category = "variables", ...)
}

#' @rdname find_
#'
#' @export
find_cubes <- function(...) {
  find_(category = "cubes", ...)
}

#' @rdname find_
#'
#' @export
find_timeseries <- function(...) {
  find_(category = "time-series", ...)
}
