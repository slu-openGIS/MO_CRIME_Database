# Read 2018 Table in from `data/raw`

# define year
year <- 2018

# variables to clean-up
var_names <- c("pop", "violent_crime", "homicide", "rape", "robbery", "ag_assault",
               "property_crime", "burglary", "larceny", "mv_larceny", "arson")

# import raw data for Missouri
data <- read_excel(path = here("data", "raw", paste0("missouri_", year, ".xls")),
                   sheet = "18tbl08mo", skip = 4, na = "-") %>%
  clean_names() %>%
  remove_empty(which = "cols") %>%
  remove_empty(which = "rows")

# rename and reformat columns
data %>%
  rename(
    pop = population,
    homicide = murder_and_nonnegligent_manslaughter,
    rape = rape1,
    ag_assault = aggravated_assault,
    larceny = larceny_theft, 
    mv_larceny = motor_vehicle_theft,
    arson = arson2
  ) %>%
  mutate_at(var_names, as.numeric) -> data

# calculate end of spreadsheet
end <- nrow(data)-7

# slice data
data <- slice(data, 1:end)

# remove footnote references
data %>% 
  mutate(city = str_replace_all(string = city, pattern = "[:digit:]", replacement = "")) %>%
  mutate(city = str_trim(city, side = "both")) -> data

# remove un-needed objects
rm(end, var_names)

# add place identifiers
data %>% 
  left_join(., places, by = c("city" = "NAME")) %>%
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
rm(data, year)
