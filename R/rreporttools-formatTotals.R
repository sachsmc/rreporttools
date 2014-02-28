#' Extends \link{formatDataFrame} to correctly format rows that are labeled with "Total"
#'
#' This function loads an Excel workbook that contains data and then formats rows labeled with "Total" to conform to the DSAR guidelines. 
#'
#' @param wb Optional workbook object as returned by \code{formatDataFrame} or \link{loadWorkbook}
#' @param df Data frame to write out
#' @param styleLookup Character vector of format types, see details
#' @param sheet Number of sheet to write output to
#' @param sr Start row of output
#' @keywords Excel, export, formatting
#' @export
#' 
#' @details
#' Possible values for the \code{styleList} are \code{"textStyle"}, \code{"moneyStyle"}, \code{"percStyle"}, \code{"countStyle"}, \code{"yearStyle"}. They should be self-explanatory and they conform with the DSAR template requirements. 
#' 
#' 

formatTotals <- function(wb, df, styleLookup, sheet = 2, sr = 7){

textStyle <- CellStyle(wb)  +   Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
  Alignment(h = "ALIGN_CENTER", wrapText=TRUE)+ 
  Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
  Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)

moneyStyle <- CellStyle(wb) +Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
  Alignment(h = "ALIGN_RIGHT") +   DataFormat("$###,###,###,###0")+
  Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
  Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)

percStyle <- CellStyle(wb) + Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
  Alignment(h = "ALIGN_RIGHT") +   DataFormat("#0.0%")+
  Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
  Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)

numberStyle <- CellStyle(wb) + Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
  Alignment(h = "ALIGN_RIGHT") +   DataFormat("###.##")+
  Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
  Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)
  
countStyle <- CellStyle(wb) +   Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
  Alignment(h = "ALIGN_RIGHT") +   DataFormat("###,###,###0")+
  Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
  Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)

yearStyle <- CellStyle(wb) +   Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("####0")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)

sr <- sr+1
totRows <- unique(unlist(lapply(df, function(col) grep("Total", col))))
myRows <- getRows(getSheets(wb)[[sheet]], rowIndex = sr:(sr+dim(df)[1]))

for(j in 1:length(totRows)){
  ctemp <- getCells(myRows[totRows[j]])
  for(i in 1:length(ctemp)){
    ctemp2 <- ctemp[[i]]
    setCellStyle(ctemp2, get(styleLookup[i]))
  }
}

return(wb)

}