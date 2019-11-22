
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1981

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
  pop = 450211,
  homicide = 115,
  rape = 429,
  robbery = 3235,
  ag_assault = 3935,
  burglary = 14839,
  larceny = 24690,
  mv_larceny = 3762,
  arson = 513
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 77128,
  homicide = 3,
  rape = 35,
  robbery = 62,
  ag_assault = 213,
  burglary = 1595,
  larceny = 3485,
  mv_larceny = 278,
  arson = 0
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 454166,
  homicide = 265,
  rape = 413,
  robbery = 5365,
  ag_assault = 4321,
  burglary = 19214,
  larceny = 27195,
  mv_larceny = 5881,
  arson = 443
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 134016,
  homicide = 8,
  rape = 41,
  robbery = 126,
  ag_assault = 191,
  burglary = 4037,
  larceny = 8592,
  mv_larceny = 419,
  arson = 94
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 43016,
  homicide = 3,
  rape = 22,
  robbery = 128,
  ag_assault = 111,
  burglary = 1378,
  larceny = 1815,
  mv_larceny = 205,
  arson = 0
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
