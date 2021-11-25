#' Get metadata
#'
#' Retrieves metadata for a statistic, table, variable or value
#'
#' @inherit catalogue_statistics_by_variable params
#'
#' @rdname metadata_
#'
#' @export
#'
#' @examples
#' \dontrun{
#' options(genesis = "destatis")
#' metadata_statistic("12411")
#' metadata_table("12411-0001")
#' metadata_variable("KREISE")
#' metadata_value("VV101")
#' }
metadata_statistic <- function(name,
                               area = c("free", "user", "all"),
                               language = "en",
                               genesis = getOption("genesis")) {
  metadata_("statistic", name, match.arg(area), language, genesis)
}

#' @rdname metadata_
#'
#' @export
metadata_table <- function(name,
                           area = c("free", "user", "all"),
                           language = "en",
                           genesis = getOption("genesis")) {
  metadata_("table", name, match.arg(area), language, genesis)
}

#' @rdname metadata_
#'
#' @export
metadata_value <- function(name,
                           area = c("free", "user", "all"),
                           language = "en",
                           genesis = getOption("genesis")) {
  metadata_("value", name, match.arg(area), language, genesis)
}

#' @rdname metadata_
#'
#' @export
metadata_variable <- function(name,
                              area = c("free", "user", "all"),
                              language = "en",
                              genesis = getOption("genesis")) {
  metadata_("variable", name, match.arg(area), language, genesis)
}

metadata_ <- function(method,
                      name = NULL,
                      area = NULL,
                      language = NULL,
                      genesis) {
  check_str_len1(name)
  check_language(language)

  creds <- retrieve_login_data(genesis)

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    area = area,
    language = language
  )

  make_genesis_list(genesis_api(paste0("metadata/", method), query, genesis), "Object")
}
