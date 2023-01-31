#' Fill missing strict
#'
#' Fill all missing values in a vector with the same value if it is known. Only
#' fills the value when all known values are the same
#' @param x The vector to fill
#' @param min_known_n numeric value: the minimum number of not-missing values
#' @param min_known_p numeric value between 0 and 1: the minimum fraction of not-missing values
#'
#' @return a filled vector
#' @export
#'
#' @examples
#' fill_missing_strict(c(NA, 1))
fill_missing_strict <- function(x, min_known_n = NULL, min_known_p = NULL) {
  fill_missing(x, min_known_n, min_known_p, type = "strict")
}

#' Fill missing previous
#'
#' Fill all missing values in a vector with the previous value if it is known.
#' @param x The vector to fill
#' @param min_known_n numeric value: the minimum number of not-missing values
#' @param min_known_p numeric value between 0 and 1: the minimum fraction of not-missing values
#'
#' @return a filled vector
#' @export
#'
#' @examples
#' fill_missing_previous(c(1, 2, NA))
#' fill_missing_previous(c(NA, 1, 2, NA))
fill_missing_previous <- function(x, min_known_n = NULL, min_known_p = NULL) {
  fill_missing(x, min_known_n, min_known_p, type = "previous")
}


#' Fill missing minimum
#'
#' Fill all missing values in a vector with the minimum value if it is known.
#' @param x The vector to fill
#' @param min_known_n numeric value: the minimum number of not-missing values
#' @param min_known_p numeric value between 0 and 1: the minimum fraction of not-missing values
#'
#' @return a filled vector
#' @export
#'
#' @examples
#' fill_missing_min(c(1, 2, NA))
#' fill_missing_min(c(NA, 1, 2, NA))
fill_missing_min <- function(x, min_known_n = NULL, min_known_p = NULL) {
  fill_missing(x, min_known_n, min_known_p, type = "min")
}

#' Fill missing maximum
#'
#' Fill all missing values in a vector with the maximum value if it is known.
#' @param x The vector to fill
#' @param min_known_n numeric value: the minimum number of not-missing values
#' @param min_known_p numeric value between 0 and 1: the minimum fraction of not-missing values
#'
#' @return a filled vector
#' @export
#'
#' @examples
#' fill_missing_max(c(1, 2, NA))
#' fill_missing_max(c(NA, 1, 2, NA))
fill_missing_max <- function(x, min_known_n = NULL, min_known_p = NULL) {
  fill_missing(x, min_known_n, min_known_p, type = "max")
}


#' Fill missing last
#'
#' Fill all missing values in a vector with the last value if it is known.
#' @param x The vector to fill
#' @param min_known_n numeric value: the minimum number of not-missing values
#' @param min_known_p numeric value between 0 and 1: the minimum fraction of not-missing values
#'
#' @return a filled vector
#' @export
#'
#' @examples
#' fill_missing_last(c(1, 2, NA))
#' fill_missing_last(c(NA, 1, 2, NA))
fill_missing_last <- function(x, min_known_n = NULL, min_known_p = NULL) {
  fill_missing(x, min_known_n, min_known_p, type = "last")
}

#' Fill missing interval
#'
#' Fill all missing values for an interval observed in the vector
#' @param x The vector to fill
#' @param min_known_n numeric value: the minimum number of not-missing values
#' @param min_known_p numeric value between 0 and 1: the minimum fraction of not-missing values
#'
#' @return a filled vector
#' @export
#'
#' @examples
#' fill_missing_interval(c(NA, 1, 2, NA))
#' fill_missing_interval(c(NA, 10, 20, NA))
fill_missing_interval <- function(x, min_known_n = NULL, min_known_p = NULL) {
  return(fill_missing(x, min_known_n, min_known_p, type = "interval"))
}


#' Fill missing
#'
#' wrapper function to do check and call all fill_vector functions
#' @param x The vector to fill
#' @param min_known_n numeric value: the minimum number of not-missing values
#' @param min_known_p numeric value between 0 and 1: the minimum fraction of not-missing values
#' @param type the type of fill missing function to be called
#' @return filled vector
#' @export
fill_missing <- function(x, min_known_n = NULL, min_known_p = NULL, type) {

  stopifnot(type %in% c("last",
                        "min",
                        "max",
                        "strict",
                        "previous",
                        "interval"))

  ## Check if missing values can and should be filled
  if(!check_some_missing(x)) {
    return(x)
  }

  ## Create vector without mising values
  x_na_omit <- stats::na.omit(x)

  ## Check if the minimum known n and percentage criteria are matched
  if(!check_min_known(x, x_na_omit, min_known_n, min_known_p)) {
    return(x)
  }

  ## Call the fill_vector function, depending on the given type argument
  if (type == "last"){
    return(fill_vector_last(x, x_na_omit))
  } else if (type == "min") {
    stopifnot(is.numeric(x))
    return(fill_vector_min(x, x_na_omit))
  } else if (type == "max") {
    stopifnot(is.numeric(x))
    return(fill_vector_max(x, x_na_omit))
  } else if (type == "strict") {
    return(fill_vector_strict(x, x_na_omit))
  } else if (type == "previous") {
    return(fill_vector_previous(x))
  } else if (type == "interval") {
    return(fill_vector_interval(x))
  }
}
