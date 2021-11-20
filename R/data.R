#' Get a data table
#'
#' Retrieves a data table based on the name of the table
#'
#' @param compress Should empty rows and columns be discarded?
#' @param startyear,endyear Only retrieve data between these years
#' @param timeslices Number of latest time slices to retrieve --
#'   independent of/cumulative to `startyear` and `endyear`
#' @param stand Only retrieve data updated after this date (dd.mm.yyyy)
#'
#' @inherit catalogue_tables_by_variable params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_table("12411-0001", startyear = 1960, endyear = 1969)
#' }
get_table <- function(name,
                      area = c("free", "user", "all"),
                      compress = FALSE,
                      startyear = NULL,
                      endyear = NULL,
                      timeslices = NULL,
                      stand = NULL,
                      language = "en") {
  check_str_len1(name)
  check_year(startyear)
  check_year(endyear)
  check_num_len1(timeslices)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    area = match.arg(area),
    compress = lgl_to_str(compress),
    startyear = startyear,
    endyear = endyear,
    timeslices = timeslices,
    stand = stand,
    language = language,
    format = "ffcsv"
  )

  ret <- genesis_api("data/tablefile", query)

  if (is.data.frame(ret)) {
    return(ret)
  }

  print_status(ret)

  if (requireNamespace("tibble", quietly = TRUE)) {
    invisible(tibble::tibble())
  } else {
    invisible(data.frame())
  }
}
