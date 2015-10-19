
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(arules)
library(arulesViz)

done = NULL

lappend <- function ( lst, ...){
  lst <- c(lst, list(...))
  return(lst)
}

eappend <- function(elem, ...){
  elem <- c(elem, ...)
  return(elem)
}

create_transactions = function(trans){
  transactions = list()
  for(i in 1:nrow(trans)){
    single = character()
    for(page in strsplit(x = trans$items[i], split = ",")[[1]]){
      single = eappend(single, page)
    }
    transactions = lappend(transactions, single)
  }
  return(transactions)
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
  
  trans <- function(){
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    data = read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                    quote=input$quote)
    
    data$items = as.character(data$items)
    
    transactions = create_transactions(data)
  }
  
  output$plot <- renderPlot({
        rules = apriori(trans(), parameter = list(supp = 0.0025,conf = 0.7,target = "rules"))
        plot(rules, method="graph")
  })
  output$contents <-  renderPlot({
        rules = apriori(trans(), parameter = list(supp = 0.0025,conf = 0.7,target = "rules"))
        plot(rules, method="grouped")
  })


})
