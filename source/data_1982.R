
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1982

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
  pop = 451397,
  homicide = 93,
  rape = 376,
  robbery = 2756,
  ag_assault = 3504,
  burglary = 12864,
  larceny = 22766,
  mv_larceny = 3144,
  arson = 448
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 77331,
  homicide = 3,
  rape = 15,
  robbery = 53,
  ag_assault = 197,
  burglary = 1385,
  larceny = 3784,
  mv_larceny = 190,
  arson = 37
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 455362,
  homicide = 226,
  rape = 316,
  robbery = 4899,
  ag_assault = 4628,
  burglary = 17149,
  larceny = 27638,
  mv_larceny = 5280,
  arson = 364
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 134368,
  homicide = 6,
  rape = 56,
  robbery = 160,
  ag_assault = 195,
  burglary = 3288,
  larceny = 7871,
  mv_larceny = 420,
  arson = 83
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 43129,
  homicide = 3,
  rape = 19,
  robbery = 135,
  ag_assault = 89,
  burglary = 1268,
  larceny = 1648,
  mv_larceny = 204,
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
