library('shiny')
library('shinydashboard')
library('dashboardthemes')
library('shinyWidgets')
library('shinycssloaders')
library('shinyjs')
library('plotly')
library('rhandsontable')
library('readxl')
library('writexl')
library('DT')
library("dplyr")
# packages <- c('shiny', 'shinydashboard', 'dashboardthemes', 'shinyWidgets', 'shinycssloaders',
#               'shinyjs', 'rhandsontable', 'readxl', 'writexl', 'DT')
# for(p in packages){
#   if(!require(p, character.only = TRUE)) install.packages(p)
#   library(p, character.only = TRUE)
# }

modules <- with(list(pt = 'Modules/'), paste0(pt, list.files(path = pt)))
sapply(c(modules), source)