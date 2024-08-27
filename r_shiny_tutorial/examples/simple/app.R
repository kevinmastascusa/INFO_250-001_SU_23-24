library(shiny)
library(ggplot2)

ui <- fluidPage(
    titlePanel("Diamonds Visualization"),
    sidebarLayout(
        sidebarPanel(
            selectInput("variable", "Choose a variable:", choices = names(diamonds)),
            selectInput("plotType", "Choose plot type:", choices = c("Histogram", "Boxplot"))
        ),
        mainPanel(
            plotOutput("myPlot")
        )
    )
)

server <- function(input, output) {
    output$myPlot <- renderPlot({
        if (input$plotType == "Histogram") {
            ggplot(diamonds, aes_string(x = input$variable)) + geom_histogram()
        } else {
            ggplot(diamonds, aes_string(x = "cut", y = input$variable)) + geom_boxplot()
        }
    })
}

shinyApp(ui = ui, server = server)
