% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fill_missing.R
\name{fill_missing_last}
\alias{fill_missing_last}
\title{Fill missing last}
\usage{
fill_missing_last(x, min_known_n = NULL, min_known_p = NULL)
}
\arguments{
\item{x}{The vector to fill}

\item{min_known_n}{numeric value: the minimum number of not-missing values}

\item{min_known_p}{numeric value between 0 and 1: the minimum fraction of not-missing values}
}
\value{
a filled vector
}
\description{
Fill all missing values in a vector with the last value if it is known.
}
\examples{
fill_missing_last(c(1, 2, NA))
fill_missing_last(c(NA, 1, 2, NA))
}
