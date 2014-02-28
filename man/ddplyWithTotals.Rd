\name{ddplyWithTotals}
\alias{ddplyWithTotals}
\title{Extends \link{ddply} to calculate totals and subtotals.}
\usage{
ddplyWithTotals(.data, .variables, .fun = NULL, nestedOnly = FALSE,
  grandTotal = FALSE)
}
\arguments{
  \item{.data}{Data frame to subset.}

  \item{.variables}{Vector of character strings or formula
  denoting variables to split on.}

  \item{.fun}{A function that returns a data frame, to be
  computed on each subset.}

  \item{nestedOnly}{Logical. Compute subtotals only for
  nested groups.}

  \item{grandTotal}{Logical. Compute the grand total.}
}
\description{
This function takes a data frame, subsets it according to
the levels of one or more variables, and returns a data
frame containing the results computed on each subset, in
addition to results computed on aggregate groups. See
\link{ddply} for more details. See also
\link{DTplyWithTotals}.
}
\examples{
ddplyWithTotals(mtcars, ~cyl + gear, function(df) data.frame(mean = mean(df$wt)))
}
\keyword{plyr,}
\keyword{subset,}
\keyword{subtotal}

