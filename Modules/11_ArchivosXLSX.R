ArchivosXLSX_UI <- function(id, label = "Counter") {
  ns <- NS(id)
  fluidRow(
    column(
      width = 10, offset = 1, tags$hr(), tags$br(),
      h2(style = "margin-left: -50px;", tags$b('Combinador de archivos XLSX')), 
      tags$br(), uiOutput(ns('brwz')),
      tags$ol(
        tags$li('Comprima los archivos en un fichero ZIP y cárguelo a continuación:'),
        tags$div(
          style = "margin-left: 20px;", 
          fileInput(ns('ZIPfile'), label = NULL, multiple = FALSE, accept = '.zip', width = '40%',
                    buttonLabel = tags$b('Examinar...'), placeholder = 'Un solo archivo .zip'),
          uiOutput(ns('UploadSuccesful'))),
        tags$hr(),
        conditionalPanel(
          condition = 'input.CargarZIP > 0', ns = ns,
          tagList(
            tags$li('Compruebe que los datos del primer archivo se hayan cargado correctamente 
                    con sus respectivos encabezados de las columnas:'),
            tags$div(
              style = 'margin-left: 20px;', id = "inline", tags$br(),
              tags$div(
                style = paste0('background-color:', Paleta[8], ';'), 
                DT::dataTableOutput(ns('ExampleFile'))), 
              splitLayout(
                cellWidths = '30%',
                numericInput(ns('nskip'), label = ReqField('Filas a ignorar:'), value = 1, min = 0, max = 7),
                actionButton(ns('UpdtCnfg'), label = tags$b('Actualizar')))
            ),
            tags$hr(),
            tags$li('Si el archivo se ve bien presione el siguiente botón:'),
            tags$div(
              style = 'margin-left: 20px;',  
              actionButton(ns('CrearConcatenado'), label = tags$b('Crear archivo con todos los datos'), width = '40%'))
          )
        ),
        conditionalPanel(
          condition = 'input.CrearConcatenado > 0', ns = ns,
          tags$hr(), tags$li('Descargue su archivo:'),
          tags$div(
            style = 'margin-left: 20px;',
            downloadButton(ns('ExcelConcatenado'), label = tags$b('Descargar archivo Excel')))
        )
        # tags$hr(),
        # tags$li('Comprima los archivos en un fichero ZIP y cárguelo a continuación:')
      ),
      # "Esta aplicación web facilita el uso de los archivos generados en el instrumento ICP-MS NexION 300 de Perkin Elmer.",
      tags$br(), tags$br()
    )
  )
}

ArchivosXLSX_Server <- function(id, devMode) {
  moduleServer(
    id,
    function(input, output, session) {
      output$brwz <- renderUI(
        if(devMode()) return(actionButton(session$ns('brwz'), label = tags$b('Pausar módulo'))))
      observeEvent(input$brwz, browser())
      
      # Carga de archivo ZIP
      UploadSuccesful <- eventReactive(input$ZIPfile, {
        if (is.null(unzip(input$ZIPfile$datapath))) {
          return(tags$b('Error: Se debe subir un fichero ZIP con los archivos comprimidos'))
        } else {
          ZipDataFile <- unzip(input$ZIPfile$datapath)
          if (length(unique(lapply(ZipDataFile, getExtension))) > 1) {
            return(tags$b('Error: El fichero ZIP solo debe contener archivos de un solo tipo'))
          }
          return(actionButton(inputId = session$ns('CargarZIP'), width = '40%', style = 'margin-top: -10px;',
                              label = tags$b('Cargar fichero con archivos')))
        }
      })
      output$UploadSuccesful <- renderUI(UploadSuccesful())
      
      ExampleFile <- eventReactive(c(input$CargarZIP, input$UpdtCnfg), {
        ZipDataFile <- unzip(input$ZIPfile$datapath)
        return(data.frame(read_xls(ZipDataFile[1], skip = input$nskip)))
      })
      
      output$ExampleFile <- DT::renderDataTable({
        datatable(data = ExampleFile(), options = list(scrollX = TRUE, dom = 't')) %>% 
          formatRound(which(sapply(ExampleFile(), is.numeric)), digits = 4, mark = '')
      })
    }
  )
}

# # setwd("~/0-INM.V2/2022/0_AlejandraPerez")
# Elemento <- 'Cd'
# 
# (Carpetas <- paste0('Curva ', 1:5))
# (fileNames <- list.files(path = Elemento, recursive = TRUE))
# (fileNames <- fileNames[grepl('.*Curva', fileNames)])
# 
# (fileNames <- fileNames[-c(1, length(fileNames))])
# void <- vector(length = length(fileNames))
# 
# AveragedData <- data.frame(SampleID = void, Hg199 = void, Hg200 = void, Hg201 = void, Hg202 = void,
#                            In115 = void, Rh103 = void, Ge72 = void, Ge74 = void, U238 = void)
# 
# library(readxl)
# 
# 
# 
# for (i in 1:length(fileNames)) {
#   if (i == 1) {
#     MergedData <- cbind(fileNames[i], 
#                         data.frame(read_excel(path = paste0(Elemento, '/', fileNames[i]), skip = 1)))
#   } else {
#     MergedData <- rbind(MergedData,
#                         cbind(fileNames[i], 
#                               data.frame(read_excel(path = paste0(Elemento, '/', fileNames[i]), skip = 1))))
#   }
# }
# 
# library(writexl)
# write_xlsx(MergedData, paste0("datosElemento_", Elemento, ".xlsx"))
# rm(list = ls())
