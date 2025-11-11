##In Class Example

library(shiny)
library(tidyverse) 
library(rsconnect)

ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ), 
  textInput(inputId = "title", # new Id is title
            label = "Write a title", #
            value = "Histogram of Random Normal Values"), # starting title
  plotOutput("hist"), #creates space for a plot called hist  
  verbatimTextOutput("stats") # create a space for stats
)

server<-function(input,output){
  output$hist <- renderPlot({
    # {} allows us to put all our R code in one nice chunck
    data<-tibble(x = rnorm(input$num)) # 100 random normal points 
    ggplot(data, aes(x = x))+ # make a histogram 
      geom_histogram() +
      labs(title = input$title) #Add a new title
  })
  output$stats <- renderPrint({
    summary(rnorm(input$num)) # calculate summary stats based on the numbers
  })
}
shinyApp(ui = ui, server = server)

-
  # app.R
  library(shiny)
library(tidyverse)
library(here)

# --- Load data ---
penguins <- read.csv(here("Week_11", "Data", "penguins.csv"))

# --- Define UI ---
ui <- fluidPage(
  
  titlePanel("Palmer Penguins Interactive Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "Choose X-axis variable:", choices = names(penguins), selected = "bill_length_mm"),
      selectInput("yvar", "Choose Y-axis variable:", choices = names(penguins), selected = "flipper_length_mm")
    ),
    
    mainPanel(
      plotOutput("scatterPlot"),
      tableOutput("summaryTable")
    )
  )
)
