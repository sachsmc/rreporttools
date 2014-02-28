\name{authorShiny}
\alias{authorShiny}
\title{Author a shiny application}
\usage{
authorShiny(deckdir, open_r = TRUE, run_shiny = TRUE,
  scaffold = system.file("shinyskel", package = "rreporttools"))
}
\arguments{
  \item{deckdir}{path to new shiny directory}

  \item{open_r}{whether to open the files created}

  \item{run_shiny}{Whether or not to run the example
  application}

  \item{scaffold}{path to directory containing example
  application code}
}
\description{
This function creates a shiny directory, initializes it,
opens the \code{ui.R} and \code{server.R} for editing, and
runs the application as an example.
}

