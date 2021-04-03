library(shiny)
library(shinydashboard)
dashboardPage(
  dashboardHeader(disable = T),
  dashboardSidebar(disable = T),
  dashboardBody(box(width=12,
                    tabBox(width=12,id="tabBox_next_previous",
                           tabPanel("Tab1",p("This is tab 1")),
                           tabPanel("Tab2",p("This is tab 2")),
                           tabPanel("Tab3",p("This is tab 3")),
                           tabPanel("Tab4",p("This is tab 4"))
                    ),
                    uiOutput("Next_Previous")
  )
  ))
)