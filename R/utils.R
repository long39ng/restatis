`%||%` <- function (x, y) {
  if (is.null(x)) y else x
}

discard_null <- function(x) {
  x[!sapply(x, is.null)]
}

unlock_keyring <- function() {
  if (keyring::keyring_is_locked()) keyring::keyring_unlock()
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

trim_url <- function(url) {
  url <- sub(base_url, "", url, fixed = TRUE)
  sub("username=([^&]+)&password=([^&]+)", "username=***&password=***", url)
}

make_df <- function(resp_content, data_element) {
  if (resp_content$Status$Code != 0L) {
    message(resp_content$Status$Type, ": ", resp_content$Status$Content, "\n")
  }

  ret <- resp_content[[data_element]] %||% data.frame()

  if (requireNamespace("tibble", quietly = TRUE)) {
    tibble::as_tibble(ret)
  } else {
    ret
  }
}

print_status <- function(x) {
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
