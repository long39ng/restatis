`%||%` <- function (x, y) {
  if (is.null(x)) y else x
}

discard_empty <- function(x) {
  x <- x[!vapply(x, is.null, logical(1L))]
  x[vapply(x, nzchar, logical(1L))]
}

unlock_keyring <- function() {
  if (keyring::keyring_is_locked()) keyring::keyring_unlock()
}

lgl_to_str <- function(x) {
  stopifnot(is.logical(x) && length(x) == 1L && !is.na(x))
  tolower(x)
}

collapse_str <- function(x) {
  stopifnot(is.null(x) || is.character(x))
  paste0(x, collapse = ",")
}

check_num_len1 <- function(x) {
  nm <- deparse(substitute(x))

  if (!(is.null(x) || (is.numeric(x) && length(x) == 1L))) {
    stop(nm, " must be a number or NULL", call. = FALSE)
  }
}

check_str_len1 <- function(x) {
  nm <- deparse(substitute(x))

  if (!(is.null(x) || (is.character(x) && length(x) == 1L))) {
    stop(nm, " must be a single string or NULL", call. = FALSE)
  }
}

check_year <- function(year) {
  stopifnot(year >= 1900 && year <= 2100 || is.null(year))
}

check_pagelength <- function(pagelength) {
  stopifnot(pagelength >= 1 && pagelength <= 2500 || is.null(pagelength))
}

check_language <- function(language) {
  stopifnot(language %in% c("de", "en") || is.null(language))
}

check_resp_type <- function(resp, type) {
  if (!httr::http_type(resp) == type) {
    stop("GENESIS API did not return ", type, call. = FALSE)
  }
}

trim_url <- function(url) {
  url <- sub(base_url, "", url, fixed = TRUE)
  sub("username=([^&]+)&password=([^&]+)", "username=***&password=***", url)
}

make_genesis_list <- function(api_resp, element) {
  print_status(api_resp)

  if (missing(element)) {
    ret <- unlist(api_resp$content) %||% character()
  } else {
    ret <- unlist(api_resp$content[[element]]) %||% character()
  }

  make_genesis_class(ret, "list", api_resp$response$url)
}

make_genesis_tbl <- function(api_resp, element) {
  print_status(api_resp)

  if (missing(element)) {
    ret <- api_resp$content %||% data.frame()
  } else {
    ret <- api_resp$content[[element]] %||% data.frame()
  }

  if (requireNamespace("tibble", quietly = TRUE)) {
    ret <- tibble::as_tibble(ret)
  }

  make_genesis_class(ret, "tbl", api_resp$response$url)
}

make_genesis_class <- function(x, class, url) {
  class(x) <- c(paste0("genesis_", class), class(x))
  attr(x, "url") <- url
  x
}

print_url <- function(url) {
  cat("<GENESIS ", trim_url(url), ">\n", sep = "")
}

print_status <- function(api_resp) {
  if (tryCatch(
    { isTRUE(api_resp$content$Status$Code != 0L) },
    error = function(e) FALSE,
    warning = function(w) FALSE
  )) {
    api_resp$content$Status$Type <- switch(
      api_resp$content$Status$Type,
      Fehler = "Error",
      Warnung = "Warning",
      api_resp$content$Status$Type
    )

    if (api_resp$content$Status$Code == 98L) {
      api_resp$content$Status$Content <- paste0(
        "This table is too big for dialogue-processing. ",
        "Please run `get_table()` with the parameter ",
        "`job = TRUE` to start background-processing.\n\n",
        "Run `catalogue_jobs()` to list your processing jobs."
      )
    }

    if (api_resp$content$Status$Code == 99L) {
      api_resp$content$Status$Content <- paste0(
        api_resp$content$Status$Content,
        "\n\nRun `catalogue_jobs()` to list your processing jobs."
      )
    }

    message(api_resp$content$Status$Type, ": ", api_resp$content$Status$Content)
  }
}
