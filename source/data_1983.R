
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1983

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
  count = c(453128, 77627, 457262, 134883, 43294)
)

pop <- left_join(placesSub, pop, by = "name") 
popTable <- bind_rows(popTable, pop)


# create auto theft object
arson <- tibble(
  name = index,
  count = c(462, 32, 315, 59, 20)
)

arson <- left_join(placesSub, arson, by = "name") 
arsonTable <- bind_rows(arsonTable, arson)
