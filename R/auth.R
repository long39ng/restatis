#' Set your GENESIS username and password
#'
#' Sets the username and password used to log in to www-genesis.destatis.de.
#'
#' Login data are stored with the [keyring][keyring-package] package. Use [keyring::key_list()]
#' to get an overview of the stored credentials.
#'
#' @seealso [`login_check`]
#'
#' @export
set_login_data <- function() {
  username <- askpass::askpass("Username: ")

  if (is.null(username)) {
    stop("Entry cancelled/empty username", call. = FALSE)
  }

  unlock_keyring()
  keyring::key_set("destatis", username)
}

#' Login check
#'
#' Tests if the login with the saved username and password was sucessful
#'
#' @seealso [`set_login_data`]
#'
#' @export
login_check <- function() {
  login_data <- retrieve_login_data()

  query <- list(
    username = login_data$username,
    password = login_data$password,
    language = "en"
  )

  make_genesis_list(genesis_api("helloworld/logincheck", query))
}

retrieve_login_data <- function() {
  unlock_keyring()
  available_usernames <- keyring::key_list("destatis")[["username"]]

  if (length(available_usernames) == 0L) {
    stop(call. = FALSE, paste0(
      "GENESIS login data not found.\n",
      "Run `set_login_data()` to save your username and password.\n",
      "(Register at https://www-genesis.destatis.de if you don't have an account yet.)"
    ))
  }

  username <- available_usernames[[length(available_usernames)]]
  password <- keyring::key_get("destatis", username)

  list(username = username, password = password)
}
