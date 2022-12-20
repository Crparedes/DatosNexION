customBody <- dashboardBody(
  tags$script(HTML("$('body').addClass('fixed');")),
  
  includeCSS('www/Style.css'),
  tags$head(
      # tags$link(rel = "stylesheet", type = "text/css", href = "Style.css"),
    tags$style(HTML('.wrapper {height: auto !important; position:relative; overflow-x:hidden; overflow-y:hidden}
                     .shiny-notification {position:fixed; top: calc(50% - 150px); left: calc(50% - 150px); 
                                         height: auto !important; opacity:0.98; margin-right:500px}
                     .btn-box-tool {color: #001848; font-size: 15px}')),
    tags$style(type = "text/css", "#inline label{ display: table-cell; text-align: right; vertical-align: middle; } 
               #inline .form-group {display: table-row;}"),
    tags$style(type = "text/css", "#inlineTOP label{ display: table-cell; text-align: right; vertical-align: top; } 
               #inlineTOP .form-group {display: table-row;}"),
    tags$style(type = "text/css", "#inlineBOT label{ display: table-cell; text-align: right; vertical-align: bottom; } 
               #inlineBOT .form-group {display: table-row;}")
  ), 
  customTheme,
  withMathJax(),
  tabItems(
    tabItem(tabName = "inicio", Introduccion),
    tabItem(tabName = "ArchivosXLSX", ArchivosXLSX_UI('ArchivosXLSX'))
  )
)
