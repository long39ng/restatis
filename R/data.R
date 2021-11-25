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
#' options(genesis = "destatis")
#' get_table("12411-0001", startyear = 1960, endyear = 1969)
#' # Filter results by region
#' # ("KREISE": administrative districts; "01001": Flensburg)
#' get_table("12411-0015", regionalvariable = "KREISE", regionalkey = "01001")
#'
#' options(genesis = "regionalstatistik")
#' # Get large table by creating a background processing job
#' get_table("12711-01-03-4", job = TRUE)
#' # List jobs you've created
#' catalogue_jobs()
#' # After the job is finished, you can retrieve the table with `get_table()`
#' # with `name` set to the name of the job.
#' }
get_table <- function(name,
                      area = c("free", "user", "all"),
                      compress = FALSE,
                      startyear = 1900,
                      endyear = 2100,
                      timeslices = NULL,
                      regionalvariable = NULL,
                      regionalkey = NULL,
                      job = NULL,
                      stand = NULL,
                      language = "en",
                      genesis = getOption("genesis")) {
  check_str_len1(name)
  area <- match.arg(area)
  compress <- lgl_to_str(compress)

  if (grepl(".+_\\d+$", name)) {
    return(get_table_from_job(name, area, compress, language, genesis))
  }

  regionalkey <- collapse_str(regionalkey)
  job <- lgl_to_str(job)

  do.call(get_data_, c(as.list(environment()), method = "tablefile"))
}

get_table_from_job <- function(name,
                               area = c("free", "user", "all"),
                               compress = FALSE,
                               language = "en",
                               genesis) {
  do.call(get_data_, c(as.list(environment()), method = "resultfile"))
}

get_data_ <- function(method,
                      name = NULL,
                      area = NULL,
                      compress = NULL,
                      startyear = NULL,
                      endyear = NULL,
                      timeslices = NULL,
                      regionalvariable = NULL,
                      regionalkey = NULL,
                      job = NULL,
                      stand = NULL,
                      language = "en",
                      genesis) {
  check_year(startyear)
  check_year(endyear)
  check_num_len1(timeslices)
  check_str_len1(regionalvariable)
  check_language(language)

  creds <- retrieve_login_data(genesis)

  query <- list(
    username = creds$username,
    password = creds$password,
    name = name,
    area = area,
    compress = compress,
    startyear = startyear,
    endyear = endyear,
    timeslices = timeslices,
    regionalvariable = regionalvariable,
    regionalkey = regionalkey,
    job = job,
    stand = stand,
    language = language,
    format = "ffcsv"
  )

  resp <- genesis_api(paste0("data/", method), query, genesis)

  tryCatch({ return(make_genesis_tbl(resp)) }, error = function(e) NULL)

  if (requireNamespace("tibble", quietly = TRUE)) {
    resp$content <- tibble::tibble()
  } else {
    resp$content <- data.frame()
  }

  invisible(make_genesis_tbl(resp))
}
