
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1985

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
  pop = 444942,
  homicide = 91,
  rape = 424,
  robbery = 2646,
  ag_assault = 4851,
  burglary = 11164,
  larceny = 21888,
  mv_larceny = 5552,
  arson = 495
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 76788,
  homicide = 6,
  rape = 22,
  robbery = 35,
  ag_assault = 174,
  burglary = 1267,
  larceny = 2552,
  mv_larceny = 182,
  arson = 29
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 431109,
  homicide = 169,
  rape = 384,
  robbery = 3136,
  ag_assault = 4953,
  burglary = 13498,
  larceny = 21390,
  mv_larceny = 5583,
  arson = 427
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 137516,
  homicide = 6,
  rape = 54,
  robbery = 109,
  ag_assault = 137,
  burglary = 2168,
  larceny = 6728,
  mv_larceny = 389,
  arson = 48
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 43416,
  homicide = 2,
  rape = 27,
  robbery = 74,
  ag_assault = 144,
  burglary = 700,
  larceny = 1279,
  mv_larceny = 198,
  arson = 16
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
