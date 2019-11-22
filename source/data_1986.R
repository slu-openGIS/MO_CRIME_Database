
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1986

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
  pop = 448237,
  homicide = 116,
  rape = 460,
  robbery = 3442,
  ag_assault = 5655,
  burglary = 13525,
  larceny = 24375,
  mv_larceny = 6805,
  arson = 554
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 75732,
  homicide = 3,
  rape = 15,
  robbery = 53,
  ag_assault = 223,
  burglary = 1319,
  larceny = 2536,
  mv_larceny = 193,
  arson = 77
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 434298,
  homicide = 195,
  rape = 373,
  robbery = 3326,
  ag_assault = 5995,
  burglary = 12523,
  larceny = 21641,
  mv_larceny = 7135,
  arson = 533
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 138534,
  homicide = 5,
  rape = 40,
  robbery = 133,
  ag_assault = 199,
  burglary = 2716,
  larceny = 7951,
  mv_larceny = 426,
  arson = 65
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 43429,
  homicide = 7,
  rape = 18,
  robbery = 82,
  ag_assault = 123,
  burglary = 749,
  larceny = 1230,
  mv_larceny = 257,
  arson = 23
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
