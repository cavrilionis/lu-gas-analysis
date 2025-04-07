
server <- function(input, output, session) {
  correct_count <- reactiveVal(0)
  total_count <- reactiveVal(0)
  generated_note <- reactiveVal()
  selected_file <- reactiveVal()

  folder_path <- "./www"

  pick_random_file <- function(folder_path) {
    files <- list.files(folder_path, full.names = TRUE)
    if (length(files) == 0) {
      showNotification("Error: No files found in the specified folder.",
                       type = "error")
      NULL
    } else {
      sample(files, 1)
    }
  }

  observe({
    new_file <- pick_random_file(folder_path)
    if (!is.null(new_file)) {
      selected_file(new_file)
      note_name <- gsub(".*([A-G]).*", "\\1", basename(new_file))
      generated_note(note_name)
    }
  })

  output$noteImage <- renderImage({
    req(selected_file())
    list(src = selected_file(), alt = "Musical Score")
  }, deleteFile = FALSE)

  observeEvent(input$submit, {
    req(input$guess)
    req(input$numNotes)

    if (total_count() < input$numNotes) {
      correct_note <- generated_note()
      if (input$guess == correct_note) {
        correct_count(correct_count() + 1)
        output$result <- renderText("Correct!")
      } else {
        output$result <- renderText(paste("Incorrect! The correct note was",
                                          correct_note))
      }

      total_count(total_count() + 1)
      updateRadioButtons(session, "guess", selected = character(0))

      if (total_count() >= input$numNotes) {
        output$result <- renderText("Game Over!")
        shinyjs::disable("submit")
      } else {
        new_file <- pick_random_file(folder_path)
        if (!is.null(new_file)) {
          selected_file(new_file)
          note_name <- gsub(".*([A-G]).*", "\\1", basename(new_file))
          generated_note(note_name)
        }
      }
    }
  })

  output$percentage <- renderText({
    if (total_count() > 0) {
      percentage <- (correct_count() / total_count()) * 100
      paste("Percentage of correct guesses:",
            round(percentage, 2),
            "%")
    } else {
      "Percentage of correct guesses: 0%"
    }
  })

  observeEvent(input$restart, {
    correct_count(0)
    total_count(0)
    new_file <- pick_random_file(folder_path)
    if (!is.null(new_file)) {
      selected_file(new_file)
      note_name <- gsub(".*([A-G]).*", "\\1", basename(new_file))
      generated_note(note_name)
    }
    updateRadioButtons(session, "guess", selected = character(0))
    output$result <- renderText("")
    shinyjs::enable("submit")
  })
}
