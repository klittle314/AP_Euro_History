
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#


library(shiny)
shinyServer(function(input, output) {
  output$MotionPlot <- renderGvis({
    width1 <- input$width
    height1 <- input$height
    gvisMotionChart(df_this_is_not_a_drill, idvar="Country", timevar="Year", 
                    options=list(width=width1, height=height1))
  })
})