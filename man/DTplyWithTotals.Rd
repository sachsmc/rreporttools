\name{DTplyWithTotals}
\alias{DTplyWithTotals}
\title{Compute on subgroups and subtotals using \link{data.table} instead of data.frame.}
\usage{
DTplyWithTotals(DT, variables, EXPR, nestedOnly = FALSE, grandTotal = FALSE)
}
\arguments{
  \item{DT}{data.table object to subset. Does not require a
  key, see \link{data.table}.}

  \item{variables}{Vector of character strings denoting
  variables to split on. Variables must be factors.}

  \item{EXPR}{An expression that indicates what to do with
  each subset of the data table}

  \item{nestedOnly}{Logical. Compute subtotals only for
  nested groups.}

  \item{grandTotal}{Logical. Compute the grand total.}
}
\description{
This function takes a data table, subsets it according to
the levels of one or more variables, and returns a data
table containing the results computed on each subset, in
addition to results computed on aggregate groups. See
\link{ddplyWithTotals} for an alternative.
}
\examples{
mtcars2 <- data.table(mtcars, key = c("cyl", "gear"))
mtcars2[, cyl := as.factor(cyl)]
mtcars2[, gear := as.factor(gear)]
DTplyWithTotals(mtcars2, c("cyl", "gear"), list(mean = mean(wt)), grandTotal = TRUE)
}
\keyword{data.table}
\keyword{plyr,}
\keyword{subset,}
\keyword{subtotal,}

