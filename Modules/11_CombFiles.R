CombFiles_UI <- function(id, label = "Counter", FlTy = 'Excel') {
  ns <- NS(id)
  fluidRow(
    column(
      width = 10, offset = 1, tags$hr(), tags$br(),
      h2(style = "margin-left: -50px;", tags$b('Combinador de archivos', FlTy)), 
      tags$br(), uiOutput(ns('brwz')),
      tags$ol(
        tags$li(
          'Comprima los archivos en un fichero ZIP', 
          tags$sup(tags$a(
            tags$small(icon('question')), target = '_blank',
            href = 'https://support.microsoft.com/es-es/windows/comprimir-y-descomprimir-archivos-8d28fa72-f2f9-712f-67df-f80cf89fd4e5')),
          spcs(1), ' y cárguelo a continuación:'),
        tags$div(
          style = "margin-left: 20px;", 
          fileInput(ns('ZIPfile'), label = NULL, multiple = FALSE, accept = '.zip', width = '40%',
                    buttonLabel = tags$b('Examinar...'), placeholder = 'Un solo archivo .zip'),
          uiOutput(ns('UploadSuccesful'))),
        tags$hr(),
        conditionalPanel(
          condition = 'input.CargarZIP > 0', ns = ns,
          tagList(
            tags$li('Compruebe en la siguiente tabla que los datos del primer archivo se cargaron bien 
                    y que los encabezados de las columnas aparecen en negrilla en la primera fila:',
                    tags$br(),
                    '(Modifique el número de filas a ignorar hasta que la tabla se vea correctamente.)'),
            tags$div(
              style = 'margin-left: 20px;', id = "inline", tags$br(),
              tags$div(
                style = paste0('background-color:', Paleta[8], ';'), 
                DT::dataTableOutput(ns('ExampleFile'))), 
              splitLayout(
                cellWidths = '20%',
                numericInput(ns('nskip'), label = ReqField('Filas a ignorar:'), value = 1, min = 0, max = 7),
                actionButton(ns('UpdtCnfg'), label = tags$b('Actualizar')))
            ),
            tags$hr(),
            tags$li('Cuando la tabla del primer archivo se vea bien presione el botón que sigue.',
                    'Recuerde que todos los archivos de la carpeta comprimida deben tener las mismas columnas.'),
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
      tags$br(), tags$br()
    )
  )
}

CombFiles_Server <- function(id, devMode, FlTy = 'Excel') {
  moduleServer(
    id,
    function(input, output, session) {
      output$brwz <- renderUI(
        if(devMode()) return(actionButton(session$ns('brwz'), label = tags$b('Pausar módulo'))))
      observeEvent(input$brwz, browser())
      
      # Carga de archivo ZIP
      UploadSuccesful <- eventReactive(input$ZIPfile, {
        if (is.null(unzip(input$ZIPfile$datapath, exdir = getwd()))) {
          return(tags$b('Error: Se debe subir un fichero ZIP con los archivos comprimidos.'))
        } else {
          ZipDataFile <- unzip(input$ZIPfile$datapath, exdir = getwd())
          UplFileExt <- unique(lapply(ZipDataFile, getExtension))
          if (length(UplFileExt) > 1) {
            return(tags$b('Error: El fichero ZIP debe contener archivos de un solo tipo.'))}
          if (FlTy == 'Excel' && UplFileExt != 'xls' && UplFileExt != 'xlsx') {
            return(tags$b('Error: El fichero ZIP debe contener archivos de excel (extensiones .xls y .xlsx).'))}
          if (FlTy == 'DAC' && UplFileExt != 'dac') {
            return(tags$b('Error: El fichero ZIP debe contener archivos DAC (extension .dac).'))}
          
          niceOUT <- tagList(
            'Número de archivos en el fichero:', tags$b(length(ZipDataFile)), tags$br(),
            actionButton(inputId = session$ns('CargarZIP'), width = '40%', 
                         label = tags$b('Cargar fichero ZIP'))
          )
          return(niceOUT)
        }
      })
      output$UploadSuccesful <- renderUI(UploadSuccesful())
      
      # Tabla de ejemplo del primer archivo
      ZipDataFile <- eventReactive(c(input$CargarZIP, input$UpdtCnfg), {
        return(unzip(input$ZIPfile$datapath, exdir = getwd()))
      })  
      ExampleFile <- eventReactive(c(input$CargarZIP, input$UpdtCnfg), {
        df <- data.frame(read_excel(ZipDataFile()[1], skip = input$nskip))
        return(df[rowSums(is.na(df)) != ncol(df), ])
      })
      
      output$ExampleFile <- DT::renderDataTable({
        datatable(data = ExampleFile(), options = list(scrollX = TRUE, dom = 't')) %>% 
          formatRound(which(sapply(ExampleFile(), is.numeric)), digits = 4, mark = '')
      })
      
      # unión de archivos
      Concatenado <- eventReactive(input$CrearConcatenado, {
        if (FlTy == 'Excel') {
          df <- data.frame(read_excel(ZipDataFile()[1], skip = input$nskip))
          MergedData <- cbind(Archivo = ZipDataFile()[1],
                              df[rowSums(is.na(df)) != ncol(df), ])
          for (i in 2:length(ZipDataFile())) {
            df <- data.frame(read_excel(ZipDataFile()[i], skip = input$nskip))
            MergedData <- dplyr::bind_rows(MergedData,
                                           cbind(Archivo = ZipDataFile()[i], df[rowSums(is.na(df)) != ncol(df), ]))
          }
        }
        if (FlTy == 'DAC') {
          
        }
        
        return(MergedData)
      })
      
      # Descarga de excel con información
      output$ExcelConcatenado <- downloadHandler(
        filename = function() {
          paste0(
            format(Sys.time(), format = "%F_%R"), '_', 
            sub("\\..*", "", input$ZIPfile$name), '_Concatenado', '.xlsx')}, 
        content = function(file) {
          write_xlsx(x = Concatenado(), path = file, format_headers = TRUE)}, 
        contentType = NULL)
      
    
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
# , paste0("datosElemento_", Elemento, ".xlsx"))
# rm(list = ls())
