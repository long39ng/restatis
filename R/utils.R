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

make_df <- function(api_resp, data_element) {
  print_status(api_resp)

  ret <- api_resp$content[[data_element]] %||% data.frame()

  if (requireNamespace("tibble", quietly = TRUE)) {
    tibble::as_tibble(ret)
  } else {
    ret
  }
}

print_url <- function(api_resp) {
  cat("<GENESIS ", trim_url(api_resp$response$url), ">\n", sep = "")
}

print_status <- function(api_resp) {
  if (isTRUE(api_resp$content$Status$Code != 0L)) {
    message(api_resp$content$Status$Type, ": ", api_resp$content$Status$Content)
  }
}

print_content <- function(x) {
  x <- unlist(x)
  nms <- names(x)

  Map(
    function(name, content) {
      cat(
        sprintf(paste0("%-", max(nchar(nms)) + 1, "s"), name),
        content, "\n",
        sep = ""
      )
    },
    nms,
    x
  )

  invisible(x)
}
