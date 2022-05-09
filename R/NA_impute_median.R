#' NA impute median
#'
#' Is een specifieke functie die op basis van 1 variabele, 2 nieuwe variabelen aanmaakt
#' voor gebruik in een voorspelmodel:
#' 1) de variabele, waarbij de missende waarden opgevuld zijn door de mediaan van
#' het opgegeven jaartal.
#' 2) een indicator voor wanneer de variabele missing is.
#'
#' @param data De data frame.
#'
#' @param var De variabele waarmee nieuwe variabelen worden aangemaakt.
#' @param jaar Jaartal waarmee missende waarden worden opgevuld door de mediaan.
#'
#' @return Nieuwe data frame waarbij de missende waarden zijn opgevuld.
#' @export
NA_impute_median <- function(data, var, jaar = 2014){
  print(var)

  ## Voeg een indicator toe voor wanneer
  data[,paste("NA_ind_",var,sep="")] <- is.na(data[,var])

  ## Bereken de mediaan van het oorspronkelijke veld:
  mediaan <- stats::median(subset(data,INS_Inschrijvingsjaar%in%jaar)[,var],na.rm=T)

  ## Voeg een nieuw, opgevuld veld toe:
  new_var <- paste(var,"opgevuld",sep="_")
  data[,new_var] <- data[,var]
  data[,new_var][is.na(data[,new_var])] <- mediaan

  return(data)
}
