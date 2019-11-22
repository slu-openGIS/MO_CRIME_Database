
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1988

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
  pop = 447461,
  homicide = 134,
  rape = 473,
  robbery = 3479,
  ag_assault = 4230,
  burglary = 13409,
  larceny = 24579,
  mv_larceny = 7184,
  arson = 588
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 74159,
  homicide = 1,
  rape = 11,
  robbery = 36,
  ag_assault = 246,
  burglary = 991,
  larceny = 2713,
  mv_larceny = 208,
  arson = 16
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 425187,
  homicide = 140,
  rape = 305,
  robbery = 3327,
  ag_assault = 6709,
  burglary = 12541,
  larceny = 26735,
  mv_larceny = 7458,
  arson = 657
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 141762,
  homicide = 5,
  rape = 67,
  robbery = 137,
  ag_assault = 305,
  burglary = 2274,
  larceny = 8045,
  mv_larceny = 444,
  arson = 108
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 42788,
  homicide = 3,
  rape = 17,
  robbery = 102,
  ag_assault = 93,
  burglary = 764,
  larceny = 1242,
  mv_larceny = 228,
  arson = 9
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
