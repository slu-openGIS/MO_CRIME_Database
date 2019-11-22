
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1993

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
  pop = 435428,
  homicide = 153,
  rape = 515,
  robbery = 3891,
  ag_assault = 6402,
  burglary = 12106,
  larceny = 23611,
  mv_larceny = 8487,
  arson = 527
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 72524,
  homicide = 3,
  rape = 33,
  robbery = 54,
  ag_assault = 233,
  burglary = 866,
  larceny = 3643,
  mv_larceny = 221,
  arson = 31
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 387053,
  homicide = 267,
  rape = 319,
  robbery = 6223,
  ag_assault = 8189,
  burglary = 12400,
  larceny = 26975,
  mv_larceny = 10065,
  arson = 806
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 146642,
  homicide = 7,
  rape = 77,
  robbery = 136,
  ag_assault = 449,
  burglary = 2094,
  larceny = 7690,
  mv_larceny = 454,
  arson = 134
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 39738,
  homicide = 5,
  rape = 16,
  robbery = 131,
  ag_assault = 110,
  burglary = 622,
  larceny = 1479,
  mv_larceny = 264,
  arson = 25
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
