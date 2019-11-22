
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1983

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
  pop = 453128,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = 462
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 77627,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = 32
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 457262,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = 315
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 134883,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = 59
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 43294,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = 20
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
# homicideTable <- subset_tables(input = data, update = homicideTable, table = "homicide")

# update robbery object
# robberyTable <- subset_tables(input = data, update = robberyTable, table = "robbery")

# update aggrevated assault object
# agAssaultTable <- subset_tables(input = data, update = agAssaultTable, table = "aggravated assault")

# create rape object
# rapeTable <- subset_tables(input = data, update = rapeTable, table = "rape")

# create burlary object
# burglaryTable <- subset_tables(input = data, update = burglaryTable, table = "burglary")

# create larceny object
# larcenyTable <- subset_tables(input = data, update = larcenyTable, table = "larceny")

# create auto theft object
# autoTheftTable <- subset_tables(input = data, update = autoTheftTable, table = "auto theft")

# create arson object
arsonTable <- subset_tables(input = data, update = arsonTable, table = "arson")

# clean-up enviornment
rm(index, data, year)
