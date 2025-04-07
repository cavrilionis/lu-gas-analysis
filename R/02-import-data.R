# Import libraries
library(tidyverse)
library(readxl)
library(fpp3)

df_raw <- read_xlsx(
  "./data/tableau-de-bord-gaz-version-04.-decembre-2024.xlsx",
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

View(df_raw)

names(df_raw) <- c("row_type", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                   "Aug", "Sep", "Oct", "Nov", "Dec")

str(df_raw)

df <- pivot_longer(df_raw, 
                   cols = Jan:Dec, 
                   cols_vary = "slowest",
                   names_to = "mon", 
                   values_to = "consumption_kwh")

df <- df |>
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
  

head(df)

df |> 
  autoplot(consumption_gwh) +
  labs(x = "Month",
       y = "Consumption in GWh",
       title = "Monthly residential gas consumption in GWh") +
  ylim(0, NA) +
  theme_minimal()

lambda <- df |> 
  features(consumption_gwh, features = guerrero) |> 
  pull(lambda_guerrero)

print(lambda)

df |> 
  autoplot(box_cox(consumption_gwh, lambda)) +
  labs(x = "Month", 
       y = "Transformed consumption",
       title = latex2exp::TeX(paste0(
         "Transformed monthly residential gas consumption with $\\lambda$ = ",
         round(lambda, 2)))) +
  ylim(0, NA) +
  theme_minimal()


