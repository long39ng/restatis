#' Set your GENESIS username and password
#'
#' Sets the username and password used to log in to www-genesis.destatis.de
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
#' @export
login_check <- function() {
  login_data <- retrieve_login_data()

  query <- list(
    username = login_data$username,
    password = login_data$password,
    language = "en"
  )

  structure(
    genesis_api("helloworld/logincheck", query),
    class = "genesis_helloworld"
  )
}

retrieve_login_data <- function() {
  unlock_keyring()
  available_usernames <- keyring::key_list("destatis")[["username"]]

  if (length(available_usernames) == 0L) {
    stop(call. = FALSE, paste0(
      "GENESIS login data not found.\n",
      "Run `set_login_data()` to save your username and password."
    ))
  }

  username <- available_usernames[[length(available_usernames)]]
  password <- keyring::key_get("destatis", username)

  list(username = username, password = password)
}
