
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1990

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
  pop = 434711,
  homicide = 121,
  rape = 517,
  robbery = 4492,
  ag_assault = 5957,
  burglary = 11640,
  larceny = 23229,
  mv_larceny = 10352,
  arson = 509
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 71852,
  homicide = 4,
  rape = 16,
  robbery = 26,
  ag_assault = 514,
  burglary = 908,
  larceny = 2696,
  mv_larceny = 203,
  arson = 30
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 396685,
  homicide = 177,
  rape = 331,
  robbery = 4708,
  ag_assault = 8466,
  burglary = 11531,
  larceny = 24564,
  mv_larceny = 8422,
  arson = 687
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 140494,
  homicide = 7,
  rape = 58,
  robbery = 139,
  ag_assault = 367,
  burglary = 2354,
  larceny = 9193,
  mv_larceny = 431,
  arson = 91
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 40087,
  homicide = 2,
  rape = 15,
  robbery = 110,
  ag_assault = 147,
  burglary = 637,
  larceny = 1445,
  mv_larceny = 369,
  arson = 18
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
