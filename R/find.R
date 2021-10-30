genesis_find <- function(term,
                         category = c("statistics", "tables", "variables", "time-series", "cubes"),
                         pagelength = 100,
                         language = "en") {
  categories <- c("Statistics", "Tables", "Variables", "Timeseries", "Cubes")
  names(categories) <- c("statistics", "tables", "variables", "time-series", "cubes")

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
