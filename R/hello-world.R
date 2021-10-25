genesis_api <- function(path) {
  ua <- httr::user_agent("https://github.com/long39ng/restatis")

  url <- httr::modify_url("https://www-genesis.destatis.de", path = path)

  resp <- httr::GET(url, ua)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "GENESIS API request failed [%s]\n> %s",
        httr::status_code(resp),
        parsed$Content
      ),
      call. = FALSE
    )
  }

  structure(
    list(
      content = parsed,
      path = path,
      response = resp
    ),
    class = "genesis_api"
  )
}

print.genesis_api <- function(x, ...) {
  cat("<GENESIS ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}

#' Hellow world
#'
#' @export
hello_genesis <- function() {
  print(genesis_api(path = "/genesisWS/rest/2020/helloworld/whoami"))
}
