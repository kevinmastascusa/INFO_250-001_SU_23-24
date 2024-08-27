library(shiny)
library(ggplot2)
library(shiny)

# Define UI for application
ui <- fluidPage(
    titlePanel("Diamonds Dataset Visualization"),

    sidebarLayout(
        sidebarPanel(
            selectInput("xvar",
                        "X-axis Variable:",
                        choices = c("carat", "cut", "color", "clarity", "depth", "table", "price"),
                        selected = "carat"),
            selectInput("yvar",
                        "Y-axis Variable:",
                        choices = c("price", "carat", "depth", "table"),
                        selected = "price"),
            selectInput("plotType",
                        "Plot Type:",
                        choices = c("Scatter Plot", "Histogram", "Box Plot"),
                        selected = "Scatter Plot"),
            checkboxInput("logScale",
                          "Logarithmic Scale:",
                          value = FALSE)
        ),

        mainPanel(
            plotOutput("plot")
        )
    )
)
# Define server logic
server <- function(input, output) {

    output$plot <- renderPlot({
        # Determine if log scale is selected
        x <- input$xvar
        y <- input$yvar
        plotType <- input$plotType

        if (plotType == "Scatter Plot") {
            p <- ggplot(diamonds, aes_string(x = x, y = y)) +
                geom_point(size = 1, alpha = 0.5, color = "blue") +
                labs(title = "Scatter Plot", x = x, y = y) +
                theme_minimal()

        } else if (plotType == "Histogram") {
            p <- ggplot(diamonds, aes_string(x = x, fill = "cut")) +
                geom_histogram(position = "dodge", bins = 30) +
                labs(title = "Histogram", x = x, y = "Count") +
                theme_minimal()

        } else if (plotType == "Box Plot") {
            p <- ggplot(diamonds, aes_string(x = x, y = y, fill = "cut")) +
                geom_boxplot() +
                labs(title = "Box Plot", x = x, y = y) +
                theme_minimal()
        }

        # Apply logarithmic scale if selected
        if (input$logScale) {
            p <- p + scale_y_log10() + scale_x_log10()
        }

        print(p)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
