\name{convertSASQuery}
\alias{convertSASQuery}
\title{Retrieve a sas file and extract all SQL queries from it.}
\usage{
convertSASQuery(sasFile, user, pass, submit = TRUE, env = .GlobalEnv,
  pathToOJ = "C:/app/OITDSKADM/product/11.2.0/client_1/jdbc/lib/ojdbc6.jar")
}
\arguments{
  \item{sasFile}{Path to the sas code file.}

  \item{user}{Character string containing IMPAC II
  username}

  \item{pass}{Character string containing IMPAC II
  password}

  \item{submit}{Logical, pull the data}

  \item{env}{If submit is TRUE, environment in which to
  load the data. Don't modify this unless you know what you
  are doing}

  \item{pathToOJ}{Path to the oracle database driver.
  Depends on your machine, search for ojdbc6.jar from the
  Windows start menu.}
}
\description{
This function takes sas code, extracts all the SQL queries
and then optionally pulls them from IMPAC II. If the query
is not sent to the database, it will return the extracted
statements as a list of strings for editing or inspection.
}
\keyword{conversion}
\keyword{database,}
\keyword{sas,}
\keyword{sql,}
\keyword{string}

