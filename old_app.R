library(shiny)

# Define la interfaz de usuario
ui <- fluidPage(
  # Agrega un campo de texto para ingresar el nombre
  textInput("nombre", "Nombre:"),
  # Agrega un campo de texto para ingresar la edad
  numericInput("ahorro", "Ahorro:", value = NULL),
  # Agrega un campo de texto para ingresar el mes
  textInput("mes", "Mes:"),
  # Agrega un botón para guardar los datos en un archivo CSV
  actionButton("guardar", "Guardar datos"),
  # Agrega un mensaje para confirmar que se han guardado los datos
  verbatimTextOutput("mensaje")
)

# Define el servidor
server <- function(input, output) {
  # Crea una función para guardar los datos
  guardar_datos <- function(nombre, ahorro, mes) {
    # Crea un data frame con los datos
    datos <- data.frame(Nombre = nombre, Ahorro = ahorro, Mes = mes)
    # Guarda los datos en un archivo CSV
    write.csv(datos, "datos.csv", row.names = FALSE, append = TRUE)
  }
  
  # Agrega un observador para el botón de guardar
  observeEvent(input$guardar, {
    # Llama a la función para guardar los datos
    guardar_datos(input$nombre, input$ahorro, input$mes)
    # Muestra un mensaje de confirmación
    output$mensaje <- renderPrint("Los datos se han guardado correctamente.")
  })
}

# Crea la aplicación
shinyApp(ui, server)
