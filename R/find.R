#' Find statistics, tables or values
#'
#' Retrieves lists of objects for a search term
#' (statistics, tables or variables)
#'
#' @param term Term to search for
#' @param pagelength Maximum number of results delivered
#' @param language Search terms, returned messages and data descriptions
#'   in German ("de") or English ("en")?
#'
#'   A default value can also be set to the global option `genesis_language` via
#'   [options()], e.g. `options(genesis_language = "de")`.
#'
#' @inheritParams set_login_data
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
#' options(genesis = "destatis")
#' search_statistics("Abfall", pagelength = 6, language = "de")
#'
#' search_variables("vote")
#' }
search_tables <- function(term,
                          pagelength = 100,
                          language = getOption("genesis_language"),
                          genesis = getOption("genesis")) {
  search_(category = "tables", term, pagelength, language, genesis)
}

#' @rdname search_
#'
#' @export
search_statistics <- function(term,
                              pagelength = 100,
                              language = getOption("genesis_language"),
                              genesis = getOption("genesis")) {
  search_(category = "statistics", term, pagelength, language, genesis)
}

#' @rdname search_
#'
#' @export
search_variables <- function(term,
                             pagelength = 100,
                             language = getOption("genesis_language"),
                             genesis = getOption("genesis")) {
  search_(category = "variables", term, pagelength, language, genesis)
}

search_ <- function(category = c("tables", "statistics", "variables", "cubes", "time-series"),
                    term = NULL,
                    pagelength = NULL,
                    language = NULL,
                    genesis) {
  check_str_len1(term)
  check_pagelength(pagelength)
  check_language(language)

  creds <- retrieve_login_data(genesis)

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

  make_genesis_tbl(genesis_api("find/find", query, genesis), categories[category])
}
