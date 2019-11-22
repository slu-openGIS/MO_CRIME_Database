
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1991

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
  pop = 438188,
  homicide = 135,
  rape = 477,
  robbery = 4955,
  ag_assault = 6846,
  burglary = 13008,
  larceny = 22527,
  mv_larceny = 9886,
  arson = 540
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 72426,
  homicide = 2,
  rape = 33,
  robbery = 35,
  ag_assault = 276,
  burglary = 821,
  larceny = 3178,
  mv_larceny = 262,
  arson = 22
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 399858,
  homicide = 260,
  rape = 342,
  robbery = 5294,
  ag_assault = 8180,
  burglary = 13396,
  larceny = 27381,
  mv_larceny = 9250,
  arson = 867
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 141617,
  homicide = 4,
  rape = 54,
  robbery = 151,
  ag_assault = 426,
  burglary = 2560,
  larceny = 8275,
  mv_larceny = 435,
  arson = 95
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 40407,
  homicide = 2,
  rape = 14,
  robbery = 118,
  ag_assault = 106,
  burglary = 779,
  larceny = 1333,
  mv_larceny = 378,
  arson = 22
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
