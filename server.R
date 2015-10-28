
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
library(shiny)
library(arules)
library(arulesViz)
source("utils.R")
source("url.utils.R")

shinyServer(function(input, output, session) {
  
  output$checkGroup <- renderPrint({ input$checkGroup })
  output$date <- renderPrint({ input$date })
  # output$dates <- renderPrint({ input$dates })
  output$file <- renderPrint({ input$file })
  
  trans <- reactive({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    #progress <- shiny::Progress$new(session, min=1, max=15)
    #on.exit(progress$close())
    
    #progress$set(message = 'Transformando Archivo',
                 #            detail = 'This may take a while...')
    
    data = read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                    quote=input$quote, stringsAsFactors = F)
    
    #progress$set(value = 2)
    
    # Transform URL
    i = 1
    for(url in data$get_params.url){
      data[i, 2] = transform_url(url)
      i=i+1
    }
    
    #progress$set(value = 4)
    
    # Parse TimeStamp
    data$timestamp = substr(data$timestamp,
                            start = 1, 
                            stop = nchar(data$timestamp) -1)
    #progress$set(value = 6)
    
    # Change Date Format from ISO 8601 to POSIX
    data$timestamp = parse_iso_8601(data$timestamp)
    #progress$set(value = 8)
    
    # Create Transactions
    data = create_trans(data = data, tolerance = 120)
    #progress$set(value = 10)
    
    # Transform items
    data$items = as.character(data$items)
    #progress$set(value = 12)
    
    # Filter Transactions
    transactions = create_transactions(data)
    #progress$set(value = 15)
    
  })
  
  output$classic <- renderPlot({
    
    if(is.null(trans()))
      return(NULL)
   
    
    rules = apriori(trans(), parameter = list(supp = 0.005,conf = 0.7,target = "rules"))
    plot(rules)
  })
  
  output$plot <- renderPlot({
    if(is.null(trans()))
      return(NULL)
    rules = apriori(trans(), parameter = list(supp = 0.005,conf = 0.7,target = "rules"))
    windows.options(width = 20, height = 20)
    plot(head(sort(rules, by = "support"), 80) , method="graph", control = list(type = "items", main = "prueba"))
  })
  output$contents <-  renderPlot({
    if(is.null(trans())) 
      return(NULL)
    rules = apriori(trans(), parameter = list(supp = 0.005,conf = 0.7,target = "rules"))
    plot(head(sort(rules, by = "support"),50), method="grouped")
  })


})
