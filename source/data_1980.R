
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

# create population object
pop <- tibble(
  name = index,
  count = c(446865, 76555, 450790, 133019, 42696)
)

pop <- left_join(placesSub, pop, by = "name") 
popTable <- pop

# create homicide object
homicide <- tibble(
  name = index,
  count = c(132, NA, 225, 6, 5)
)

homicide <- left_join(placesSub, homicide, by = "name") 
homicideTable <- bind_rows(homicideTable, homicide)

# create rape object
rape <- tibble(
  name = index,
  count = c(518, NA, 392, 63, 18)
)

rape <- left_join(placesSub, rape, by = "name") 
rapeTable <- rape

# create robbery object
robbery <- tibble(
  name = index,
  count = c(2889, NA, 5938, 112, 134)
)

robbery <- left_join(placesSub, robbery, by = "name") 
robberyTable <- bind_rows(robberyTable, robbery)

# create aggrevated assault object
agAssault <- tibble(
  name = index,
  count = c(3474, NA, 4428, 246, 110)
)

agAssault <- left_join(placesSub, agAssault, by = "name") 
agAssaultTable <- bind_rows(agAssaultTable, agAssault)

# create burlary object
burglary <- tibble(
  name = index,
  count = c(15210, NA, 20184, 3488, 1193)
)

burglary <- left_join(placesSub, burglary, by = "name") 
burglaryTable <- bind_rows(burglaryTable, burglary)

# create larceny object
larceny <- tibble(
  name = index,
  count = c(23231, NA, 27043, 9035, 1709)
)

larceny <- left_join(placesSub, larceny, by = "name") 
larcenyTable <- bind_rows(larcenyTable, larceny)

# create auto theft object
autoTheft <- tibble(
  name = index,
  count = c(3820, NA, 6421, 522, 188)
)

autoTheft <- left_join(placesSub, autoTheft, by = "name") 
autoTheftTable <- bind_rows(autoTheftTable, autoTheft)

# create auto theft object
arson <- tibble(
  name = index,
  count = c(3820, NA, 450, 89, 15)
)

arson <- left_join(placesSub, arson, by = "name") 
arsonTable <- arson
