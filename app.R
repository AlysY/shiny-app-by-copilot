library(shiny)
library(ggplot2)
library(dplyr)

# Generate synthetic data
set.seed(123)  # For reproducibility
n_rows <- 50

data <- data.frame(
  ID = sample(c("A", "B", "C", "D"), n_rows, replace = TRUE),
  PresAbs = sample(c(0, 1), n_rows, replace = TRUE),
  slope = runif(n_rows, min = 0, max = 100),
  tree_count = sample(0:20, n_rows, replace = TRUE),
  elevation = runif(n_rows, min = 100, max = 1000)  # Fifth column
)

# UI
ui <- navbarPage(
  title = "Data Explorer",
  
  # About Page
  tabPanel(
    "About",
    fluidPage(
      h2("About This App"),
      br(),
      p("This Shiny application allows you to explore a dataset with 50 rows and 5 columns."),
      br(),
      h3("Dataset Description"),
      p("The dataset contains the following variables:"),
      tags$ul(
        tags$li(strong("ID:"), "Categorical variable with 4 levels (A, B, C, D)"),
        tags$li(strong("PresAbs:"), "Binary variable indicating presence (1) or absence (0)"),
        tags$li(strong("slope:"), "Continuous variable ranging from 0 to 100"),
        tags$li(strong("tree_count:"), "Integer variable representing the count of trees (0 or greater)"),
        tags$li(strong("elevation:"), "Continuous variable representing elevation (100 to 1000)")
      ),
      br(),
      h3("How to Use"),
      p("Navigate to the 'Data Exploration' and 'Additional Plots' tabs to view various visualizations of the data."),
      br(),
      h3("Dataset Summary"),
      verbatimTextOutput("data_summary")
    )
  ),
  
  # Data Exploration Page
  tabPanel(
    "Data Exploration",
    fluidPage(
      h2("Data Exploration Plots"),
      br(),
      
      fluidRow(
        column(
          width = 6,
          h4("Plot 1: Distribution of ID Categories"),
          plotOutput("plot1")
        ),
        column(
          width = 6,
          h4("Plot 2: Presence/Absence by ID"),
          plotOutput("plot2")
        )
      )
    )
  ),
  
  # Additional Plots Page
  tabPanel(
    "Additional Plots",
    fluidPage(
      h2("Additional Data Visualizations"),
      br(),
      
      fluidRow(
        column(
          width = 6,
          h4("Plot 3: Slope Distribution"),
          plotOutput("plot3")
        ),
        column(
          width = 6,
          h4("Plot 4: Tree Count vs Slope"),
          plotOutput("plot4")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # About page - data summary
  output$data_summary <- renderPrint({
    summary(data)
  })
  
  # Plot 1: Bar chart of ID categories
  output$plot1 <- renderPlot({
    ggplot(data, aes(x = ID, fill = ID)) +
      geom_bar() +
      theme_minimal() +
      labs(title = "Count of Each ID Category",
           x = "ID Category",
           y = "Count") +
      scale_fill_brewer(palette = "Set2")
  })
  
  # Plot 2: Stacked bar chart of PresAbs by ID
  output$plot2 <- renderPlot({
    ggplot(data, aes(x = ID, fill = factor(PresAbs))) +
      geom_bar(position = "stack") +
      theme_minimal() +
      labs(title = "Presence/Absence by ID",
           x = "ID Category",
           y = "Count",
           fill = "Presence/Absence") +
      scale_fill_manual(values = c("0" = "#E74C3C", "1" = "#27AE60"),
                        labels = c("0" = "Absent", "1" = "Present"))
  })
  
  # Plot 3: Histogram of slope
  output$plot3 <- renderPlot({
    ggplot(data, aes(x = slope)) +
      geom_histogram(bins = 15, fill = "#3498DB", color = "black", alpha = 0.7) +
      theme_minimal() +
      labs(title = "Distribution of Slope Values",
           x = "Slope",
           y = "Frequency")
  })
  
  # Plot 4: Scatter plot of tree_count vs slope
  output$plot4 <- renderPlot({
    ggplot(data, aes(x = slope, y = tree_count, color = ID)) +
      geom_point(size = 3, alpha = 0.7) +
      theme_minimal() +
      labs(title = "Tree Count vs Slope",
           x = "Slope",
           y = "Tree Count",
           color = "ID Category") +
      scale_color_brewer(palette = "Set1")
  })
}

# Run the app
shinyApp(ui = ui, server = server)
