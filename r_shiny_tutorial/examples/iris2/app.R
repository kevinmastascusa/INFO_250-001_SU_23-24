library(shiny)
library(ggplot2)

# Define UI for application
ui <- fluidPage(
    titlePanel("Iris Dataset Visualization"),

    sidebarLayout(
        sidebarPanel(
            selectInput("xvar",
                        "X-axis Variable:",
                        choices = names(iris)[1:4],
                        selected = "Sepal.Length"),
            selectInput("yvar",
                        "Y-axis Variable:",
                        choices = names(iris)[1:4],
                        selected = "Sepal.Width"),
            selectInput("plotType",
                        "Plot Type:",
                        choices = c("Scatter Plot", "Histogram", "Box Plot"),
                        selected = "Scatter Plot"),
            selectInput("speciesFilter",
                        "Species Filter:",
                        choices = c("All", levels(iris$Species)),
                        selected = "All")
        ),

        mainPanel(
            plotOutput("plot"),
            # Adding the author and course information
            tags$hr(),
            tags$footer(
                "By Kevin Mastascusa",
                tags$br(),
                "COURSE MATERIALS FOR INFO_250-001_SU_23-24 DO NOT DISTRIBUTE",
                align = "center",
                style = "font-size: 12px; color: #888888; margin-top: 20px;"
            )
        )
    )
)

# Define server logic
server <- function(input, output) {

    output$plot <- renderPlot({
        # Filter the dataset based on species selection
        filtered_data <- iris
        if (input$speciesFilter != "All") {
            filtered_data <- iris[iris$Species == input$speciesFilter, ]
        }

        # Generate the appropriate plot based on user input
        if (input$plotType == "Scatter Plot") {
            ggplot(filtered_data, aes_string(x = input$xvar, y = input$yvar, color = "Species")) +
                geom_point(size = 3) +
                labs(title = "Scatter Plot", x = input$xvar, y = input$yvar) +
                theme_minimal()

        } else if (input$plotType == "Histogram") {
            ggplot(filtered_data, aes_string(x = input$xvar, fill = "Species")) +
                geom_histogram(position = "dodge", bins = 30) +
                labs(title = "Histogram", x = input$xvar, y = "Count") +
                theme_minimal()

        } else if (input$plotType == "Box Plot") {
            ggplot(filtered_data, aes_string(x = "Species", y = input$xvar, fill = "Species")) +
                geom_boxplot() +
                labs(title = "Box Plot", x = "Species", y = input$xvar) +
                theme_minimal()
        }
    })
}

# Run the application
shinyApp(ui = ui, server = server)
