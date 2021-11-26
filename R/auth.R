#' Set your username and password
#'
#' Saves the login data for a GENESIS web service
#'
#' Login data are stored with the [keyring][keyring-package] package.
#'   Run [keyring::key_list()] to get an overview of the stored credentials.
#'
#' @param genesis Which GENESIS database should be used?
#'
#'   One of: "`r paste0(dbs, collapse = "\", \"")`".
#'
#'   A default value can also be set to the global option `genesis` via
#'   [options()], e.g. `options(genesis = "destatis")`, so that `genesis`
#'   does not have to be specified in the function call.
#'
#' @seealso [`login_check`]
#'
#' @export
set_login_data <- function(genesis = getOption("genesis")) {
  check_genesis(genesis)

  unlock_keyring()
  username <- askpass::askpass(paste(toupper(genesis), "username: "))

  if (is.null(username)) {
    stop("Entry cancelled/empty username", call. = FALSE)
  }

  keyring::key_set(genesis, username)
}

#' Login check
#'
#' Tests if the login with the saved username and password was sucessful
#'
#' @inheritParams set_login_data
#'
#' @seealso [`set_login_data`]
#'
#' @export
login_check <- function(genesis = getOption("genesis")) {
  login_data <- retrieve_login_data(genesis)

  query <- list(
    username = login_data$username,
    password = login_data$password,
    language = getOption("genesis_language")
  )

  make_genesis_list(genesis_api("helloworld/logincheck", query, genesis))
}

retrieve_login_data <- function(genesis) {
  check_genesis(genesis)

  unlock_keyring()
  available_usernames <- keyring::key_list(genesis)$username

  if (length(available_usernames) == 0L) {
    stop(
      toupper(genesis),
      " login data not found.\n",
      "Run `set_login_data()` to save your username and password.\n",
      "(Register at ",
      httr::parse_url(base_url(genesis))$hostname,
      " if you don't have an account yet.)",
      call. = FALSE
    )
  }

  username <- available_usernames[[length(available_usernames)]]
  password <- keyring::key_get(genesis, username)

  list(username = username, password = password)
}
