# Load necessary libraries
library(shiny)
library(ggplot2)

# Define UI
# Shiny Basics: Shiny apps have two components: a user interface (UI) script and a server script. 
#  The UI script controls the layout and appearance of the app, while the server script contains the instructions for how the app should behave.
# The UI script is defined using the fluidPage() function, which creates a fluid layout for the app. The fluid layout adjusts to the size of the user's browser window.
# The titlePanel() function creates a title for the app, which is displayed at the top of the app.
# The sidebarLayout() function creates a sidebar layout with a sidebar panel and a main panel. The sidebar panel typically contains input controls, while the main panel displays the output.
# The sidebarPanel() function creates a sidebar panel with input controls. In this case, we use selectInput() to create dropdown menus for selecting variables.
# The mainPanel() function creates the main panel for displaying the plot. In this case, we use plotOutput() to create a placeholder for the plot.
# The selectInput() function creates a dropdown menu for selecting a variable. The choices argument specifies the options in the dropdown menu, while the selected argument specifies the default selection.
# The renderPlot() function generates the plot based on the user's input. The ggplot() function creates a scatter plot using the selected variables, and the geom_point() function adds points to the plot. The labs() function sets the plot title and axis labels, while the theme_minimal() function applies a minimal theme to the plot.

# Server Logic
# The server script contains the instructions for how the app should behave. It defines the reactive behavior of the app, which means that the app will update in response to user input.


ui <- fluidPage( # fluidPage() creates a fluid layout for the app
  titlePanel("Iris Dataset Interactive Visualization"), # titlePanel() creates a title for the app  
  #subtitle
  h3("This app allows you to create an interactive scatter plot of the Iris dataset."), # h3() creates a subtitle
  h2("Select the variables to plot:"), # h2() creates a heading
  h1("Iris Dataset Scatter Plot"), # h1() creates a heading (largest size)
  
  #author
  h4("By: Kevin Mastascusa"), # h4() creates a heading
  
  sidebarLayout( # sidebarLayout() creates a sidebar layout with a sidebar panel and a main panel
    sidebarPanel( # sidebarPanel() creates a sidebar panel
      selectInput("xvar", "Select X-axis variable:", # selectInput() creates a dropdown menu for selecting a variable
                  choices = names(iris)[1:4], selected = "Sepal.Length"), # choices = names(iris)[1:4] specifies the dropdown menu options
      selectInput("yvar", "Select Y-axis variable:", # selectInput() creates a dropdown menu for selecting a variable
                  choices = names(iris)[1:4], selected = "Sepal.Width"), # choices = names(iris)[1:4] specifies the dropdown menu options
      selectInput("colorvar", "Select Color by variable:", # selectInput() creates a dropdown menu for selecting a variable
                  choices = c("None", names(iris)[5]), selected = "Species") # choices = c("None", names(iris)[5]) specifies the dropdown menu options
    ), # sidebarPanel() ends
    
    mainPanel( # mainPanel() creates the main panel for displaying the plot
      plotOutput("scatterPlot") # plotOutput() creates a placeholder for the plot
    ) # mainPanel() ends
  ) # sidebarLayout() ends
) # fluidPage() ends

# Define server logic
server <- function(input, output) {
  
  output$scatterPlot <- renderPlot({
    # Generate the plot
    ggplot(iris, aes_string(x = input$xvar, y = input$yvar, color = ifelse(input$colorvar == "None", NULL, input$colorvar))) +
      geom_point(size = 3) +
      labs(title = paste("Scatter Plot of", input$xvar, "vs", input$yvar),
           x = input$xvar,
           y = input$yvar) +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
