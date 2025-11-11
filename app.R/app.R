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

# --- Define Server ---
server <- function(input, output) {
  
  # 1️⃣ Create scatter plot
  output$scatterPlot <- renderPlot({
    ggplot(penguins, aes_string(x = input$xvar, y = input$yvar, color = "species")) +
      geom_point(size = 3, alpha = 0.8) +
      theme_minimal() +
      labs(x = input$xvar, y = input$yvar, color = "Species")
  })
  
  # 2️⃣ Create summary table
  output$summaryTable <- renderTable({
    penguins %>%
      select(all_of(c(input$xvar, input$yvar))) %>%
      summarise_all(list(
        Mean = ~mean(.x, na.rm = TRUE),
        SD = ~sd(.x, na.rm = TRUE),
        Min = ~min(.x, na.rm = TRUE),
        Max = ~max(.x, na.rm = TRUE)
      )) %>%
      pivot_longer(everything(), names_to = c("Variable", "Statistic"), names_sep = "_") %>%
      pivot_wider(names_from = Statistic, values_from = value)
  })
}

# --- Run the app ---
shinyApp(ui = ui, server = server)