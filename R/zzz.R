.onLoad <- function(libname, pkgname) {
  genesis_api <<- memoise::memoise(genesis_api)
}
