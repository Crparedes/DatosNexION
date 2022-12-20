Introduccion <- fluidRow(
  column(
    width = 10, offset = 1, tags$hr(), tags$br(), tags$br(),
    h2(style = "margin-left: -50px;", tags$b('Aplicativo ', tags$i('DatosNexION'))), 
    tags$br(),
    "Esta aplicación web facilita el uso de los archivos generados en el instrumento ICP-MS NexION 300 de Perkin Elmer.",
    tags$br(), tags$br(),
    "Se encuentran implementadas las siguientes utilidades:", tags$br(),
    tags$ul(
      tags$li("Combinar múltiples archivos de intensidades netas en un solo archivo.")
    ), 
    tags$br(), tags$br()
  )
)
