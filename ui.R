
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)       
      
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"), 
      sidebarPanel(dateRangeInput("daterange", "Date range:",
                                  start = Sys.Date()-10,
                                  end = Sys.Date(),
                                  min = Sys.Date()-20,
                                  max = Sys.Date(),
                                  startview = "month",
                                  language = "es",
                                  separator = " a ",
                                  format = "D M yyyy"))
    )
  )
))
