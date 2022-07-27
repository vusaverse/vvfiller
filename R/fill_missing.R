
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

#' Fill with aggregate by group
#'
#' Function to calculate a summary statistic (mean, median, vvconverter::mode, min, max etc.) by group
#' and use it to fill missing values. Note: this takes and produces a tibble rather than a vector.
#' @param df tibble to use
#' @param group string or vector of strings: columns to group by
#' @param columns string or vector of strings: columns to impute
#' @param overwrite_col boolean: whether to overwrite column. If FALSE, a new column with suffix _imputed will be created
#' @param statistic function: summary statistic to use (mean, median, min etc.). For now requires a function with na.rm argument
#' @param fill_empty_group boolean: If TRUE, fills groups that only contain NA with summary statistic of entire column
#' @return a tibble with filled column(s)
#' @importFrom dplyr %>%
#' @importFrom rlang :=
#' @export
fill_with_agg_by_group <- function(df, group, columns, overwrite_col = FALSE, statistic = mean, fill_empty_group = FALSE){
  ## Fills missing values with summary statistics (mean, median, vvconverter::mode, etc.) per group
  new_cols <- columns %>% purrr::map_dfc(function(col){
    col_output = ifelse(overwrite_col, col, paste0(col, "_imputed"))
    df <- df %>%
      fill_col_with_agg_by_group(group, col, col_output, statistic)
    if (fill_empty_group){
      df <- df %>%
        fill_col_with_agg_by_group(group=c(), col, col_output, statistic)
    }
    return(df %>% dplyr::select(col_output))
  })
  ## Add updated columns to df
  if (!overwrite_col) {
    df <- cbind(df, new_cols)
  }
  else {
    df[columns] = new_cols
  }
  return(df)
}

#' Fill column with aggregate by group
#'
#' Function for use in fill_with_agg_by_group(). Could be used by itself, but adds no value over
#' fill_with_agg_by_group().
#'
#' Calculate a summary statistic (mean, median, vvconverter::mode, min, max etc.) by group
#' and use it to fill missing values in a single column. Note: this takes and produces a tibble rather than a vector.
#'
#' @param df tibble to use
#' @param group string or vector of strings: columns to group by
#' @param col string: column to impute
#' @param col_output string: column name of new imputed column
#' @param statistic function: summary statistic to use (mean, median, min etc.). For now requires a function with na.rm argument
#' @return a tibble with filled column
#' @importFrom dplyr %>%
#' @importFrom rlang :=
#' @export
fill_col_with_agg_by_group <- function(df, group, col, col_output, statistic){
  ## Fills missing values with summary statistics (mean, median, vvconverter::mode, etc.) per group
  df <- df %>%
    dplyr::group_by(!!!dplyr::syms(group)) %>%
    dplyr::mutate({{col_output}} := ifelse(is.na(!!dplyr::sym(col)),
                                           statistic(!!dplyr::sym(col), na.rm = T),
                                           !!dplyr::sym(col))) %>%
    dplyr::ungroup()
  return(df)
}
