ua <- httr::user_agent("https://github.com/long39ng/restatis")

base_url <- "https://www-genesis.destatis.de/genesisWS/rest/2020/"

genesis_api <- function(path, query = NULL) {
  resp <- genesis_api_raw(path, query)

  tryCatch({ return(genesis_csv(resp)) }, error = function(e) invisible(e))

  parsed <- genesis_json(resp)

  list(
    content = parsed,
    path = path,
    query = query,
    response = resp
  )
}

genesis_api_raw <- function(path, query = NULL) {
  url <- paste0(base_url, path)

  httr::RETRY("GET", url, ua, query = discard_empty(query))
}

genesis_json <- function(resp) {
  check_resp_type(resp, "application/json")

  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"))

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "GENESIS API request failed [%s]\n%s",
        httr::status_code(resp),
        parsed$Content
      ),
      call. = FALSE
    )
  }

  parsed
}

genesis_csv <- function(resp) {
  check_resp_type(resp, "text/csv")

  if (httr::http_error(resp)) {
    stop(
      sprintf("GENESIS API request failed [%s]", httr::status_code(resp)),
      call. = FALSE
    )
  }

  readr::read_delim(
    httr::content(resp, "text", encoding = "UTF-8"),
    delim = ";",
    locale = readr::locale(
      decimal_mark = ",",
      grouping_mark = "."
    ),
    col_types = list(Zeit = readr::col_character()),
    show_col_types = FALSE
  )
}

hello_genesis <- function() {
  resp <- genesis_api("helloworld/whoami")
  print_url(resp)
  print_content(resp$content)
}
