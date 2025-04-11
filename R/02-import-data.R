# Import libraries
library(readxl)
suppressPackageStartupMessages(library(sf))
suppressPackageStartupMessages(library(tsibble))
suppressPackageStartupMessages(library(tidyverse))

# Import MeteoLux data ----------------------------------------------------

filename <- list.files("./../data/", "*.gml")

gml_file <- st_read(paste0("./../data/", filename), quiet = TRUE)

string_data <- gml_file$values

# Split the string into rows based on the space delimiter
rows <- unlist(strsplit(string_data, " "))

# Split each row into columns based on the semicolon delimiter
data_list <- lapply(rows, function(row) unlist(strsplit(row, ";")))

# Determine the number of columns (assuming all rows have the same structure)
num_cols <- length(data_list[[1]])

# Create column names (you can adjust these as needed)
col_names <- paste0("col", 1:num_cols)

# Convert the list of rows into a tibble
df_temp <- as_tibble(do.call(rbind, data_list), .name_repair = "unique")

# Assign column names
colnames(df_temp) <- col_names

df_temp <- df_temp |>
  select(col1, col2, col3) |>
  rename(
    year = col1,
    mon = col2,
    temp_celcius = col3
  ) |>
  mutate(
    month = yearmonth(paste(year, mon, sep = "-")),
    temp_celcius = as.numeric(temp_celcius)
  ) |>
  select(month, temp_celcius)

# Import ILR data ---------------------------------------------------------

filename <- list.files("./../data/", "*.xlsx")

df_ilr <- read_xlsx(
  paste0("./../data/", filename),
  sheet = "1. Consommation",
  range = "A17:M49",
  col_names = TRUE,
  col_types = NULL,
  na = "",
  trim_ws = TRUE,
  skip = 0,
  guess_max = min(1000, Inf),
  progress = readxl_progress(),
  .name_repair = "unique"
)

names(df_ilr) <- c(
  "row_type", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
  "Aug", "Sep", "Oct", "Nov", "Dec"
)

df_ilr <- pivot_longer(df_ilr,
  cols = Jan:Dec,
  cols_vary = "slowest",
  names_to = "mon",
  values_to = "consumption_kwh"
)

df_ilr <- df_ilr |>
  mutate(year = ifelse(grepl("^\\d{4}$", row_type), row_type, NA)) |>
  fill(year, .direction = "down") |>
  filter(row_type == "Clients résidentiels") |>
  mutate(month = yearmonth(paste(year, mon, sep = "-"))) |>
  select(month, consumption_kwh) |>
  relocate(month, .before = everything()) |>
  arrange(month) |>
  mutate(consumption_gwh = consumption_kwh / 1e+6) |>
  select(-consumption_kwh) |>
  filter(!is.na(consumption_gwh)) |>
  as_tsibble(index = month)

# Join gas consumption data with temperature data -------------------------

df <- inner_join(df_ilr, df_temp, by = join_by(month)) |>
  as_tsibble(index = month)
