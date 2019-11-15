
# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")
year <- 1981

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
  count = c(450211, 77128, 454166, 134016, 43016)
)

pop <- left_join(placesSub, pop, by = "name") 
popTable <- bind_rows(popTable, pop)

# create auto theft object
arson <- tibble(
  name = index,
  count = c(513, 0, 443, 94, 0)
)

arson <- left_join(placesSub, arson, by = "name") 
arsonTable <- bind_rows(arsonTable, arson)
