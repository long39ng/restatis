genesis_api <- function(path, query = NULL, genesis) {
  resp <- genesis_api_raw(path, query, genesis)

  parsed <- tryCatch({ genesis_csv(resp) }, error = function(e) NULL) %||%
    genesis_json(resp)

  list(
    content = parsed,
    path = path,
    query = query,
    response = resp
  )
}

dbs <- c(
  "destatis",
  "regionalstatistik",
  "bildungsmonitoring",
  "bayern",
  "nrw",
  "sachsen-anhalt"
)

ua <- httr::user_agent("https://github.com/long39ng/restatis")

base_url <- function(genesis) {
  switch(
    genesis,
    destatis = "https://www-genesis.destatis.de/genesisWS/rest/2020/",
    regionalstatistik = "https://www.regionalstatistik.de/genesisws/rest/2020/",
    bildungsmonitoring = "https://www.bildungsmonitoring.de/bildungws/rest/2020/",
    bayern = "https://www.statistikdaten.bayern.de/genesisWS/rest/2020/",
    nrw = "https://www.landesdatenbank.nrw.de/ldbnrwws/rest/2020/",
    `sachsen-anhalt` = "https://genesis.sachsen-anhalt.de/webservice/rest/2020/",
    stop("genesis must be one of: \"", paste0(dbs, collapse = "\", \""), "\".")
  )
}

genesis_api_raw <- function(path, query = NULL, genesis) {
  url <- paste0(base_url(genesis), path)

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
    show_col_types = FALSE
  )
}

hello_genesis <- function(genesis = getOption("genesis")) {
  make_genesis_list(genesis_api("helloworld/whoami", genesis = genesis))
}

#' @export
print.genesis_list <- function(x, ...) {
  print_url(attr(x, "url"))
  nms <- names(x)
  Map(
    function(field, content) {
      cat(
        sprintf(paste0("%-", max(nchar(nms)) + 1, "s"), field),
        content, "\n",
        sep = ""
      )
    },
    nms,
    x
  )
  invisible(x)
}

#' @export
print.genesis_tbl <- function(x, ...) {
  print_url(attr(x, "url"))
  class(x) <- setdiff(class(x), "genesis_tbl")
  print(x)
}
