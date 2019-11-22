# Enter 1998 data based on pdf in `data/raw`

# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1998

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
  pop = 447730,
  homicide = 130,
  rape = 382,
  robbery = 2661,
  ag_assault = 5189,
  burglary = 10504,
  larceny = 27473,
  mv_larceny = 7388,
  arson = 538
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 70608,
  homicide = 3,
  rape = 13,
  robbery = 34,
  ag_assault = 179,
  burglary = 733,
  larceny = 3641,
  mv_larceny = 304,
  arson = 12
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 344153,
  homicide = 113,
  rape = 168,
  robbery = 3500,
  ag_assault = 5067,
  burglary = 9042,
  larceny = 26893,
  mv_larceny = 6676,
  arson = 661
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 145251,
  homicide = 7,
  rape = 56,
  robbery = 152,
  ag_assault = 521,
  burglary = 1930,
  larceny = 7981,
  mv_larceny = 666,
  arson = 82
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 33303,
  homicide = 3,
  rape = 8,
  robbery = 100,
  ag_assault = 29,
  burglary = 428,
  larceny = 1607,
  mv_larceny = 169,
  arson = 10
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
