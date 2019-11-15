
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1940

# use index to parse places
places %>%
  filter(NAME %in% index) %>%
  rename(name = NAME, placefp = PLACEFP) %>%
  mutate(year = rep(year, n())) %>%
  select(year, name, placefp) %>%
  arrange(name) -> placesSub

# create homicide object
homicide <- tibble(
  name = index,
  count = c(40, 4, 55, 1, 1)
)

homicide <- left_join(placesSub, homicide, by = "name") 
homicideTable <- homicide

# create robbery object
robbery <- tibble(
  name = index,
  count = c(453, 26, 421, 10, 7)
)

robbery <- left_join(placesSub, robbery, by = "name") 
robberyTable <- robbery

# create aggrevated assault object
agAssault <- tibble(
  name = index,
  count = c(133, 19, 119, 3, 3)
)

agAssault <- left_join(placesSub, agAssault, by = "name") 
agAssaultTable <- agAssault

# create burlary object
burglary <- tibble(
  name = index,
  count = c(1344, 384, 1354, 265, 174)
)

burglary <- left_join(placesSub, burglary, by = "name") 
burglaryTable <- burglary

# create larceny object
larceny <- tibble(
  name = index,
  count_over50 = c(548, 78, NA, 48, 36),
  count_under50 = c(3775, 1051, 9941, 854, 255)
)

larceny <- left_join(placesSub, larceny, by = "name") 
larcenyTable <- larceny

# create auto theft object
autoTheft <- tibble(
  name = index,
  count = c(562, 156, 812, 115, 18)
)

autoTheft <- left_join(placesSub, autoTheft, by = "name") 
autoTheftTable <- autoTheft
