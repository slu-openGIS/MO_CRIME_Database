
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1989

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
  pop = 440435,
  homicide = 140,
  rape = 507,
  robbery = 3824,
  ag_assault = 4525,
  burglary = 12104,
  larceny = 25853,
  mv_larceny = 9075,
  arson = 477
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 73739,
  homicide = 2,
  rape = 14,
  robbery = 50,
  ag_assault = 447,
  burglary = 861,
  larceny = 2743,
  mv_larceny = 208,
  arson = 28
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 405066,
  homicide = 158,
  rape = 330,
  robbery = 4220,
  ag_assault = 7936,
  burglary = 13837,
  larceny = 26669,
  mv_larceny = 8932,
  arson = 601
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 143173,
  homicide = 7,
  rape = 61,
  robbery = 192,
  ag_assault = 345,
  burglary = 2612,
  larceny = 9151,
  mv_larceny = 539,
  arson = 117
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 41741,
  homicide = 1,
  rape = 19,
  robbery = 123,
  ag_assault = 120,
  burglary = 798,
  larceny = 1474,
  mv_larceny = 375,
  arson = 12
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
