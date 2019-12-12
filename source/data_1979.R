
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1979

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
  pop = 462914,
  homicide = 119,
  rape = 436,
  robbery = 2651,
  ag_assault = 2736,
  burglary = 12254,
  larceny = 20275,
  mv_larceny = 3594,
  arson = NA
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = 78541,
  homicide = 3,
  rape = 17,
  robbery = 80,
  ag_assault = 148,
  burglary = 1575,
  larceny = 3617,
  mv_larceny = 287,
  arson = NA
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = 505451,
  homicide = 265,
  rape = 555,
  robbery = 5386,
  ag_assault = 4568,
  burglary = 17263,
  larceny = 23103,
  mv_larceny = 6073,
  arson = NA
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = 136252,
  homicide = 12,
  rape = 60,
  robbery = 156,
  ag_assault = 373,
  burglary = 3034,
  larceny = 8243,
  mv_larceny = 626,
  arson = 78
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = 45155,
  homicide = 3,
  rape = 20,
  robbery = 142,
  ag_assault = 112,
  burglary = 916,
  larceny = 1244,
  mv_larceny = 161,
  arson = 33
)

# combine
data <- bind_rows(kansas_city, st_jo, st_louis, springfield, u_city)

# add place data
data <- left_join(placesSub, data, by = "name")

# clean-up enviornment
rm(placesSub, kansas_city, st_jo, st_louis, springfield, u_city)

# create population object
popTable <- subset_tables(input = data, table = "population")

# create homicide object
homicideTable <- subset_tables(input = data, table = "homicide")

# create robbery object
robberyTable <- subset_tables(input = data, table = "robbery")

# create aggrevated assault object
agAssaultTable <- subset_tables(input = data, table = "aggravated assault")

# create rape object
rapeTable <- subset_tables(input = data, table = "rape")

# create burlary object
burglaryTable <- subset_tables(input = data, table = "burglary")

# create larceny object
larcenyTable <- subset_tables(input = data, table = "larceny")

# create auto theft object
autoTheftTable <- subset_tables(input = data, table = "auto theft")

# create arson object
arsonTable <- subset_tables(input = data, table = "arson")

# clean-up enviornment
rm(index, data, year)
