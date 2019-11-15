
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1943

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
  count = c(27, 6, 56, 0, 0)
)

homicide <- left_join(placesSub, homicide, by = "name") 
homicideTable <- bind_rows(homicideTable, homicide)

# create robbery object
robbery <- tibble(
  name = index,
  count = c(215, 15, 319, 3, 5)
)

robbery <- left_join(placesSub, robbery, by = "name") 
robberyTable <- bind_rows(robberyTable, robbery)

# create aggrevated assault object
agAssault <- tibble(
  name = index,
  count = c(676, 12, 692, 8, 1)
)

agAssault <- left_join(placesSub, agAssault, by = "name") 
agAssaultTable <- bind_rows(agAssaultTable, agAssault)

# create burlary object
burglary <- tibble(
  name = index,
  count = c(676, 211, 2229, 200, 124)
)

burglary <- left_join(placesSub, burglary, by = "name") 
burglaryTable <- bind_rows(burglaryTable, burglary)

# create burlary object
larceny <- tibble(
  name = index,
  count_over50 = c(387, 62, 644, 41, 41),
  count_under50 = c(2162, NA, 5629, 742, 198)
)

larceny <- left_join(placesSub, larceny, by = "name") 
larcenyTable <- bind_rows(larcenyTable, larceny)

# create burlary object
autoTheft <- tibble(
  name = index,
  count = c(346, 83, 1122, 56, 25)
)

autoTheft <- left_join(placesSub, autoTheft, by = "name") 
autoTheftTable <- bind_rows(autoTheftTable, autoTheft)
