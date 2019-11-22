# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1996

# use index to parse places
places %>%
  filter(NAME %in% index) %>%
  rename(name = NAME, placefp = PLACEFP) %>%
  mutate(year = rep(year, n())) %>%
  select(year, name, placefp) %>%
  arrange(name) -> placesSub

# create kansas city object
kansas_city <- tibble(
  name = "Kansas City",
  pop = 448474,
  homicide = 104,
  rape = 412,
  robbery = 2881,
  ag_assault = 5488,
  burglary = 8947,
  larceny = 28124,
  mv_larceny = 6344,
  arson = 426
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = NA,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = NA
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 374041,
  homicide = 166,
  rape = 269,
  robbery = 4086,
  ag_assault = 5682,
  burglary = 9887,
  larceny = 29228,
  mv_larceny = 7270,
  arson = 784
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 152024,
  homicide = 4,
  rape = 76,
  robbery = 173,
  ag_assault = 542,
  burglary = 2182,
  larceny = 7851,
  mv_larceny = 677,
  arson = 103
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 41403,
  homicide = 3,
  rape = 16,
  robbery = 93,
  ag_assault = 67,
  burglary = 462,
  larceny = 1922,
  mv_larceny = 187,
  arson = 8
)

# combine
data <- bind_rows(kansas_city, st_jo, st_louis, springfield, u_city)

# add place data
data <- left_join(placesSub, data, by = "name")

# clean-up enviornment
rm(placesSub, kansas_city, st_jo, st_louis, springfield, u_city)

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
rm(index, data, year)
