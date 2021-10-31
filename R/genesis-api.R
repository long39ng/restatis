base_url <- "https://www-genesis.destatis.de/genesisWS/rest/2020/"

genesis_api <- function(path, query = NULL) {
  ua <- httr::user_agent("https://github.com/long39ng/restatis")

  url <- paste0(base_url, path)

  resp <- httr::GET(url, ua, query = query)
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

#' @export
print.genesis_meta <- function(x, ...) {
  cat("<GENESIS ", trim_url(x$response$url), ">\n", sep = "")

  field_names <- names(x$content)

  Map(
    function(name, content) {
      cat(
        sprintf(paste0("%-", max(nchar(field_names)) + 1, "s"), name),
        content, "\n",
        sep = ""
      )
    },
    field_names,
    x$content
  )

  invisible(x)
}

#' @export
print.genesis_df <- function(x, ...) {
  cat("<GENESIS ", trim_url(attr(x, "url")), ">\n", sep = "")
  class(x) <- "data.frame"
  print(x)
}

hello_genesis <- function() {
  structure(genesis_api("helloworld/whoami"), class = "genesis_meta")
}
