\name{mydbGetQuery}
\alias{mydbGetQuery}
\title{Retrieve a table from a JDBC connection and return a data.table or data.frame}
\usage{
mydbGetQuery(conn, statement, data.table = TRUE, key = NULL, ...)
}
\arguments{
  \item{conn}{Connection object to database. See
  \link{dbConnect}}

  \item{statement}{Character string containing SQL
  statement. Do not end with a semicolon}

  \item{data.table}{Logical, return resulting object as a
  \link{data.table}.}

  \item{key}{Character string indicating which variable to
  use as the index. Ignored if data.table = FALSE.}

  \item{...}{expressions passed to dbSendQuery()}
}
\description{
This function extends \link{dbGetQuery} by setting the
column names to lower case, and optionally returning the
result as an indexed data.table. This is extremely useful
for large queries.
}
\examples{
#mydbGetQuery(conn, "select * from all_tables", TRUE, "owner")
}
\keyword{JDBC}
\keyword{database,}
\keyword{sql,}

