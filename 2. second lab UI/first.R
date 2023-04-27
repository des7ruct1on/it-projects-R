library(shiny)
library(highcharter)


ui <- fluidPage(
  
  titlePanel("Hello World!"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      h3("User Input"),
      
      sliderInput(
        inputId = "myfirst_slider",
        label = "Number of points",
        min = 10,
        max = 100,
        value = 50
      ),
      
      numericInput(
        inputId = "myfirst_mean",
        label = "Mean",
        min = -5,
        max = 10,
        value = 70
      ),
      
      numericInput(
        inputId = "myfirst_sd",
        label = "STD",
        min = 1,
        max = 100,
        value = 50
      ),
      
      
    ),
    mainPanel(
      
      h3("User Output"),
      
      highchartOutput("myfirst_highchart")
      
    )
  )
  
)
server <- function(input, output) {
  
  output$myfirst_highchart <- renderHighchart({
    
    df <-  data.frame(
      x = rnorm(
        input$myfirst_slider,
        input$myfirst_mean,
        input$myfirst_sd
      ),
      y = rnorm(input$myfirst_slider,5,30)
    )
    
    hchart(
      df,
      "point",
      hcaes(
        x = x,
        y = y
      )
    )
       
  })
  
}


shinyApp(ui = ui, server = server)