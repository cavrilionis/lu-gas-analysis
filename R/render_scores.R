
library(gm)

# Notes list
notes <- c(
  "E2",
  "F2",
  "G2",
  "A2",
  "B2",
  "C3",
  "D3",
  "E3",
  "F3",
  "G3",
  "A3",
  "B3",
  "C4",
  "D4",
  "E4",
  "F4",
  "G4"
)

for (note in notes) {
  music <- Music() +
    Line(pitches = c(note), durations = c(4)) +
    Meter(4, 4, invisible = TRUE) +
    Clef("F")
  export(music, paste0("www/", note, ".png"))
}

length(notes)
