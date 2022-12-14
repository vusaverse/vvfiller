% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fill_missing.R
\name{fill_missing_interval}
\alias{fill_missing_interval}
\title{Fill missing interval}
\usage{
fill_missing_interval(x, min_known_n = NULL, min_known_p = NULL)
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
Fill all missing values for an interval observed in the vector
}
\examples{
fill_missing_interval(c(NA, 1, 2, NA))
fill_missing_interval(c(NA, 10, 20, NA))
}
