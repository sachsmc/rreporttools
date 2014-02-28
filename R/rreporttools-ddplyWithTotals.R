#' Extends \link{ddply} to calculate totals and subtotals.
#'
#' This function takes a data frame, subsets it according to the levels of one or more variables, and returns a data frame containing the results computed on each subset, in addition to results computed on aggregate groups. See \link{ddply} for more details. See also \link{DTplyWithTotals}.
#'
#' @param .data Data frame to subset. 
#' @param .variables Vector of character strings or formula denoting variables to split on. 
#' @param .fun A function that returns a data frame, to be computed on each subset. 
#' @param nestedOnly Logical. Compute subtotals only for nested groups. 
#' @param grandTotal Logical. Compute the grand total. 
#' @keywords plyr, subset, subtotal
#' @export
#' @examples
#' ddplyWithTotals(mtcars, ~cyl + gear, function(df) data.frame(mean = mean(df$wt)))
#' 
#' 
ddplyWithTotals <- function(.data, .variables, .fun = NULL, 
                            nestedOnly = FALSE, grandTotal = FALSE){

  .variables <- as.quoted(.variables)
  
  fullTab <- ddply(.data, .variables, .fun)
  len <- length(.variables)
  combos <- lapply(1:(len-1), function(i) combn(1:len, i))
  if(grandTotal) combos[[len]] <- matrix(0)
  if(nestedOnly){ combos <- lapply(1:(len-1), function(i) matrix((1:len)[1:i])  ) }
  
  addTotalNames <- function(df){
    
    tempout <- df
    missingNames <- unique(unlist(lapply(names(fullTab), 
                         function(nm){
                           gp <- grep(nm, names(tempout), value=FALSE)
                           if(length(gp) == 0) return(nm)}
                           )))
  
    for(nm in missingNames){ tempout[[nm]] <- "zzTotal"  }
    tempout
    
  }

  tabOut <- fullTab
  
  for(i in 1:length(combos)){
    for(j in 1:dim(combos[[i]])[2]){
      plytemp <- addTotalNames(ddply(.data, .variables[combos[[i]][,j]], .fun))
      tabOut <- merge(tabOut, plytemp, all = TRUE)
    }
  }
  for(var in .variables){
    var <- paste(var)
    if(is.factor(tabOut[[var]])){ 
      levels(tabOut[[var]])[levels(tabOut[[var]])=="zzTotal"] <- "Total" 
    } else{
      tabOut[[var]][tabOut[[var]]=="zzTotal"] <- "Total"
    }
  }
  tabOut$.id <- NULL
  return(tabOut)
  
}
