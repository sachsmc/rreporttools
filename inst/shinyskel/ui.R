headsty <- "text-align:center;background-color:#000099;color:white;font-size:11px;"  


shinyUI(
    pageWithSidebar(
      
          
      headerPanel(
                             
            list(p("Organization Name", 
                     a("Contact", href="mailto:example@web.com", style=headsty), 
                     a("www.google.com",href="http://www.google.com", style=headsty), 
                     style=headsty), 
                    
                   h6("Example Shiny App", style="text-align:center;")) , windowTitle = "Example Shiny App"), 
  

  sidebarPanel(  tags$head(
       tags$style(type="text/css", "label.radio { display: inline-block; }", ".radio input[type=\"radio\"] { float: none; }"),
        tags$style(type="text/css", "select { max-width: 180px; }"),
        tags$style(type="text/css", "textarea { max-width: 180px; }"),
        tags$style(type="text/css", "text { width: 15px; !important }"),
        tags$style(type="text/css", ".jslider { max-width: 240px; }"),
        tags$style(type='text/css', ".span4 { max-width: 275px; }"),
        tags$title("Example Shiny App")
      ),
   
            
     h5("Example Inputs"),
      radioButtons("radio", "Radio Buttons", 
                   list("Choice 1" = "A", 
                        "Choice 2" = "B", 
                        "Choice 3" = "C"))
                 
       
        , 
            
      
       
      selectInput("xvar", p(h5("X variable")), colnames(mtcars)),
      selectInput("yvar", p(h5("Y variable")), colnames(mtcars), selected = "cyl"),
                 
    checkboxInput("check", "CheckboxInput with Conditional Panel", value = TRUE),
    conditionalPanel(condition = "input.check == true", 
    p(h5("This only displays when the checkbox is checked"))
     ), 
      
      sliderInput("slide", "sliderInput", 0, 100, 0, animate = TRUE)
      
       
     
      ,
             downloadButton("downloadData", "Download Data in Excel"),
                       downloadButton("downloadFigure", "Download Figure as png"),
           
                 
              helpText( list(p("Questions or Comments? Email", 
                     a("example@email.com", href="mailto:example@email.com", 
                       style=headsty) ), 
                                           p("Notes go here", style = "font-size:9px")))
           
           ),
    
   mainPanel( tabsetPanel(   tabPanel("Plot", plotOutput("plot")), 
                            tabPanel("Table", dataTableOutput("table")))
            )
    
    
  
))
