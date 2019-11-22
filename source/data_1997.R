
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1997

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
  pop = 452070,
  homicide = 100,
  rape = 417,
  robbery = 2711,
  ag_assault = 5341,
  burglary = 8641,
  larceny = 24874,
  mv_larceny = 7427,
  arson = 442
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 73394,
  homicide = 2,
  rape = 14,
  robbery = 33,
  ag_assault = 125,
  burglary = 722,
  larceny = 3575,
  mv_larceny = 219,
  arson = 38
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 377221,
  homicide = 153,
  rape = 225,
  robbery = 3572,
  ag_assault = 5641,
  burglary = 10097,
  larceny = 23405,
  mv_larceny = 8121,
  arson = 837
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 153243,
  homicide = 7,
  rape = 63,
  robbery = 158,
  ag_assault = 496,
  burglary = 2019,
  larceny = 7265,
  mv_larceny = 685,
  arson = 121
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 41735,
  homicide = 3,
  rape = 7,
  robbery = 89,
  ag_assault = 44,
  burglary = 472,
  larceny = 1427,
  mv_larceny = 208,
  arson = 11
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
