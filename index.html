library(shiny)
library(ggplot2)
theme_set(theme_minimal())

ui <- fluidPage(
  titlePanel("Simulador y predictor de conducta por ley de igualación"),
  sidebarLayout(
    sidebarPanel(
      numericInput("b", "Valor de b:", value = 0.5),
      numericInput("s", "Valor de s:", value = 1),
      actionButton("plotBtn", "Generar Gráfica")
    ),
    mainPanel(
      plotOutput("plot", width = "100%", height = "500px")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$plotBtn, {
    # Obtener los valores ingresados en los cuadros de texto
    b <- input$b
    s <- input$s
    
    # Valores fijos para Rf1, R2 y Rf2 en el rango de 0 a 10
    Rf1 <- seq(0, 10, length.out = 100)
    R2 <- seq(0, 10, length.out = 100)
    Rf2 <- seq(0, 10, length.out = 100)
    
    # Generar valores de R1
    R1 <- seq(0, 10, length.out = 100)
    
    # Calcular los valores de J para cada valor de R1 y las variables ingresadas
    J <- b * s * (R1 * Rf1^s) / (R2 + Rf2^(2 * s + 1))
    
    # Crear un data frame con los valores de R1 y J
    data <- data.frame(R1 = R1, J = J)
    
    # Crear la gráfica usando ggplot2 con estilo vanguardista
    output$plot <- renderPlot({
      ggplot(data, aes(x = R1, y = J)) +
        geom_line() +
        labs(x = "R1", y = "J") +
        ggtitle("Gráfica de J en función de R1 (s = 1)") +
        theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 15)),
              panel.background = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              axis.line = element_line(color = "black"),
              axis.text = element_text(size = 12),
              axis.title = element_text(size = 14, face = "bold"))
    })
  })
}

shinyApp(ui, server)
