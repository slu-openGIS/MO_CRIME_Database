
# create index of included cities
index <- c("Joplin", "Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1941

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
  count = c(2, 25, 4, 66, 3, 1)
)

homicide <- left_join(placesSub, homicide, by = "name") 
homicideTable <- bind_rows(homicideTable, homicide)

# create robbery object
robbery <- tibble(
  name = index,
  count = c(44, 258, 21, 457, 16, 8)
)

robbery <- left_join(placesSub, robbery, by = "name") 
robberyTable <- bind_rows(robberyTable, robbery)

# create aggrevated assault object
agAssault <- tibble(
  name = index,
  count = c(15, 40, 16, 628, 7, 0)
)

agAssault <- left_join(placesSub, agAssault, by = "name") 
agAssaultTable <- bind_rows(agAssaultTable, agAssault)

# create burlary object
burglary <- tibble(
  name = index,
  count = c(179, 691, 224, 3042, 249, 138)
)

burglary <- left_join(placesSub, burglary, by = "name") 
burglaryTable <- bind_rows(burglaryTable, burglary)

# create larceny object
larceny <- tibble(
  name = index,
  count_over50 = c(38, 306, 54, NA, 50, 58),
  count_under50 = c(523, 3101, 1001, 7426, 894, 255)
)

larceny <- left_join(placesSub, larceny, by = "name") 
larcenyTable <- bind_rows(larcenyTable, larceny)

# create auto theft object
autoTheft <- tibble(
  name = index,
  count = c(120, 383, 129, 1061, 88, 23)
)

autoTheft <- left_join(placesSub, autoTheft, by = "name") 
autoTheftTable <- bind_rows(autoTheftTable, autoTheft)
