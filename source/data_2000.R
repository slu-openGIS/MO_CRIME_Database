# Read 2000 Table in from `data/raw`

# define year
year <- 2000

# import raw data
data <- read_excel(path = here("data", "raw", paste0("us_lgCity_", year, ".xls")),
                   sheet = "TABLE9A", skip = 3, na = "-") %>%
  clean_names() %>%
  remove_empty(which = "cols") %>%
  remove_empty(which = "rows")

# rename cols
data <- rename(data,
               pop = population,
               total = crime_index_total,
               total_m = modified_crime_index_total1,
               homicide = murder_and_non_negligent_man_slaughter,
               rape = forcible_rape,
               ag_assault = aggravated_assault,
               larceny = larceny_theft,
               mv_larceny = motor_vehicle_theft)

# calculate end of spreadsheet
end <- nrow(data)-10

# variables to clean-up
var_names <- c("pop", "total", "total_m", "homicide", "rape", "robbery", "ag_assault",
               "burglary", "larceny", "mv_larceny", "arson")

# add state abbreviations as column, review state name rows
data %>% 
  slice(1:end) %>%
  mutate(city_by_state = str_to_title(city_by_state)) %>%
  mutate(city_by_state = str_replace_all(string = city_by_state, pattern = "[[:digit:],]", replacement = "")) %>%
  mutate(city_by_state = str_trim(city_by_state, side = "both")) %>%
  mutate(state_name = ifelse(city_by_state %in% states$state_name == TRUE &
                             is.na(pop) == TRUE, city_by_state, NA)) %>%
  left_join(., states, by = "state_name") %>%
  select(-state_name) %>%
  select(state_abb, everything()) %>%
  fill(state_abb) %>%
  filter(is.na(pop) == FALSE) %>%
  rename(
    state = state_abb,
    city = city_by_state
  ) -> data

# re-format columns
data %>%
  mutate_at(var_names, as.numeric) %>%
  mutate_at(var_names, ~replace(., is.na(.), 0)) -> data

# remove un-needed objects
rm(end, var_names)

# subset to missouri
data <- filter(data, state == "MO")

# add place identifiers
data %>% 
  filter(state == "MO") %>%
  mutate(
    city = ifelse(city == "O'fallon", "O'Fallon", city),
    city = ifelse(city == "Town And Country", "Town and Country", city)
  ) %>%
  left_join(., places, by = c("city" = "NAME")) %>%
  select(-state) %>%
  mutate(year = year) %>%
  select(year, city, PLACEFP, everything()) %>%
  rename(
    name = city,
    placefp = PLACEFP
  ) -> data

# update population object
popTable <- subset_tables(input = data, update = popTable, table = "population")

# update homicide object
homicideTable <- subset_tables(input = data, update = homicideTable, table = "homicide")

# update robbery object
robberyTable <- subset_tables(input = data, update = robberyTable, table = "robbery")

# update aggrevated assault object
agAssaultTable <- subset_tables(input = data, update = agAssaultTable, table = "aggravated assault")

# create rape object
rapeTable <- subset_tables(input = data, update = rapeTable, table = "rape")

# create burlary object
burglaryTable <- subset_tables(input = data, update = burglaryTable, table = "burglary")

# create larceny object
larcenyTable <- subset_tables(input = data, update = larcenyTable, table = "larceny")

# create auto theft object
autoTheftTable <- subset_tables(input = data, update = autoTheftTable, table = "auto theft")

# create arson object
arsonTable <- subset_tables(input = data, update = arsonTable, table = "arson")

# clean-up enviornment
rm(data)
