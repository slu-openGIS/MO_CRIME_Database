
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1980

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
  pop = 446865,
  homicide = 132,
  rape = 518,
  robbery = 2889,
  ag_assault = 3474,
  burglary = 15210,
  larceny = 23231,
  mv_larceny = 3820,
  arson = NA
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 76555,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = NA
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 450790,
  homicide = 225,
  rape = 392,
  robbery = 5938,
  ag_assault = 4428,
  burglary = 20184,
  larceny = 27043,
  mv_larceny = 6421,
  arson = 450
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 133019,
  homicide = 6,
  rape = 63,
  robbery = 112,
  ag_assault = 246,
  burglary = 3488,
  larceny = 9035,
  mv_larceny = 522,
  arson = 89
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 42696,
  homicide = 5,
  rape = 18,
  robbery = 134,
  ag_assault = 110,
  burglary = 1193,
  larceny = 1709,
  mv_larceny = 188,
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

