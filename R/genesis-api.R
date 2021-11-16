base_url <- "https://www-genesis.destatis.de/genesisWS/rest/2020/"

genesis_api <- function(path, query = NULL) {
  ua <- httr::user_agent("https://github.com/long39ng/restatis")

  url <- paste0(base_url, path)

  resp <- httr::GET(url, ua, query = discard_null(query))
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"))

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

  list(
    content = parsed,
    path = path,
    query = query,
    response = resp
  )
}

hello_genesis <- function() {
  print_status(genesis_api("helloworld/whoami"))
}
