
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1992

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
  pop = 441162,
  homicide = 150,
  rape = 564,
  robbery = 4494,
  ag_assault = 7386,
  burglary = 12551,
  larceny = 21846,
  mv_larceny = 8042,
  arson = 508
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 72917,
  homicide = 2,
  rape = 23,
  robbery = 48,
  ag_assault = 288,
  burglary = 880,
  larceny = 2943,
  mv_larceny = 213,
  arson = 46
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 402573,
  homicide = 231,
  rape = 349,
  robbery = 4936,
  ag_assault = 7731,
  burglary = 12303,
  larceny = 25600,
  mv_larceny = 8429,
  arson = 935
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 142578,
  homicide = 8,
  rape = 61,
  robbery = 165,
  ag_assault = 415,
  burglary = 1961,
  larceny = 7842,
  mv_larceny = 464,
  arson = 104
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 40681,
  homicide = 4,
  rape = 22,
  robbery = 101,
  ag_assault = 109,
  burglary = 709,
  larceny = 1447,
  mv_larceny = 307,
  arson = 15
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
