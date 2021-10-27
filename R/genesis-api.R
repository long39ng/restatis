genesis_api <- function(path, query = NULL) {
  ua <- httr::user_agent("https://github.com/long39ng/restatis")

  url <- paste0("https://www-genesis.destatis.de/genesisWS/rest/2020/", path)

  resp <- httr::GET(url, ua, query = query)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(
    httr::content(resp, "text"),
    simplifyVector = FALSE
  )

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
      query = query,
      response = resp
    ),
    class = "genesis_api"
  )
}

#' Printing parsed GENESIS API request
#'
#' @param x Object of class `genesis_api`
#' @param ... Optional arguments to print methods
#'
#' @export
print.genesis_api <- function(x, ...) {
  cat("<GENESIS ", x$path, ">\n\n", sep = "")

  purrr::walk2(
    names(x$content),
    x$content,
    function(name, content) {
      cat(name, ":\n", content, "\n\n", sep = "")
    }
  )

  invisible(x)
}

#' whoami
hello_genesis <- function() {
  genesis_api("helloworld/whoami")
}

