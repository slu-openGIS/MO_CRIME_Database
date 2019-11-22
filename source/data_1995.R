
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1995

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
  pop = 445549,
  homicide = 107,
  rape = 470,
  robbery = 3346,
  ag_assault = 5811,
  burglary = 9748,
  larceny = 26301,
  mv_larceny = 6792,
  arson = 479
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 72336,
  homicide = 1,
  rape = 9,
  robbery = 51,
  ag_assault = 191,
  burglary = 738,
  larceny = 3805,
  mv_larceny = 170,
  arson = 29
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 371425,
  homicide = 204,
  rape = 273,
  robbery = 5136,
  ag_assault = 6839,
  burglary = 10692,
  larceny = 28587,
  mv_larceny = 8005,
  arson = 769
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 151032,
  homicide = 5,
  rape = 82,
  robbery = 145,
  ag_assault = 597,
  burglary = 2123,
  larceny = 8440,
  mv_larceny = 700,
  arson = 97
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 41133,
  homicide = 1,
  rape = 16,
  robbery = 129,
  ag_assault = 101,
  burglary = 464,
  larceny = 1697,
  mv_larceny = 341,
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
