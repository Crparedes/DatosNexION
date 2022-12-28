customSidebar <- dashboardSidebar(
  tags$style(".left-side, .main-sidebar {padding-top: 110px;}"), # font-size: larger
  width = 300, withMathJax(),
  sidebarMenu(
    id = "tabs", # tags$br(), tags$br(),
    menuItem(tags$b("Inicio"), tabName = "inicio", icon = icon("info-circle")), tags$br(),  tags$br(),
    # HTML(paste0('<h5 style="color: ', Paleta[1],
    #             '"><b>&ensp;Combinador de archivos:</b></h5>')),
    menuItem(tags$b("Combinar archivos DAC"), tabName = "CombFilesDAC", icon = icon("file")),
    menuItem(tags$b("Combinar archivos Excel"), tabName = "CombFilesExcel", icon = icon("file-excel")),
    
    # HTML(paste0('<hr><h6 style="color:', Paleta[1], '; font-size:10px;">
         # &ensp;&ensp;&ensp;Aplicativo desarrollado por <b>Cristhian Paredes</b></h6>')),
    tags$br(), tags$br(), tags$br(), tags$br(),
    
    materialSwitch(
      'Desarrollador', 
      h6(style = "display: inline;", 'Devel'), status = 'primary'),
    uiOutput('brwz')
  )
)