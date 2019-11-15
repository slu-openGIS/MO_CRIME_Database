# Read 2005 Table in from `data/raw`

# define year
year <- 2005

# variables to clean-up
var_names <- c("pop", "violent_crime", "homicide", "rape", "robbery", "ag_assault",
               "property_crime", "burglary", "larceny", "mv_larceny", "arson")

# import raw data for large cities
data <- read_excel(path = here("data", "raw", paste0("us_city_", year, ".xls")),
                      sheet = "Cities", skip = 3, na = "-") %>%
  clean_names() %>%
  remove_empty(which = "cols") %>%
  remove_empty(which = "rows")

# rename and reformat columns
data %>%
  rename(
    pop = population,
    homicide = murder_and_nonnegligent_manslaughter,
    rape = forcible_rape,
    ag_assault = aggravated_assault,
    larceny = larceny_theft, 
    mv_larceny = motor_vehicle_theft, 
    arson = arson1
  ) %>%
  mutate_at(var_names, as.numeric) -> data

# calculate end of spreadsheet
end <- nrow(data)-9

# slice data
data <- slice(data, 1:end)

# add state abbreviations as column, review state name rows
data %>% 
  mutate(state = str_to_title(state)) %>%
  mutate(state = str_replace_all(string = state, pattern = "[[:digit:],]", replacement = "")) %>%
  mutate(state = str_trim(state, side = "both")) %>%
  rename(state_name = state)  %>%
  left_join(., states, by = "state_name") %>%
  select(-state_name) %>%
  select(state_abb, everything()) %>%
  rename(state = state_abb) %>%
  fill(state) %>%
  filter(is.na(pop) == FALSE) -> data

# subset to missouri
data <- filter(data, state == "MO")

# remove un-needed objects
rm(end, var_names)

# add place identifiers
data %>% 
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
  ) %>%
  arrange(name) -> data

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
rm(data, year)
