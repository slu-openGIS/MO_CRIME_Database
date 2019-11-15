# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1996

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
  count = c(448474, NA, 374041, 152024, 41403)
)

pop <- left_join(placesSub, pop, by = "name") 
popTable <- bind_rows(popTable, pop)


# create auto theft object
arson <- tibble(
  name = index,
  count = c(426, NA, 784, 103, 8)
)

arson <- left_join(placesSub, arson, by = "name") 
arsonTable <- bind_rows(arsonTable, arson)