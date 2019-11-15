# dependencies
library(DBI)      # database management
library(dplyr)    # data wrangling
library(purrr)
library(here)     # file path management
library(janitor)  # data wrangling
library(readxl)   # read excel files
library(stringr)  # string wrangling
library(tidyr)    # data wrangling
library(tigris)   # download placenames
library(sf)       # spatial tools

source("source/subset_tables.R")

# download and process place data
places <- places(state = 29, class = "sf")

### remove geometric data
st_geometry(places) <- NULL

### subset columns
places <- select(places, NAME, PLACEFP)

# create tibble of state names and abbreviations
states <- tibble(
  state_abb = c(state.abb, "DC"),
  state_name = c(state.name, "District Of Columbia"))

# create database tables
years <- c(1999:2018)

years %>%
  unlist() %>%
  map(~source(paste0("source/data_", .x, ".R")))

# clean-up enviornment
rm(index, agAssault, arson, autoTheft, burglary, homicide, larceny, places, placesSub, pop, rape, robbery,
   years, states, subset_tables)

# write database tables
source("source/_database.R")
