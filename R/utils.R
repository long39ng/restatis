`%||%` <- function (x, y) {
  if (is.null(x)) y else x
}

discard_null <- function(x) {
  x[!sapply(x, is.null)]
}

unlock_keyring <- function() {
  if (keyring::keyring_is_locked()) keyring::keyring_unlock()
}

trim_url <- function(url) {
  url <- sub(base_url, "", url, fixed = TRUE)
  sub("password=([^&]+)", "password=***", url)
}

check_str_len1 <- function(x) {
  nm <- deparse(substitute(x))

  if (!(is.character(x) && length(x) == 1L)) {
    stop(nm, " must be a single string", call. = FALSE)
  }
}

check_pagelength <- function(pagelength) {
  stopifnot(pagelength >= 1 && pagelength <= 2500)
}

check_language <- function(language) {
  stopifnot(language %in% c("de", "en"))
}

make_genesis_df <- function(x, url) {
  attributes(x) <- c(attributes(x), list(
    class = c("genesis_df", class(x)),
    url = url
  ))
  x
}
