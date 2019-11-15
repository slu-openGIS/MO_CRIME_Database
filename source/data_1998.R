# Enter 1998 data based on pdf in `data/raw`

# define year
year <- 1998

# create index of included cities
index <- c("Kansas City", "St. Joseph", "St. Louis", "Springfield", "University City")

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
  count = c(447730, 70608, 344153, 145251, 33303)
)

pop <- left_join(placesSub, pop, by = "name") 
popTable <- bind_rows(popTable, pop)

# create auto theft object
arson <- tibble(
  name = index,
  count = c(538, 12, 661, 82, 10)
)

arson <- left_join(placesSub, arson, by = "name") 
arsonTable <- bind_rows(arsonTable, arson)
