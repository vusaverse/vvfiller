#' NA impute median
#'
#' Is a specialised function which takes a variable and turns it into two new variables
#' to be used in a prediction model.
#' 1) the variable for which missing values are imputed by the median for the given year.
#' 2) an indicator when the variable is missing
#'
#' @param data The data frame.
#'
#' @param var The variable used to create new variables.
#' @param year Year used for the median for imputation.
#'
#' @return New data frame in which missing values are filled.
#' @export
NA_impute_median <- function(data, var, year = 2014){
  INS_Inschrijvingsjaar <- NULL
  print(var)

  ## Voeg een indicator toe voor wanneer
  data[,paste("NA_ind_",var,sep="")] <- is.na(data[,var])

  ## Bereken de mediaan van het oorspronkelijke veld:
  mediaan <- stats::median(subset(data,INS_Inschrijvingsjaar%in%year)[,var],na.rm=T)

  ## Voeg een nieuw, opgevuld veld toe:
  new_var <- paste(var,"opgevuld",sep="_")
  data[,new_var] <- data[,var]
  data[,new_var][is.na(data[,new_var])] <- mediaan

  return(data)
}
