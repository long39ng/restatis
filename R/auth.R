#' Set your GENESIS username and password
#'
#' Sets the username and password used to log in to www-genesis.destatis.de
#'
#' @export
set_login_data <- function() {
  username <- askpass::askpass("Username: ")

  while (length(username) == 0L) {
    username <- askpass::askpass("Please enter a non-empty username: ")
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

  if (is.null(login_data$username)) {
    stop(call. = FALSE, paste0(
      "GENESIS login data not found.\n",
      "Run `set_login_data()` to save your username and password."
    ))
  }

  query <- list(
    username = login_data$username,
    password = login_data$password,
    language = "en"
  )

  genesis_api("helloworld/logincheck", query)
}

unlock_keyring <- function() {
  if (keyring::keyring_is_locked()) keyring::keyring_unlock()
}

retrieve_login_data <- function() {
  unlock_keyring()
  available_usernames <- keyring::key_list("destatis")[["username"]]

  if (length(available_usernames) == 0L) {
    username <- NULL
    password <- NULL
  } else {
    username <- available_usernames[[length(available_usernames)]]
    password <- keyring::key_get("destatis", username)
  }

  list(username = username, password = password)
}
