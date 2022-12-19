Introduccion <- fluidRow(
  column(12, tags$hr(), tags$hr(),
    box(
      title = div(style = 'font-size:25px', tags$b('Introducción')), width = 12, status = 'primary', collapsible = TRUE, collapsed = FALSE,
      "Esta aplicación facilita el uso de los archivos generados en el instrumento ICP-MS NexION 300.
      Al momento se cuenta con las siguientes utilidades::", tags$br(),
      tags$ul(
        tags$li("Combinar archivos de intensidades netas.")
      ), 
      tags$br(), tags$br()
    )
  )
)
