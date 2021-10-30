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
#' @return A `data.frame` with an `url` attribute containing the URL of the API request
#' @export
#'
#' @examples
#' \dontrun{
#' find_data_("Abfall", category = "statistics", pagelength = 6, language = "de")
#' find_tables("Abfall", language = "de")
#' }
find_data_ <- function(term,
                       category = c("tables", "statistics", "variables", "cubes", "time-series"),
                       pagelength = 100,
                       language = "en") {
  check_str_len1(term)

  categories <- c("Tables", "Statistics", "Variables", "Cubes", "Timeseries")
  names(categories) <- c("tables", "statistics", "variables", "cubes", "time-series")

  category <- match.arg(category)
  check_pagelength(pagelength)
  check_language(language)

  login_data <- retrieve_login_data()

  query <- list(
    term = term,
    category = category,
    pagelength = pagelength,
    language = language
  )

  res <- genesis_api("find/find", query)

  structure(
    res$content[[categories[category]]] %||% list(),
    class = c("genesis_find", "data.frame"),
    url = res$response$url
  )
}

#' @inheritDotParams find_data_
#' @rdname find_data_
#'
#' @export
find_tables <- function(...) {
  find_data_(category = "tables", ...)
}

#' @rdname find_data_
#'
#' @export
find_statistics <- function(...) {
  find_data_(category = "statistics", ...)
}

#' @rdname find_data_
#'
#' @export
find_variables <- function(...) {
  find_data_(category = "variables", ...)
}

#' @rdname find_data_
#'
#' @export
find_cubes <- function(...) {
  find_data_(category = "cubes", ...)
}

#' @rdname find_data_
#'
#' @export
find_timeseries <- function(...) {
  find_data_(category = "time-series", ...)
}
