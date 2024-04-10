library(rsconnect)
library(tidyverse)
rsconnect::setAccountInfo(name='gwjne1-meghna-mehta', token='1EDC4123B423F0C2F43FA45E920BC66B', secret='uxh/a9WaDD6tXnK77ctoL2cZ/odpDiqiXBQLOaLZ')
rsconnect::deployApp(appDir='C:\\Users\\meghn\\OneDrive\\Desktop\\SOC360\\Project\\ES', 
                     appName = "endangeredspecies") 

library(shiny)
library(ggplot2)
library(plotly)
library(ggcorrplot)

ui <- fluidPage(
  
  titlePanel("Sociological Impact of Endangered Species"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("x_var", "X-axis Variable", choices = c("Red_List_Category", "Population_Trend", "Ecosystem", "Biogeographic_Realm", "Threat")),
      selectInput("y_var", "Y-axis Variable", choices = c("Year_Published")),
      
      radioButtons("plot_type", "Plot Type",
                   choices = c("Bar Chart", "Boxplot", "Violin Plot"),
                   selected = "Bar Chart")
      
    ),
    
    mainPanel(
      
      plotOutput("plot")
      
    )
  )
)

server <- function(input, output) {
  
  output$plot <- renderPlot({
    data <- read.csv("df.csv")
    x <- input$x_var
    y <- input$y_var
    
    if (input$plot_type == "Bar Chart") {
      ggplot(data, aes_string(x = x, fill = x)) +
        geom_bar() +
        labs(x = x, title = "Bar Chart") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    } else if (input$plot_type == "Boxplot") {
      ggplot(data, aes_string(x = x, y = y)) +
        geom_boxplot() +
        labs(x = x, y = y, title = "Boxplot") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    } else if (input$plot_type == "Violin Plot") {
      ggplot(data, aes_string(x = x, y = y)) +
        geom_violin() +
        labs(x = x, y = y, title = "Violin Plot") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
        
    }
  })
}

shinyApp(ui = ui, server = server)

