
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  tags$head(tags$style(HTML("
                            .shiny-text-output {
                            background-color:#fff;
                            }
                            "))),
  
  h1("Recommendation: ", span("URL-Cookies", style = "font-weight: 300"), 
     style = "font-family: 'Source Sans Pro';
     color: #fff; text-align: center;
     background-image: url('texturebg.png');
     padding: 20px"),
  br(),
  
  fluidRow(
    column(8,
           p("Upload transactions and choose dates to predict behaviour", 
             style = "font-family: 'Source Sans Pro';")
    )
    ),
  
  
  br(),
  
  fluidRow(
    column(3,
           wellPanel(
             checkboxGroupInput("checkGroup", 
                                label = h3("Articles"), 
                                choices = list("deportes/articulo1" = "deportes/articulo1",
                                               "deportes/articulo2" = "deportes/articulo2" , 
                                               "deportes/articulo3"  = "deportes/articulo3" ,
                                               "politica/articulo1" = "politica/articulo1",
                                               "politica/articulo1" = "politica/articulo1",
                                               "politica/articulo3" = "politica/articulo3",
                                               "variedades/articulo1" = "variedades/articulo1",
                                               "variedades/articulo2" = "variedades/articulo2",
                                               "variedades/articulo3" = "variedades/articulo3",
                                               "internacional/articulo1" = "internacional/articulo1",
                                               "internacional/articulo2" = "internacional/articulo2",
                                               "internacional/articulo3" = "internacional/articulo3"),
                                selected = 1),
             hr(),
             p("Current Values:", style = "color:#888888;"), 
             verbatimTextOutput("checkGroup"),
             a("See Code", class = "btn btn-primary btn-md", 
               href = "https://gallery.shinyapps.io/069-widget-check-group/")
           )),
    column(3,
           wellPanel(fileInput('file1', 'Choose CSV File',
                               accept=c('text/csv', 
                                        'text/comma-separated-values,text/plain', 
                                        '.csv')),
                     tags$hr(),
                     checkboxInput('header', 'Header', TRUE),
                     radioButtons('sep', 'Separator',
                                  c(Comma=',',
                                    Semicolon=';',
                                    Tab='\t'),
                                  ','),
                     radioButtons('quote', 'Quote',
                                  c(None='',
                                    'Double Quote'='"',
                                    'Single Quote'="'"),
                                  '"'),
                     hr(),
                     dateRangeInput("dates", label = h3("Date range"))
           )),
    column(6,
           wellPanel(
             tableOutput('contents')
           ))
  ),
  
  fluidRow(
    
    column(4,
           wellPanel(
             dateRangeInput("dates", label = h3("Date range")),
             hr(),
             p("Current Values:", style = "color:#888888;"), 
             verbatimTextOutput("dates"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/072-widget-date-range/")
           )),
    
    column(4,
           wellPanel(
             fileInput("file", label = h3("File input")),
             hr(),
             p("Current Value:", style = "color:#888888;"), 
             verbatimTextOutput("file"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/073-widget-file/")
           ))
  ),
  
  fluidRow(
    
    column(4,
           wellPanel(
             numericInput("num", label = h3("Numeric input"), value = 1),
             hr(),
             p("Current Value:", style = "color:#888888;"), 
             verbatimTextOutput("num"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/074-widget-numeric/")
           )),
    
    column(4,
           wellPanel(
             radioButtons("radio", label = h3("Radio buttons"),
                          choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                          selected = 1),
             hr(),
             p("Current Values:", style = "color:#888888;"), 
             verbatimTextOutput("radio"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/075-widget-radio/")
           )),
    
    column(4,
           wellPanel(
             selectInput("select", label = h3("Select box"), 
                         choices = list("Choice 1" = 1, "Choice 2" = 2,
                                        "Choice 3" = 3), selected = 1),
             hr(),
             p("Current Value:", style = "color:#888888;"), 
             verbatimTextOutput("select"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/076-widget-select/")
           ))
  ),
  
  fluidRow(
    
    column(4,
           wellPanel(
             sliderInput("slider1", label = h3("Slider"), min = 0, max = 100, 
                         value = 50),
             hr(),
             p("Current Value:", style = "color:#888888;"), 
             verbatimTextOutput("slider1"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/077-widget-slider/")
           )),
    
    column(4,
           wellPanel(
             sliderInput("slider2", label = h3("Slider range"), min = 0, 
                         max = 100, value = c(25, 75)),
             hr(),
             p("Current Values:", style = "color:#888888;"), 
             verbatimTextOutput("slider2"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/077-widget-slider/")
           )),
    
    column(4,
           wellPanel(
             textInput("text", label = h3("Text input"), 
                       value = "Enter text..."),
             hr(),
             p("Current Value:", style = "color:#888888;"), 
             verbatimTextOutput("text"),
             a("See Code", class = "btn btn-primary btn-md",  
               href = "https://gallery.shinyapps.io/080-widget-text/")
           )) 
  )
  
    ))
