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
fill_df_with_agg_by_group <- function(df, group, columns, overwrite_col = FALSE, statistic = mean, fill_empty_group = FALSE){
  ## Fills missing values with summary statistics (mean, median, vvconverter::mode, etc.) per group
  new_cols <- columns %>% purrr::map_dfc(function(col){
    col_output = ifelse(overwrite_col, col, paste0(col, "_imputed"))

    df[col_output] <- df %>%
      fill_col_with_agg_by_group(group = group, col = col, statistic = statistic)
    if (fill_empty_group){
      df[col_output] <- df %>%
        fill_col_with_agg_by_group(group = c(), col = col_output, statistic = statistic)
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
#' Calculate a summary statistic (mean, median, vvconverter::mode, min, max etc.) by group
#' and use it to fill missing values in a column. Primarily for use in fill_with_agg_by_group().
#'
#' @param df tibble to use
#' @param group string or vector of strings: columns to group by
#' @param col string: column to impute
#' @param statistic function: summary statistic to use (mean, median, min etc.). For now requires a function with na.rm argument
#' @return a filled vector
#' @importFrom dplyr %>%
#' @importFrom rlang :=
#' @export
fill_col_with_agg_by_group <- function(df, group, col, statistic){
  new <- NULL
  ## Fills missing values with summary statistics (mean, median, vvconverter::mode, etc.) per group
  result_column <- df %>%
    dplyr::group_by(!!!dplyr::syms(group)) %>%
    dplyr::mutate(new = ifelse(is.na(!!dplyr::sym(col)),
                               statistic(!!dplyr::sym(col), na.rm = T),
                               !!dplyr::sym(col))) %>%
    dplyr::ungroup() %>%
    dplyr::pull(new)
  return(result_column)
}