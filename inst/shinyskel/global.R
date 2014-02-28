
.simpleCap <- function(x) {
  s <- strsplit(tolower(x), " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
}


###############################################


formatDataFrame <- function(df,
                            templateFile, 
                            outputFile, 
                            save = TRUE, 
                            sheet = 1, 
                            sr = 8, 
                            sc = 1, 
                            styleList, title = "", 
                            autoSize = TRUE, freezeFrame = TRUE, load = TRUE, ...){
  require(xlsx)
  
  if(load) {wb <- loadWorkbook(file = templateFile)}
  
  sheets <- getSheets(wb)
  
  headerStyle <<-CellStyle(wb)  + Fill(foregroundColor=grey(.85)) + 
    Alignment(h = "ALIGN_CENTER", wrapText = TRUE) + 
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THICK") + 
    Font(wb, name = "Calibri", heightInPoints = 10, isBold = TRUE)
  
  totalStyle <<-CellStyle(wb)  + Fill(foregroundColor=rgb(197,217,241, maxColorValue=256)) + 
    Alignment(h = "ALIGN_CENTER", wrapText = TRUE) + 
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN") + 
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)
  
  textStyle <<- CellStyle(wb)  +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_CENTER", wrapText=TRUE)+ 
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  titleStyle <<- CellStyle(wb)  +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_CENTER", wrapText=FALSE)+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = TRUE)
  
  moneyStyle <<- CellStyle(wb) + Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("$###,###,###,###0")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  percStyle <<- CellStyle(wb) + Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("#0.0%")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  countStyle <<- CellStyle(wb) +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("###,###,###0")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  numberStyle <<- CellStyle(wb) +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("###.##")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  dateStyle <<- CellStyle(wb) +   Fill(foregroundColor="white") + 
    Alignment(h = "ALIGN_RIGHT") +   DataFormat("m/d/yyyy")+
    Border(position = c("LEFT", "RIGHT", "TOP", "BOTTOM"), pen = "BORDER_THIN")+
    Font(wb, name = "Calibri", heightInPoints = 9, isBold = FALSE)
  
  titleRow <- createRow(sheets[[sheet]], rowIndex = 3)
  titleCell <- createCell(titleRow, colIndex = 5)
  setCellValue(titleCell[1,1][[1]], title)
  setCellStyle(titleCell[1,1][[1]], titleStyle)
  
  myStyleList <- lapply(styleList, get )
  names(myStyleList) <- 1:length(myStyleList)
  
  addDataFrame(df, sheets[[sheet]], 
               row.names = FALSE, startRow=sr, startColumn = sc,
               colnamesStyle=headerStyle,
               colStyle = myStyleList)
  
  if(autoSize) autoSizeColumn(sheets[[sheet]], 1:dim(df)[2])
  if(freezeFrame) createFreezePane(sheets[[sheet]], sr+1, 1, startRow = sr+1, startColumn = 1)
  if(save){ saveWorkbook(wb, outputFile) } else { return(wb) }
  
  
  
  
}
