
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1987

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
  pop = 444382,
  homicide = 131,
  rape = 486,
  robbery = 3279,
  ag_assault = 4527,
  burglary = 13767,
  larceny = 24224,
  mv_larceny = 6363,
  arson = 553
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 74611,
  homicide = 1,
  rape = 23,
  robbery = 47,
  ag_assault = 225,
  burglary = 1265,
  larceny = 3268,
  mv_larceny = 148,
  arson = 0
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 429414,
  homicide = 153,
  rape = 332,
  robbery = 3296,
  ag_assault = 5997,
  burglary = 11796,
  larceny = 25157,
  mv_larceny = 7677,
  arson = 563
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 140378,
  homicide = 1,
  rape = 41,
  robbery = 157,
  ag_assault = 240,
  burglary = 2528,
  larceny = 6849,
  mv_larceny = 427,
  arson = 69
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 42579,
  homicide = 1,
  rape = 15,
  robbery = 96,
  ag_assault = 70,
  burglary = 684,
  larceny = 1281,
  mv_larceny = 237,
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
