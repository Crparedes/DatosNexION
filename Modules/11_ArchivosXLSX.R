ArchivosXLSX_UI <- function(id, label = "Counter") {
  ns <- NS(id)
  tagList(
    tags$hr(), tags$hr(), 
    actionButton(ns("button"), label = label),
    verbatimTextOutput(ns("out"))
  )
}

ArchivosXLSX_Server <- function(id, devMode) {
  moduleServer(
    id,
    function(input, output, session) {
      count <- reactiveVal(0)
      observeEvent(input$button, {
        count(count() + 1)
      })
      output$out <- renderText({
        count()
      })
      count
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
