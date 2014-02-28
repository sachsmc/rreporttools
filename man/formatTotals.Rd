\name{formatTotals}
\alias{formatTotals}
\title{Extends \link{formatDataFrame} to correctly format rows that are labeled with "Total"}
\usage{
formatTotals(wb, df, styleLookup, sheet = 2, sr = 7)
}
\arguments{
  \item{wb}{Optional workbook object as returned by
  \code{formatDataFrame} or \link{loadWorkbook}}

  \item{df}{Data frame to write out}

  \item{styleLookup}{Character vector of format types, see
  details}

  \item{sheet}{Number of sheet to write output to}

  \item{sr}{Start row of output}
}
\description{
This function loads an Excel workbook that contains data
and then formats rows labeled with "Total" to conform to
the DSAR guidelines.
}
\details{
Possible values for the \code{styleList} are
\code{"textStyle"}, \code{"moneyStyle"},
\code{"percStyle"}, \code{"countStyle"},
\code{"yearStyle"}. They should be self-explanatory and
they conform with the DSAR template requirements.
}
\keyword{Excel,}
\keyword{export,}
\keyword{formatting}

