
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1984

# use index to parse places
places %>%
  filter(NAME %in% index) %>%
  rename(name = NAME, placefp = PLACEFP) %>%
  mutate(year = rep(year, n())) %>%
  select(year, name, placefp) %>%
  arrange(name) -> placesSub

# create population object
pop <- tibble(
  name = index,
  count = c(450484, 76466, 442528, 136044, 43234)
)

# create kansas city object
kansas_city <- tibble(
  name = "Kansas City",
  pop = 450484,
  homicide = 88,
  rape = 372,
  robbery = 2440,
  ag_assault = 4267,
  burglary = 11182,
  larceny = 22729,
  mv_larceny = 4338,
  arson = 432
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 76466,
  homicide = 2,
  rape = 17,
  robbery = 42,
  ag_assault = 158,
  burglary = 1494,
  larceny = 2966,
  mv_larceny = 184,
  arson = 34
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 442528,
  homicide = 128,
  rape = 349,
  robbery = 3112,
  ag_assault = 4140,
  burglary = 13256,
  larceny = 21051,
  mv_larceny = 5196,
  arson = 396
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 136044,
  homicide = 13,
  rape = 42,
  robbery = 135,
  ag_assault = 164,
  burglary = 2177,
  larceny = 6744,
  mv_larceny = 414,
  arson = 70
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 43234,
  homicide = 5,
  rape = 25,
  robbery = 93,
  ag_assault = 116,
  burglary = 746,
  larceny = 1176,
  mv_larceny = 162,
  arson = 14
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
