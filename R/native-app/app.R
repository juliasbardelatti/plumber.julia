# Native app -----------------------------------------------------------------

# Shiny App for providing data input to cars plumber API
library(shiny)
library(httr)

cars_model <- readr::read_rds("cars-model.rds")

ui <- fluidPage(
  
  titlePanel("Milhas por galão (consumo de combustível)"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("hp",
                  "Potência",
                  min = min(mtcars$hp),
                  max = max(mtcars$hp),
                  value = median(mtcars$hp)),
      selectInput("cyl",
                  "Cilindradas",
                  choices = sort(unique(mtcars$cyl)),
                  selected = sort(unique(mtcars$cyl))[1]),
      fluidRow(
        actionButton("add",
                     "Adicionar"),
        actionButton("remove",
                     "Remover"),
        actionButton("predict",
                     "Predict")
      )
    ),
    
    mainPanel(
      tableOutput("data"),
      wellPanel(
        textOutput("raw_results")
      )
    )
  )
)

server <- function(input, output) {
  reactive_values <- reactiveValues(data = data.frame(),
                                    predicted_values = NULL)
  
  observeEvent(input$add, {
    reactive_values$predicted_values <- NULL
    
    data <- reactive_values$data
    reactive_values$data <- rbind(data[!names(data) %in% "predicted_mpg"],
                                  data.frame(hp = as.numeric(input$hp), cyl = as.numeric(input$cyl)))
  })
  
  observeEvent(input$remove, {
    reactive_values$predicted_values <- NULL
    
    data <- reactive_values$data
    
    reactive_values$data <- dplyr::anti_join(data[!names(data) %in% "predicted_mpg"],
                                             data.frame(hp = as.numeric(input$hp), cyl = as.numeric(input$cyl)))
  })
  
  observeEvent(input$predict, {
    reactive_values$predicted_values <- predict(cars_model, reactive_values$data)
    
    if (!"predicted_mpg" %in% names(reactive_values$data)) {
      reactive_values$data <- cbind(reactive_values$data, 
                                    predicted_mpg = reactive_values$predicted_values)
    }
  })
  
  output$data <- renderTable(reactive_values$data)
  output$raw_results <- renderText({
    if (is.null(reactive_values$predicted_values)) {
      "Sem predições"
    } else {
      print(reactive_values$predicted_values)
    }
  })
}

shinyApp(ui = ui, server = server)
