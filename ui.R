
fluidPage(
  useShinyjs(),
  theme = shinythemes::shinytheme("yeti"),
  titlePanel("NoteGuessR"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "numNotes",
        "Number of Notes to Guess:",
        min = 5,
        max = 30,
        value = 5
      ),
      radioButtons(
        "guess",
        "Guess the Note:",
        choices = c("C", "D", "E", "F", "G", "A", "B"),
        selected = character(0)
      ),
      actionButton("submit", "Submit"),
      actionButton("restart", "Restart")
    ),
    mainPanel(
      tags$div(
        style = "display: flex; flex-direction: column; align-items: left;",
        tags$div(
          style = "max-height: 150px; overflow: hidden;", # Adjust max-height as needed
          imageOutput("noteImage")
        ),
        tags$div(
          style = "margin-top: 5px; margin-bottom: 0px;",
          textOutput("result"),
          textOutput("percentage")
        )
      )
    )
  )
)