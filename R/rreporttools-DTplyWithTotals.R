#' Compute on subgroups and subtotals using \link{data.table} instead of data.frame.
#'
#' This function takes a data table, subsets it according to the levels of one or more variables, and returns a data table containing the results computed on each subset, in addition to results computed on aggregate groups. See \link{ddplyWithTotals} for an alternative. 
#'
#' @param DT data.table object to subset. Does not require a key, see \link{data.table}.
#' @param variables Vector of character strings denoting variables to split on. Variables must be factors. 
#' @param EXPR An expression that indicates what to do with each subset of the data table
#' @param nestedOnly Logical. Compute subtotals only for nested groups. 
#' @param grandTotal Logical. Compute the grand total. 
#' @keywords plyr, subset, subtotal, data.table
#' @export
#' @examples
#' mtcars2 <- data.table(mtcars, key = c("cyl", "gear"))
#' mtcars2[, cyl := as.factor(cyl)]
#' mtcars2[, gear := as.factor(gear)]
#' DTplyWithTotals(mtcars2, c("cyl", "gear"), list(mean = mean(wt)), grandTotal = TRUE)
#' 
#' 

DTplyWithTotals <- function(DT, variables, EXPR, nestedOnly = FALSE, grandTotal = FALSE){

    
  test <- sapply(variables, function(v) is.factor(DT[[v]]))
  if(FALSE %in% test) stop(paste("Non factor variables detected:", paste(variables[!test], collapse = ", ")))
  
  fullTab <- DT[ , eval(substitute(EXPR)), by = variables]
  
  len <- length(variables)
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
      varTmp <- variables[combos[[i]][,j]]
      if(length(varTmp)==0){
        plytemp <- addTotalNames(DT[, eval(substitute(EXPR))])
        tabOut <- rbind(tabOut, plytemp, use.names = TRUE)
        next
      }
      plytemp <- addTotalNames(DT[, eval(substitute(EXPR)), by = eval(varTmp)])
      tabOut <- rbind(tabOut, plytemp, use.names = TRUE)
    }
  }
  setkeyv(tabOut, cols = paste(variables))
  for(var in variables){
    var <- paste(var)
    if(is.factor(tabOut[[var]])){ 
      levels(tabOut[[var]])[levels(tabOut[[var]])=="zzTotal"] <- "Total" 
    } else{
      tabOut[[var]][tabOut[[var]]=="zzTotal"] <- "Total"
    }
  }
  return(tabOut)
  
}

