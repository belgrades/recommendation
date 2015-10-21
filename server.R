
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
library(shiny)
library(arules)
library(arulesViz)
source("utils.R")

shinyServer(function(input, output) {
  
  output$checkGroup <- renderPrint({ input$checkGroup })
  output$date <- renderPrint({ input$date })
  # output$dates <- renderPrint({ input$dates })
  output$file <- renderPrint({ input$file })
  
  trans <- reactive({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    data = read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                    quote=input$quote)
    
    data$items = as.character(data$items)
    print("hola")
    transactions = create_transactions(data)
    
  })
  
  output$classic <- renderPlot({
    if(is.null(trans()))
      return(NULL)
    rules = apriori(trans(), parameter = list(supp = 0.0025,conf = 0.7,target = "rules"))
    plot(rules)
  })
  
  output$plot <- renderPlot({
        if(is.null(trans()))
          return(NULL)
        rules = apriori(trans(), parameter = list(supp = 0.0025,conf = 0.7,target = "rules"))
        plot(head(sort(rules, by = "support"),20) , method="graph")
  })
  output$contents <-  renderPlot({
        if(is.null(trans()))
          return(NULL)
        rules = apriori(trans(), parameter = list(supp = 0.0025,conf = 0.7,target = "rules"))
        plot(head(sort(rules, by = "support"),100), method="grouped")
  })


})
