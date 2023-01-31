#' NA impute median
#'
#' Is a specialized function which takes a variable and turns it into two new variables
#' to be used in a prediction model.
#' 1) the variable for which missing values are imputed by the median for the given year.
#' 2) an indicator when the variable is missing
#'
#' @param data The data frame.
#'
#' @param var The variable used to create new variables.
#' @param year Year used for the median for imputation.
#' @param year_column Column with year to use median on.
#'
#' @return New data frame in which missing values are filled.
#' @export
na_impute_median <- function(data, var, year = 2014, year_column){

  ## Add an indicator for when
  data[,paste("NA_ind_", var, sep="")] <- is.na(data[,var])

  ## Calculate the median of the original field:
  median <- stats::median(subset(data, !!year_column %in% year)[,var], na.rm=T)

  ## Add a new filled field:
  new_var <- paste(var, "imputed", sep="_")
  data[,new_var] <- data[,var]
  data[,new_var][is.na(data[,new_var])] <- median

  return(data)
}
