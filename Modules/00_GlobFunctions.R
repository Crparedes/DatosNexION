# https://stackoverflow.com/a/52511866/7612904
getExtension <- function(file) strsplit(file, ".", fixed = TRUE)[[1]][3]

spcs <- function(n) {return(HTML(paste0(rep('&nbsp;', n), collapse = '')))}

ReqField <- function(x) {return(HTML(paste0(x, '<font color=\"#FF0000\">*</font>', spcs(3))))}


# Taken from https://www.rdocumentation.org/packages/berryFunctions/versions/1.21.14
is.error <- function (expr, tell = FALSE, force = FALSE) { 
  expr_name <- deparse(substitute(expr))
  test <- try(expr, silent = TRUE)
  iserror <- inherits(test, "try-error")
  if (tell) 
    if (iserror) 
      message("Note in is.error: ", test)
  if (force) 
    if (!iserror) 
      stop(expr_name, " is not returning an error.", call. = FALSE)
  iserror
}

niceRound <- function(x, n) {format(round(c(x, DummyNumber), digits = max(0, n)))[1]}

niceSeparator <- function(){
  return(tags$div('', tags$br(), tags$br(), 
                  tags$hr(style = paste0("border-top: 5px solid", BackHeaderButtons, ";"))))}
