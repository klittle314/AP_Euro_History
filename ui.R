
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(BH)
shinyUI(fluidPage(
 
titlePanel("AP European History Project, Gracie Little 8 June 2015"),
  
# Sidebar with a slider input for number of bins
sidebarLayout(
  sidebarPanel("Adjust the width and height to fit your browser", 
               # Simple integer interval for width and height of graph
               sliderInput("width", "width:", 
                           min=400, max=900, value=500),
               sliderInput('height', "height;",
                           min=500, max=900,value=600)),
  # Show a plot of the motion plot
  mainPanel(
    htmlOutput("MotionPlot")
    )
  )
))