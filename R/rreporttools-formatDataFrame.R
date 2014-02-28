#' Extends \link{addDataFrame} to output data into formatted Excel spreadsheets.
#'
#' This function loads an Excel workbook, writes a data frame to the specified tab in the specified location, formats the columns, and then saves the output. Options allow you to load an existing workbook (say to add multiple data frames to different tabs), add freezeframes, autosize columns, and more. 
#'
#' @param df Data frame to write out
#' @param wb Optional workbook object as returned by \code{formatDataFrame} or \link{loadWorkbook}
#' @param templateFile Excel template file, default is DSAR's current template
#' @param outputFile Name of file to write out if \code{save = TRUE}
#' @param save Logical, save the result to outputFile
#' @param sheet Number of sheet to write output to
#' @param sr Start row of output
#' @param sc Start column of output
#' @param styleList Character vector of format types, see details
#' @param autoSize Logical, autosize columns
#' @param freezeFrame Logical, freezeframe the top row
#' @param load Logical, load the template file before writing output
#' @keywords Excel, export, formatting
#' @export
#' 
#' @details
#' Possible values for the \code{styleList} are \code{"headerStyle"}, \code{"totalStyle"}, \code{"textStyle"}, \code{"moneyStyle"}, \code{"percStyle"}, \code{"countStyle"}, \code{"yearStyle"}, \code{"dateStyle"}, and \code{"numberStyle"}. They should be self-explanatory and they conform with the DSAR template requirements. 
#' 
#' 

formatDataFrame <- function(df, wb = NULL,
                            templateFile = paste(path.package("rreporttools"), "DSAR Report Template Number 24-Standard and PII - Feb 2014.xlsx", sep = "/"), 
                            outputFile = "ROutput.xlsx", 
                            save = TRUE, 
                            sheet = 2, 
                            sr = 7, 
                            sc = 1, 
                            styleList,
                            autoSize = TRUE, freezeFrame = TRUE, load = TRUE){

  
  if(load) {wb <- loadWorkbook(file = templateFile)}
  
  sheets <- getSheets(wb)
  
  headerStyle <-CellStyle(wb)  + Fill(foregroundColor=grey(.85)) + 
    Alignment(h = "ALIGN_CENTER", wrapText = TRUE) + 
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THICK") + 
    Font(wb, name = "Calibri", heightInPoints = 10, isBold = TRUE)
  
  totalStyle <-CellStyle(wb)  + Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
    Alignment(h = "ALIGN_CENTER", wrapText = TRUE) + 
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN") + 
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)
  
  textStyle <- CellStyle(wb)  +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_CENTER", wrapText=TRUE)+ 
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  moneyStyle <- CellStyle(wb) + Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("$###,###,###,###0")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  percStyle <- CellStyle(wb) + Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("#0.0%")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  numberStyle <- CellStyle(wb) + Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("###.##")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  countStyle <- CellStyle(wb) +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("###,###,###0")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  yearStyle <- CellStyle(wb) +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("####0")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  dateStyle <- CellStyle(wb) +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("m/d/yyyy")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  myStyleList <- lapply(styleList, function(d) get(d, envir = sys.frame(1)) )
  names(myStyleList) <- 1:length(myStyleList)
    
  addDataFrame(df, sheets[[sheet]], 
               row.names = FALSE, startRow=sr, startColumn = sc,
               colnamesStyle=headerStyle,
               colStyle = myStyleList)
  
  if(autoSize) autoSizeColumn(sheets[[sheet]], 1:dim(df)[2])
  if(freezeFrame) createFreezePane(sheets[[sheet]], sr+1, 1, startRow = sr+1, startColumn = 1)
  if(save){ saveWorkbook(wb, outputFile) } else { return(wb) }
  
  
}
