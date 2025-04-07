# Import libraries
library(httr)
library(jsonlite)
library(urltools)

# Download all files from a given data set on data.public.lu
# It takes as input the ID of a data set and stores the resulting files
# on the local filesystem.

# Please fill in here the id of the data set you want to get
# The id of the data set can be found at the end of the URL of the data set

api <- "https://data.public.lu/api/1"

dataset <- "donnees-statistiques-du-secteur-de-gaz-naturel-ilr"

# Get all metadata from the data set
url <- paste0(api, "/datasets/", dataset, "/")
r <- GET(url)
stop_for_status(r)

content_type <- headers(r)["content-type"]
print(paste("Content-type:", content_type))

content_encoding <- headers(r)["content-encoding"]
print(paste("Content-encoding:", content_encoding))

# Extract the information about the resources (= files)
content <- content(r, "text", encoding = "UTF-8")
data <- fromJSON(content)
resources <- data$resources

# Download the resources and save them
if (!is.null(resources) && length(resources) > 0) {
  for (i in seq_len(nrow(resources))) {
    resource <- resources[i, ]
    print(paste("Downloading:", resource$title))
    s <- GET(resource$url)
    stop_for_status(s)
    
    # Extract filename from URL
    parsed_url <- url_parse(resource$url)
    filename <- basename(parsed_url$path)
    
    # Download and save the file
    writeBin(content(s, "raw"), con = file.path("data", filename))
    print("Downloaded!")
  }
} else {
  print("No resources found for this dataset.")
}
