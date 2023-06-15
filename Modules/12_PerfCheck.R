PerfCheck_UI <- function(id, label = "Counter", FlTy = 'Excel') {
  ns <- NS(id)
  fluidRow(
    column(
      width = 10, offset = 1, tags$hr(), tags$br(),
      h2(style = "margin-left: -50px;", tags$b('Reporte de ', tags$em("Performance Check."))), 
      tags$br(), uiOutput(ns('brwz')),
      tags$ol(
        tags$li('Suba su archivo de Excel con el reporte de los resultados de Performance Check y 
                verifique las fechas de los registros y pulse el botón a continuación:'),
        tags$div(
          style = "margin-left: 20px;", 
          fileInput(ns('PerfCheckfile'), label = NULL, multiple = FALSE, accept = '.xlsx', width = '40%',
                    buttonLabel = tags$b('Examinar...'), placeholder = 'Archivo .xlsx'),
          uiOutput(ns('UploadSuccesful'))),
        tags$hr(),
        conditionalPanel(
          condition = 'input.CargarFile > 0', ns = ns,
          selectInput(ns('ChoiceParam'), label = tags$li('Escoja el parámetro para graficar en la carta de control'),
                      choices = c('Be.9', 'In.115', 'U.238', 'Rel. óxidos',
                                  'Rel. especies doblemente cargadas', 'Ruido de fondo'), multiple = FALSE, selected = 'U.238'),
          tagList(
            tags$div(
              style = 'margin-left: 20px;', id = "inline", tags$br(),
              plotlyOutput(ns("ContrlChrt1")),
              tags$hr(),
              tags$div(
                style = paste0('background-color:', Paleta[8], '; font-size:0.7em;'), 
                DT::dataTableOutput(ns('PerfCheckTable'))),
            ),
            tags$hr(),
            tags$div(
              style = 'margin-left: 20px;',  
              # actionButton(ns('CrearConcatenado'), label = tags$b('Crear archivo con todos los datos'), width = '40%')
              )
          )
        )
      ),
      tags$br(), tags$br()
    )
  )
}

PerfCheck_Server <- function(id, devMode, FlTy = 'Excel') {
  moduleServer(
    id,
    function(input, output, session) {
      output$brwz <- renderUI(
        if(devMode()) return(actionButton(session$ns('brwz'), label = tags$b('Pausar módulo'))))
      observeEvent(input$brwz, browser())
      
      # Carga de archivo ZIP
      UploadSuccesful <- eventReactive(input$PerfCheckfile, {
        if ((class(try(read_excel(path = input$PerfCheckfile$datapath))) == "try-error")[1]) {
          return(tags$b('Error: No se subió un archivo de excel válido.'))
        } else {
          PerfCheckData <- data.frame(read_excel(path = input$PerfCheckfile$datapath, skip = 1))
          
          PerfCheckData$Acquisition.Time <- as.POSIXlt(PerfCheckData$Acquisition.Time, "%m/%d/%Y %I:%M:%S %p", tz = '')
          
          niceOUT <- tagList(
            HTML(paste0("<table style = 'font-size:0.85em; margin-left: 30px;'>
                <tr><td align='right'>Número de registros en el archivo:</td>
                    <td>&nbsp;&nbsp;<b>", nrow(PerfCheckData), "<b></td></tr>
                <tr><td align='right'>Fecha primer registro:</td>
                    <td>&nbsp;&nbsp;<b>", as.character(min(PerfCheckData$Acquisition.Time)), "<b></td></tr>
                <tr><td align='right'>Fecha último registro:</td>
                    <td>&nbsp;&nbsp;<b>", as.character(max(PerfCheckData$Acquisition.Time)), "<b></td></tr>
                </table><br>")),
            actionButton(inputId = session$ns('CargarFile'), width = '40%', label = tags$b('Cargar archivo de Excel'))
          )
          return(niceOUT)
        }
      })
      output$UploadSuccesful <- renderUI(UploadSuccesful())
      
      # Tabla de parámetros
      PerfCheckData <- eventReactive(c(input$CargarFile), {
        PerfCheckData <- data.frame(read_excel(path = input$PerfCheckfile$datapath, skip = 1))
        PerfCheckData$Acquisition.Time <- as.POSIXlt(PerfCheckData$Acquisition.Time, "%m/%d/%Y %I:%M:%S %p", tz = '')
        PerfCheckData$Fecha <- as.character(PerfCheckData$Acquisition.Time)
        colnames(PerfCheckData)[which(colnames(PerfCheckData) == 'CeO.156...Ce.140....')] <- 'Rel. óxidos'
        colnames(PerfCheckData)[which(colnames(PerfCheckData) == 'Ce...70...Ce.140....')] <- 'Rel. especies doblemente cargadas'
        colnames(PerfCheckData)[which(colnames(PerfCheckData) == 'Bkgd.220')] <- 'Ruido de fondo'
        return(PerfCheckData)})
      
      SubTable <- reactive(
        PerfCheckData()[nrow(PerfCheckData()):1, c('Acquisition.Time', 'Fecha', 'Be.9', 'In.115', 'U.238', 
                                                   'Rel. óxidos', 'Rel. especies doblemente cargadas', 'Ruido de fondo')])
      
      output$PerfCheckTable <- DT::renderDataTable({
        datatable(data = SubTable()[, -1], 
                  options = list(
                    scrollX = TRUE,
                    initComplete = JS(
                      "function(settings, json) {",
                      "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                      "}"))) %>% 
          formatRound(which(sapply(SubTable()[, -1], is.numeric)), digits = 3, mark = '')
      })
      
      output$ContrlChrt1 <- renderPlotly({
        plot_ly(SubTable(), x = ~Fecha, y = ~get(input$ChoiceParam), type = 'scatter', mode = 'markers')
      })

      
    
    }
  )
}