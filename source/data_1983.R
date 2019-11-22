
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
  homicide = 106,
  rape = 425,
  robbery = 2876,
  ag_assault = 4045,
  burglary = 11636,
  larceny = 23244,
  mv_larceny = 3056,
  arson = 462
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 77627,
  homicide = 4,
  rape = 14,
  robbery = 49,
  ag_assault = 139,
  burglary = 1633,
  larceny = 3595,
  mv_larceny = 213,
  arson = 32
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 457262,
  homicide = 152,
  rape = 323,
  robbery = 3840,
  ag_assault = 4146,
  burglary = 14199,
  larceny = 22974,
  mv_larceny = 5353,
  arson = 315
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 134883,
  homicide = 5,
  rape = 42,
  robbery = 148,
  ag_assault = 168,
  burglary = 2663,
  larceny = 7525,
  mv_larceny = 422,
  arson = 59
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 43294,
  homicide = 5,
  rape = 15,
  robbery = 106,
  ag_assault = 99,
  burglary = 917,
  larceny = 1309,
  mv_larceny = 182,
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
