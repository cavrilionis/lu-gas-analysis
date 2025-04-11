# Import libraries
library(httr)
library(jsonlite)
library(urltools)
library(cli)

# Download all files from a given data set on data.public.lu
# It takes as input the ID of a data set and stores the resulting files
# on the local filesystem.

download_ilr_file <- function(dataset) {
  api <- "https://data.public.lu/api/1"

  # Get all metadata from the data set
  url <- paste0(api, "/datasets/", dataset, "/")
  r <- GET(url)
  stop_for_status(r)

  # Extract the information about the resources (= files)
  content <- content(r, "text", encoding = "UTF-8")
  data <- fromJSON(content)
  resources <- data$resources

  # Download the resources and save them
  if (!is.null(resources) && length(resources) > 0) {
    for (i in seq_len(nrow(resources))) {
      resource <- resources[i, ]
      cli_alert_info("Downloading: {resource$title}")
      s <- GET(resource$url)
      stop_for_status(s)

      # Extract file name from URL
      parsed_url <- url_parse(resource$url)
      filename <- basename(parsed_url$path)

      # Download and save the file
      writeBin(content(s, "raw"), con = file.path(".", "..", "data", filename))
      cli_alert_success("Downloaded!")
    }
  } else {
    cli_alert_danger("No resources found for this dataset.")
  }
}

# Please fill in here the id of the data set you want to get
# The id of the data set can be found at the end of the URL of the data set

dataset_name <- "donnees-statistiques-du-secteur-de-gaz-naturel-ilr"

if (file.exists("./../data/tableau-de-bord-gaz-version-04.-decembre-2024.xlsx")) {
  cli_alert_info("ILR data are already downloaded")
} else {
  download_ilr_file(dataset_name)
}
