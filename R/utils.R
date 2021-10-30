`%||%` <- function (x, y) {
  if (is.null(x)) y else x
}

unlock_keyring <- function() {
  if (keyring::keyring_is_locked()) keyring::keyring_unlock()
}

check_pagelength <- function(pagelength) {
  stopifnot(pagelength >= 1 && pagelength <= 2500)
}

check_language <- function(language) {
  stopifnot(language %in% c("de", "en"))
}
