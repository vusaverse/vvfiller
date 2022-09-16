#' Fill missing rownumber
#'
#' Impute missing values of a count variable. Imputation is done by counting from
#' the last known value. Example: c(NA,4,NA,NA) then becomes c(NA,4,NA,NA).
#' @param x Integer vector.
#' @return Integer vector with filled values.
#' @family vector calculations
#' @family missing data functions
#' @export
#' @examples fill_missing_rownumber(c(NA,4,NA,NA))
fill_missing_rownumber <- function(x){
    ## Check if vector has missing values
    if (length(stats::na.omit(x)) == 0) {
        return(x)
    }
    ## Check if vector is of class numeric
    if (!is.numeric(x)) {
        return(x)
    }

    ## Determine index of max value
    position_max <- match(max(x, na.rm = T), x)
    length_x <- length(x)
    ## If the last known value is not the max the if statement is triggered.
    if (position_max < length_x) {
        ## Determine the positions of the missing values that can be imputed.
        position_missing <- (position_max + 1):length_x
        ## Impute by counting up.
        x[position_missing] <- x[position_max] + position_missing - position_max
    }
    return(x)
}
