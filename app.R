library(shiny)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  titlePanel("Gráfico de Distribuciones Normales"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("d_input", label = "Valor de d:", value = 0.8, min = 0),
      actionButton("calcular_button", "Calcular")
    ),
    
    mainPanel(
      plotlyOutput("grafico")  # Utilizar plotlyOutput en lugar de plotOutput
    )
  )
)

server <- function(input, output) {
  output$grafico <- renderPlotly({  # Utilizar renderPlotly en lugar de renderPlot
    d <- input$d_input
    
    media1 <- 0
    desviacion1 <- 1
    media2 <- d * desviacion1 + media1
    desviacion2 <- desviacion1
    
    x <- seq(-10, 10, length.out = 1000)
    y1 <- dnorm(x, media1, desviacion1)
    y2 <- dnorm(x, media2, desviacion2)
    
    df <- data.frame(x = x, y1 = y1, y2 = y2)
    
    grafico <- ggplot(df, aes(x = x)) +
      geom_ribbon(aes(ymin = pmin(y1, y2), ymax = pmax(y1, y2)), fill = "red", color = NA, alpha = 0.6) +
      geom_line(aes(y = y1), color = "#64B5F6", size = 1.5) +
      geom_ribbon(aes(ymin = pmin(y1, y2), ymax = pmax(y1, y2)), fill = "#1976D2", color = NA, alpha = 0.6) +
      geom_line(aes(y = y2), color = "#1976D2", size = 1.5) +
      labs(x = "Valores", y = "Densidad") +
      theme_minimal() +
      theme(panel.grid = element_blank(),
            plot.background = element_rect(fill = "black"),
            axis.line = element_line(color = "white"),
            axis.text = element_text(size = 12, color = "white"),
            axis.title = element_text(size = 14, face = "bold", color = "white"),
            legend.position = "none",
            plot.margin = margin(20, 20, 20, 20))
    
    # Convertir el gráfico a ggplotly para una visualización interactiva
    grafico_interactivo <- ggplotly(grafico, tooltip = "x") %>%
      layout(plot_bgcolor = "black")
    
    # Imprimir el gráfico interactivo
    grafico_interactivo
  })
}

shinyApp(ui = ui, server = server)
