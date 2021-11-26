.onLoad <- function(libname, pkgname) {
  genesis_api <<- memoise::memoise(genesis_api)

  if (!"genesis_language" %in% names(options())) {
    options(genesis_language = "en")
  }
}
