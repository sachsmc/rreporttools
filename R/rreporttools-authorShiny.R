#' Author a shiny application
#' 
#' This function creates a shiny directory, initializes it, opens the \code{ui.R} and \code{server.R} for editing, and runs the application as an example. 
#' @param deckdir path to new shiny directory
#' @param open_r whether to open the files created
#' @param run_shiny Whether or not to run the example application
#' @param scaffold path to directory containing example application code
#' @export
authorShiny <- function(deckdir, open_r = TRUE, run_shiny = TRUE,
    scaffold = system.file('shinyskel', package = 'rreporttools')){
  message('Creating slide directory at ', deckdir, '...')
 
  copy_dir(scaffold, deckdir)
  message('Finished creating shiny directory...')
  message('Switching to shiny directory...')
  setwd(deckdir)
 
  if (open_r){
    message('Opening ui and server...')
    file.show("ui.R", "server.R")
  }
  
  if (run_shiny){
  runApp(".")
  }
}


#' Copy directories recursively, creating a new directory if not already there
#' 
#' @keywords internal
#' @noRd
copy_dir <- function(from, to){
  if (!(file.exists(to))){
    dir.create(to, recursive = TRUE)
    message('Copying files to ', to, '...')
    file.copy(list.files(from, full.names = T), to, recursive = TRUE)
  }
}