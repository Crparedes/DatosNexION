Introduccion <- fluidRow(
  column(
    width = 6, offset = 1, tags$hr(), tags$br(), tags$br(),
    h2(style = "margin-left: -50px;", tags$b('Aplicativo ', tags$i('DatosNexION'))), 
    tags$br(),
    "Esta aplicación web facilita el uso de los archivos generados en el instrumento ICP-MS NexION 300 de Perkin Elmer.",
    tags$br(), tags$br(),
    'El aplicativo', tags$b('DatosNexION'), "tiene las siguientes funciones:", tags$br(),
    tags$ul(
      tags$li("Combinar múltiples archivos DAC de intensidades netas, en un solo archivo de Excel."),
      tags$li("Combinar múltiples archivos Excel de intensidades netas, en un solo archivo de Excel.")
    ), 
    tags$br(), tags$br()
  ),
  column(
    width = 5, tags$br(), tags$br(), tags$br(), tags$br(), tags$br(), tags$br(),
    div(img(src = "datosNexION.png", width = '90%')))#, style = "text-align: center;"))
)
