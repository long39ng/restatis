`%||%` <- function (x, y) {
  if (is.null(x)) y else x
}

unlock_keyring <- function() {
  if (keyring::keyring_is_locked()) keyring::keyring_unlock()
}

check_str_len1 <- function(x) {
  arg_name <- deparse(substitute(x))

  if (!(is.character(x) && length(x) == 1L)) {
    stop(arg_name, " must be a single string", call. = FALSE)
  }
}

check_pagelength <- function(pagelength) {
  stopifnot(pagelength >= 1 && pagelength <= 2500)
}

check_language <- function(language) {
  stopifnot(language %in% c("de", "en"))
}
