#' Check if some missing values are present
#'
#' Check if some missing values are present, but not all are missing.
#' returns a boolean. This check is done to save time for vectors where filling
#' is not needed
#'
#' @param x the vector to check
#' @return TRUE or FALSE
check_some_missing <- function(x) {
  x <- unique(x)
  return(any(is.na(x)) & !all(is.na(x)))
}

check_min_known_p <- function(x, x_na_omit, min_known_p) {
  known_p <- length(x_na_omit) / length(x)
  ## When the percentage of known values is smaller than the given minimum,
  ## FALSE will be returned
  if (known_p < min_known_p) {
    return(FALSE)
  } else {
    return(TRUE)
  }

}

check_min_known_n <- function(x, x_na_omit, min_known_n) {
  known_n <- length(x_na_omit)
  ## When the number of known values is smaller than the given minimum,
  ## FALSE will be returned
  if (known_n < min_known_n) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}

check_min_known <- function(x, x_na_omit, min_known_n, min_known_p){
  ## Check if the minimum known n and percentage criteria are matched
  if (!is.null(min_known_n)) {

    if(!check_min_known_n(x, x_na_omit, min_known_n)){
      return(FALSE)
    }
  }
  if (!is.null(min_known_p)) {

    if(!check_min_known_p(x, x_na_omit, min_known_p)) {
      return(FALSE)
    }
  }
  return(TRUE)
}