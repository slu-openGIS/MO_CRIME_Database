
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1942

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
  count = c(34, 4, 62, 0, 0)
)

homicide <- left_join(placesSub, homicide, by = "name") 
homicideTable <- bind_rows(homicideTable, homicide)

# create robbery object
robbery <- tibble(
  name = index,
  count = c(171, 16, 349, 2, 7)
)

robbery <- left_join(placesSub, robbery, by = "name") 
robberyTable <- bind_rows(robberyTable, robbery)

# create aggrevated assault object
agAssault <- tibble(
  name = index,
  count = c(3114, 14, 1116, 6, 1)
)

agAssault <- left_join(placesSub, agAssault, by = "name") 
agAssaultTable <- bind_rows(agAssaultTable, agAssault)

# create burlary object
burglary <- tibble(
  name = index,
  count = c(498, 146, 2409, 158, 112)
)

burglary <- left_join(placesSub, burglary, by = "name") 
burglaryTable <- bind_rows(burglaryTable, burglary)

# create burlary object
larceny <- tibble(
  name = index,
  count_over50 = c(266, 49, NA, 44, 45),
  count_under50 = c(2220, 750, 8553, 872, 223)
)

larceny <- left_join(placesSub, larceny, by = "name") 
larcenyTable <- bind_rows(larcenyTable, larceny)

# create burlary object
autoTheft <- tibble(
  name = index,
  count = c(324, 76, 1096, 67, 22)
)

autoTheft <- left_join(placesSub, autoTheft, by = "name") 
autoTheftTable <- bind_rows(autoTheftTable, autoTheft)
