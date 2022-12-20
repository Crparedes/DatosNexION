Paleta <- c('#28363D', '#2F575D', '#658B6F', 
            '#6D9197', '#99AEAD', '#C4CDC1', 
            '#DEE1DD', '#FFFFFF')

customTheme <- shinyDashboardThemeDIY(
  ### general
  appFontFamily = "Arial"
  ,appFontColor = Paleta[1]
  ,primaryFontColor = Paleta[1]
  ,infoFontColor = Paleta[1]
  ,successFontColor = Paleta[1]
  ,warningFontColor = Paleta[1]
  ,dangerFontColor = Paleta[1]
  ,bodyBackColor = Paleta[7]
  
  ### header
  ,logoBackColor = Paleta[1]
  
  ,headerButtonBackColor = "rgb(221,221,221)"
  ,headerButtonIconColor = "rgb(75,75,75)"
  ,headerButtonBackColorHover = "rgb(21,21,21)"
  ,headerButtonIconColorHover = "rgb(0,0,0)"
  
  ,headerBackColor = Paleta[1]
  ,headerBoxShadowColor = "#000000"
  ,headerBoxShadowSize = "3px 3px 3px"
  
  ### sidebar
  ,sidebarBackColor = Paleta[5]
  ,sidebarPadding = 0
  
  ,sidebarMenuBackColor = "transparent"
  ,sidebarMenuPadding = 0
  ,sidebarMenuBorderRadius = 0
  
  ,sidebarShadowRadius = "3px 5px 5px"
  ,sidebarShadowColor = "#aaaaaa"
  
  ,sidebarUserTextColor = Paleta[1]
  
  ,sidebarSearchBackColor = "rgb(55,72,80)"
  ,sidebarSearchIconColor = "rgb(153,153,153)"
  ,sidebarSearchBorderColor = "rgb(55,72,80)"
  
  ,sidebarTabTextColor = Paleta[1]
  ,sidebarTabTextSize = 14
  ,sidebarTabBorderStyle = "none none none none"
  ,sidebarTabBorderColor = Paleta[1]
  ,sidebarTabBorderWidth = 1
  
  ,sidebarTabBackColorSelected = Paleta[6]
  ,sidebarTabTextColorSelected = Paleta[1]
  ,sidebarTabRadiusSelected = "0px 10px 10px 0px"
  
  ,sidebarTabBackColorHover = Paleta[7]
  ,sidebarTabTextColorHover = Paleta[2]
  ,sidebarTabBorderStyleHover = "none none solid none"
  ,sidebarTabBorderColorHover = Paleta[1]
  ,sidebarTabBorderWidthHover = 1
  ,sidebarTabRadiusHover = "0px 10px 10px 0px"
  
  ### boxes
  ,boxBackColor = "rgb(245,245,245)"
  ,boxBorderRadius = 5
  ,boxShadowSize = "0px 1px 1px"
  ,boxShadowColor = "rgba(0,0,0,.4)"
  ,boxTitleSize = 16
  ,boxDefaultColor = "rgb(210,214,220)"
  ,boxPrimaryColor = "rgb(1, 1, 1)"
  ,boxInfoColor = "rgb(210,214,220)"
  ,boxSuccessColor = "rgba(0,166,90,1)"
  ,boxWarningColor = "rgb(52, 177, 201)"
  ,boxDangerColor = "rgb(221,75,57)"
  
  ,tabBoxTabColor = "rgb(248,248,248)"
  ,tabBoxTabTextSize = 14
  ,tabBoxTabTextColor = "rgb(0,0,0)"
  ,tabBoxTabTextColorSelected = "rgb(0,0,0)"
  ,tabBoxBackColor = "rgb(248,248,248)"
  ,tabBoxHighlightColor = "rgb(44,62,80)"
  ,tabBoxBorderRadius = 5
  
  ### inputs
  ,buttonBackColor = Paleta[1]
  ,buttonTextColor = Paleta[7]
  ,buttonBorderColor = "rgb(200,200,200)"
  ,buttonBorderRadius = 5
  
  ,buttonBackColorHover = Paleta[2]
  ,buttonTextColorHover = Paleta[6]
  ,buttonBorderColorHover = "rgb(200,200,200)"
  
  ,textboxBackColor = "rgb(255,255,255)"
  ,textboxBorderColor = "rgb(200,200,200)"
  ,textboxBorderRadius = 5
  ,textboxBackColorSelect = "rgb(245,245,245)"
  ,textboxBorderColorSelect = "rgb(200,200,200)"
  
  ### tables
  ,tableBackColor = "rgb(255,255,255)"
  ,tableBorderColor = "rgb(240,240,240)"
  ,tableBorderTopSize = 1
  ,tableBorderRowSize = 1
)