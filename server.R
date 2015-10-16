
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(arules)

lappend <- function ( lst, ...){
  lst <- c(lst, list(...))
  return(lst)
}

eappend <- function(elem, ...){
  elem <- c(elem, ...)
  return(elem)
}

shinyServer(function(input, output) {
  
  output$action <- renderPrint({ input$action })
  output$checkbox <- renderPrint({ input$checkbox })
  output$checkGroup <- renderPrint({ input$checkGroup })
  output$date <- renderPrint({ input$date })
  output$dates <- renderPrint({ input$dates })
  output$file <- renderPrint({ input$file })
  output$num <- renderPrint({ input$num })
  output$radio <- renderPrint({ input$radio })
  output$select <- renderPrint({ input$select })
  output$slider1 <- renderPrint({ input$slider1 })
  output$slider2 <- renderPrint({ input$slider2 })
  #output$submit <- renderPrint({ input$submit })
  output$text <- renderPrint({ input$text })
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    data = read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
    
    transactions <<- list()
    for(i in 1:1000){
      single = character()
      for(page in strsplit(x = data$items[i], split = ",")[[1]]){
        single = eappend(single, page)
      }
      transactions <<- lappend(transactions, single)
    }
    
    k <<- apriori(transactions, 
                parameter = list(supp = 0.005, 
                                 conf = 0.8,
                                 target = "rules"))
    
    head(data, n = 16)
  })


})
