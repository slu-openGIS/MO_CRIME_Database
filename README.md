# MO_CRIME_Database

This repository contains the raw data and code for creating `MO_CRIME_Database.sqlite`. This is a longitudinal database containing counts for each Part 1 crime category per year for all Missouri municipalities that reported data to the Federal Bureau of Investigation's Uniform Crime Reporting program.

The database currently contains all municipal level data from 1999 through 2018, and will be continually updated with historical data with the eventual goal of containing all count data from 1940 onwards. If you are interested in working with pre-1999 data for Missouri, the `data/raw` folder contains the relevant extrats from the *Crime in the United States* publications for each year.

## Using the Database
Users should not have to re-build the database themselves. `R` users can connect to the database using the following syntax:

```r
# dependencies
library(DBI)
library(dplyr)
# dbplyr must also be installed but does not need to be loaded

# establish connection
con <- dbConnect(RSQLite::SQLite(), "data/MO_CRIME_Database.sqlite")
homicide_db <- tbl(con, "homicide")

# query
homicide_db %>% 
  filter(name == "St. Louis")
```

## Limitations
Aside from the temporal limit noted above, all footnotes have been removed from tables. Users should be familiar with the limitations for particular categories of crime and particular agencies prior to working with these data. Additional documentation and flagging will be added in the future to identify agencies with potentially unreliable data practices.
