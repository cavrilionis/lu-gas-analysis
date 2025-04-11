# Download a resource from a given data set on data.public.lu
# It takes as input the URL of a data set and stores the resulting file
# on the local filesystem.

download_file <- function(url) {
  # Extract file name from URL
  parsed_url <- urltools::url_parse(url)
  filename <- base::basename(parsed_url$path)

  if (base::file.exists(paste0("./../data/", filename))) {
    cli::cli_alert_info("{filename} is already downloaded.")
  } else {
    # Download the file
    cli::cli_alert_info("Downloading: {filename}")
    utils::download.file(
      url = url,
      destfile = paste0("./../data/", filename),
      method = "auto",
      quiet = TRUE,
      mode = "w",
      cacheOK = TRUE
    )
    cli::cli_alert_success("Downloaded!")
  }
}

cfg <- yaml::read_yaml("./../R/config.yaml")

download_file(url = cfg$ilr_url)
download_file(url = cfg$meteolux_url)
