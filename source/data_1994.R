
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1994

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
  pop = 439089,
  homicide = 142,
  rape = 490,
  robbery = 3727,
  ag_assault = 6334,
  burglary = 11958,
  larceny = 25109,
  mv_larceny = 7352,
  arson = 508
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 73113,
  homicide = 2,
  rape = 24,
  robbery = 43,
  ag_assault = 206,
  burglary = 879,
  larceny = 3727,
  mv_larceny = 202,
  arson = 43
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 390437,
  homicide = 248,
  rape = 304,
  robbery = 6025,
  ag_assault = 8067,
  burglary = 12522,
  larceny = 27744,
  mv_larceny = 8929,
  arson = 854
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 147875,
  homicide = 3,
  rape = 74,
  robbery = 184,
  ag_assault = 551,
  burglary = 2369,
  larceny = 9317,
  mv_larceny = 598,
  arson = 103
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 40072,
  homicide = 3,
  rape = 18,
  robbery = 140,
  ag_assault = 139,
  burglary = 600,
  larceny = 1807,
  mv_larceny = 297,
  arson = 23
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
