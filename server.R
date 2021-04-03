library(shiny)
library(shinydashboard)
shinyServer(function(input, output,session) {output$Next_Previous=renderUI({
  div(column(1,offset=1,Previous_Button),column(1,offset=8,Next_Button))
})})
Previous_Button=tags$div(actionButton("Prev_Tab",HTML('
<div class="col-sm-4"><i class="fa fa-angle-double-left fa-2x"></i></div>
')))
Next_Button=div(actionButton("Next_Tab",HTML('
<div class="col-sm-4"><i class="fa fa-angle-double-right fa-2x"></i></div>
')))