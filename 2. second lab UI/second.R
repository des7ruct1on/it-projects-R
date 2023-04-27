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
      
      actionButton(
        inputId = "myfirst_button", 
        label = "Update plot observe event"
      )
      
    ),
    mainPanel(
      
      h3("User Output"),
      
      highchartOutput("myfirst_highchart")
      
    )
  )
  
)

server <-function(input, output) {
  
  reactive_vals <- reactiveValues(
    
    slider = 50,
    mean = 70,   
    sd = 50,
    
    reactive_df = data.frame(
      x = rnorm(
        50,
        50,
        50
      ),
      y = rnorm(50,5,30)
    )
    
  )
  
  
  observeEvent(input$myfirst_button,{
    
    reactive_vals$slider <- input$myfirst_slider
    
    reactive_vals$mean <- input$myfirst_mean
    
    reactive_vals$sd <- input$myfirst_sd
    
    reactive_vals$reactive_df <-  data.frame(
      x = rnorm(
        reactive_vals$slider,
        reactive_vals$mean,
        reactive_vals$sd
      ),
      y = rnorm(reactive_vals$slider,5,30)
    )
    
  })
  
  
  output$myfirst_highchart <- renderHighchart({
    
    df <-  data.frame(
      x = rnorm(
        reactive_vals$slider,
        reactive_vals$mean,
        reactive_vals$sd
      ),
      y = rnorm(reactive_vals$slider,5,30)
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