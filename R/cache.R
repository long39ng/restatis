#' Reset cache
#'
#' Forget past results
#'
#' @export
reset_cache <- function() {
  invisible(memoise::forget(genesis_api))
}
