
shinyServer(function(input, output, session) {

titstyle <- "text-indent: 4em; family:calibri;font-weight:bold;font-size:12px;"

myTitle <- reactive({
  
  "Example Title"
  
})

output$title <- renderUI({
  
 p(myTitle(), 
       style = titstyle)
  
})



nicetable <- reactive({
 
  cbind(rownames(mtcars), mtcars)
  
})


output$plot <- renderPlot({
  
  plot(as.formula(paste(input$yvar, input$xvar, sep = "~")), data = nicetable(), main = myTitle())
  
})

output$table <- renderDataTable({
  
  nicetable()
  
})


 output$downloadData <- downloadHandler(
    filename = function() { paste("Example-Shiny-Output" , ".xlsx", sep = "") },
    content = function(file) {
       
   outtab <- nicetable()
      
    title <- myTitle()
        
wb <- formatDataFrame(outtab,
                      "www/Standard Report Template.xlsx", ## edit this template if you want
                      file, 
                      save = TRUE, 
                      sheet = 2, 
                      sr = 9, 
                      sc = 1, 
                      styleList = c("textStyle", rep("numberStyle", 10)), title = title,
                      freezeFrame = FALSE)

    }
 )


output$downloadFigure <- downloadHandler(
  filename = function() { paste("Example-Shiny-Plot" , ".png", sep = "") },
  content = function(file){
    
     outtab <- nicetable()
     
     mainTit <- myTitle()
     
     png(file, width = 8, height = 6.5, units = "in", res = 500)
     par(cex = .75)
     

      plot(as.formula(paste(input$yvar, input$xvar, sep = "~")), data = outtab, main = mainTit)
        
     dev.off()
    
  }
  )


})
