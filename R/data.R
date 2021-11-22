#' Get a data table
#'
#' Retrieves a data table based on the name of the table
#'
#' @param compress Should empty rows and columns be discarded?
#' @param startyear,endyear Only retrieve data between these years
#' @param timeslices Number of latest time slices to retrieve --
#'   independent of/cumulative to `startyear` and `endyear`
#' @param regionalvariable Code of the regional variable whose value is
#'   specified in `regionalkey` to filter the results
#' @param regionalkey One or more regional keys. Multiple values can be supplied
#'   as a character vector or as a single string, with the regional keys
#'   separated by commas. Use of wildcard (*) possible.
#' @param job Should a job be created if the table cannot be created immediately?
#' @param stand Only retrieve data updated after this date (dd.mm.yyyy)
#'
#' @inherit catalogue_tables_by_variable params return
#'
#' @export
#'
#' @examples
#' \dontrun{
#' get_table("12411-0001", startyear = 1960, endyear = 1969)
#'
#' # Filter results by region
#' # ("KREISE": administrative districts; "01001": Flensburg)
#' get_table("12411-0015", regionalvariable = "KREISE", regionalkey = "01001")
#' }
get_table <- function(name,
                      area = c("free", "user", "all"),
                      compress = FALSE,
                      startyear = 1900,
                      endyear = 2100,
                      timeslices = NULL,
                      regionalvariable = NULL,
                      regionalkey = NULL,
                      job = FALSE,
                      stand = NULL,
                      language = "en") {
  check_str_len1(name)
  check_language(language)

  if (grepl(".+_\\d+$", name)) {
    return(get_table_from_job(name, area, compress, language))
  }

  check_year(startyear)
  check_year(endyear)
  check_num_len1(timeslices)
  check_str_len1(regionalvariable)

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
    regionalvariable = regionalvariable,
    regionalkey = collapse_str(regionalkey),
    job = lgl_to_str(job),
    stand = stand,
    language = language,
    format = "ffcsv"
  )

  resp <- genesis_api("data/tablefile", query)

  tryCatch({ return(make_genesis_tbl(resp)) }, error = function(e) NULL)

  if (requireNamespace("tibble", quietly = TRUE)) {
    resp$content <- tibble::tibble()
  } else {
    resp$content <- data.frame()
  }

  invisible(make_genesis_tbl(resp))
}

get_table_from_job <- function(name,
                               area = c("free", "user", "all"),
                               compress = FALSE,
                               language = "en") {
  check_str_len1(name)
  check_language(language)

  creds <- retrieve_login_data()

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    area = match.arg(area),
    compress = lgl_to_str(compress),
    language = language,
    format = "ffcsv"
  )

  resp <- genesis_api("data/resultfile", query)

  tryCatch({ return(make_genesis_tbl(resp)) }, error = function(e) NULL)

  if (requireNamespace("tibble", quietly = TRUE)) {
    resp$content <- tibble::tibble()
  } else {
    resp$content <- data.frame()
  }

  invisible(make_genesis_tbl(resp))
}
