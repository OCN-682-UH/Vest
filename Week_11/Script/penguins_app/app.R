# Load libraries
library(shiny)
library(ggplot2)
library(palmerpenguins)
library(dplyr)

# Load data
data("penguins")

# Define UI
ui <- fluidPage(
  titlePanel("Palmer Penguins Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "Select X-axis variable:",
                  choices = names(penguins)[sapply(penguins, is.numeric)],
                  selected = "bill_length_mm"),
      
      selectInput("yvar", "Select Y-axis variable:",
                  choices = names(penguins)[sapply(penguins, is.numeric)],
                  selected = "bill_depth_mm"),
      
      selectInput("colorvar", "Color by:",
                  choices = c("species", "sex", "island"),
                  selected = "species")
    ),
    
    mainPanel(
      plotOutput("penguinPlot"),
      h4("Summary Statistics Table"),  #add a title for the table
      tableOutput("summaryTable")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Dynamic scatter plot
  output$penguinPlot <- renderPlot({
    ggplot(penguins, aes_string(x = input$xvar, y = input$yvar, color = input$colorvar)) +
      geom_point(size = 3, alpha = 0.8, na.rm = TRUE) +
      theme_minimal() +
      labs(x = input$xvar, y = input$yvar, color = input$colorvar)
  })
  
  # Clean, correct summary table
  output$summaryTable <- renderTable({
    penguins %>%
      group_by(.data[[input$colorvar]]) %>%
      summarise(
        Mean_X = mean(.data[[input$xvar]], na.rm = TRUE),
        SD_X = sd(.data[[input$xvar]], na.rm = TRUE),
        Mean_Y = mean(.data[[input$yvar]], na.rm = TRUE),
        SD_Y = sd(.data[[input$yvar]], na.rm = TRUE)
      )
  })
}

# Launch app
shinyApp(ui = ui, server = server)