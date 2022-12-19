customSidebar <- dashboardSidebar(
  tags$style(".left-side, .main-sidebar {padding-top: 110px;}"), # font-size: larger
  width = 300, withMathJax(),
  sidebarMenu(
    id = "tabs", # tags$br(), tags$br(),
    menuItem("Inicio", tabName = "inicio", icon = icon("info-circle")), tags$br(),  tags$br(),
    
    tags$b(HTML('&ensp;'), 'Reordenamiento de archivos'),
    menuItem("Combinar archivos XLSX", tabName = "ArchivosXLSX", icon = icon("file-excel")),
    
    tags$hr(),
    HTML('<h6 style="color: #dddddd; font-size:9px;">
         &ensp;&ensp;&ensp;Aplicativo desarrollado por <b>Cristhian Paredes</b></h6>'),
    tags$br(), tags$br(), tags$br(), tags$br(),
    
    materialSwitch('Desarrollador', 'Modo de desarrollador', status = 'primary'),
    uiOutput('brwz')
  )
)