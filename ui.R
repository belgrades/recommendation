
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
                                selected = 1)
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
                                  '"')
           )),
          column(6,
             wellPanel(
             plotOutput('classic')
           ))
  ),
  fluidRow(
    
    column(6,
           wellPanel(
             plotOutput('contents')
           )),
    column(6,
           wellPanel(
             plotOutput("plot")
           )) 
  )
  
    ))
