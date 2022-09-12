#' Fill missing rownumber
#'
#' Een functie om missende waarden van een telvariabele op te vullen. De ontbrekende
#' missende waarden worden opgevuld door door te tellen vanaf de laatst bekende
#' waarde.
#' c(NA,4,NA,NA) wordt bijvoorbeeld c(NA,4,5,6)
#'
#' @param x een vector met integers
#' @return x, met de NA's opgevuld indien mogelijk
#' @family vector berekeningen
#' @family missing data functies
#' @export
#' @examples fill_missing_rownumber(c(NA,4,NA,NA))
fill_missing_rownumber <- function(x){
    ## Als er geen bekende waarden in x zitten kan de functie niet opvullen
    if (length(stats::na.omit(x)) == 0) {
        return(x)
    }
    ## Als x niet een numeric is kan niet opgevuld worden
    if (!is.numeric(x)) {
        return(x)
    }

    ## Bepaal de positie van de maximale waarde
    position_max <- match(max(x, na.rm = T), x)
    length_x <- length(x)
    ## Voer onderstaande alleen uit als de maximale waarde niet de laatste waarde is
    if (position_max < length_x) {
        ## Bepaal de posities van missende waarden die opgevuld kunnen worden
        position_missing <- (position_max + 1):length_x
        ## vul die posities op, door door te tellen
        x[position_missing] <- x[position_max] + position_missing - position_max
    }
    return(x)
}
