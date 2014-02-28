\name{formatDataFrame}
\alias{formatDataFrame}
\title{Extends \link{addDataFrame} to output data into formatted Excel spreadsheets.}
\usage{
formatDataFrame(df, wb = NULL,
  templateFile = paste(path.package("rreporttools"),
  "DSAR Report Template Number 24-Standard and PII - Feb 2014.xlsx", sep = "/"),
  outputFile = "ROutput.xlsx", save = TRUE, sheet = 2, sr = 7, sc = 1,
  styleList, autoSize = TRUE, freezeFrame = TRUE, load = TRUE)
}
\arguments{
  \item{df}{Data frame to write out}

  \item{wb}{Optional workbook object as returned by
  \code{formatDataFrame} or \link{loadWorkbook}}

  \item{templateFile}{Excel template file, default is
  DSAR's current template}

  \item{outputFile}{Name of file to write out if \code{save
  = TRUE}}

  \item{save}{Logical, save the result to outputFile}

  \item{sheet}{Number of sheet to write output to}

  \item{sr}{Start row of output}

  \item{sc}{Start column of output}

  \item{styleList}{Character vector of format types, see
  details}

  \item{autoSize}{Logical, autosize columns}

  \item{freezeFrame}{Logical, freezeframe the top row}

  \item{load}{Logical, load the template file before
  writing output}
}
\description{
This function loads an Excel workbook, writes a data frame
to the specified tab in the specified location, formats the
columns, and then saves the output. Options allow you to
load an existing workbook (say to add multiple data frames
to different tabs), add freezeframes, autosize columns, and
more.
}
\details{
Possible values for the \code{styleList} are
\code{"headerStyle"}, \code{"totalStyle"},
\code{"textStyle"}, \code{"moneyStyle"},
\code{"percStyle"}, \code{"countStyle"},
\code{"yearStyle"}, \code{"dateStyle"}, and
\code{"numberStyle"}. They should be self-explanatory and
they conform with the DSAR template requirements.
}
\keyword{Excel,}
\keyword{export,}
\keyword{formatting}

