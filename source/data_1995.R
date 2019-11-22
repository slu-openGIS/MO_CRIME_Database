
index <- c("Arnold", "Ballwin", "Bellefontaine Neighbors", "Belton", "Berkeley", 
           "Blue Springs", "Bridgeton", "Cape Girardeau", "Carthage", "Chesterfield", 
           "Clayton", "Columbia", "Crestwood", 
           "Creve Coeur", "Excelsior Springs", "Farmington", "Ferguson", "Florissant",
           "Fulton", "Gladstone", "Grandview", "Hannibal", "Hazelwood", 
           "Independence", "Jefferson City", "Jennings", "Joplin", "Kansas City", 
           "Kennett", "Kirksville", "Kirkwood", "Lebanon", "Lee's Summit",
           "Liberty", "Maplewood", "Marshall", "Maryland Heights", "Maryville", 
           "Mexico", "Moberly", "O'Fallon", "Overland", "Park Hills",
           "Poplar Bluff", "Raytown", "Richmond Heights", "Rolla", "St. Charles", 
           "St. Joseph", "St. Louis", "St. Peters", "Sedalia", "Sikeston", 
           "Springfield", "University City", "Warrensburg", "Washington", "Webster Groves")
year <- 1995

places %>%
  filter(NAME %in% index) %>%
  rename(name = NAME, placefp = PLACEFP) %>%
  mutate(year = rep(year, n())) %>%
  select(year, name, placefp) %>%
  arrange(name) -> placesSub

# create kansas city object
kansas_city <- tibble(
  name = "Kansas City",
  pop = NA,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = NA
)

# create st. jo object
st_jo <- tibble(
  name = "St. Joseph",
  pop = NA,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = NA
)

# create st. louis object
st_louis <- tibble(
  name = "St. Louis",
  pop = NA,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = NA
)

# create springfield object
springfield <- tibble(
  name = "Springfield",
  pop = NA,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = NA
)

# create university city object
u_city <- tibble(
  name = "University City",
  pop = NA,
  homicide = NA,
  rape = NA,
  robbery = NA,
  ag_assault = NA,
  burglary = NA,
  larceny = NA,
  mv_larceny = NA,
  arson = NA
)

# combine
data <- bind_rows(kansas_city, st_jo, st_louis, springfield, u_city)

# add place data
data <- left_join(placesSub, data, by = "name")

# clean-up enviornment
rm(placesSub, kansas_city, st_jo, st_louis, springfield, u_city)

pop <- tibble(
  name = index,
  count = c(20257, 22087, 10864, 20871, 12805,
            41287, 17931, 36249, 11158, 42666,
            13824, 74717, 11261, 
            12176, 11080, 12266, 22783, 51846,
            10572, 27916, 25594, 18261, 15929,
            112642, 37252, 16129, 43265, 445549,
            11343, 17436, 28530, 10468, 47438,
            21952, 10326, 12524, 26257, 10601,
            11320, 12690, 20235, 18474, 13203,
            17478, 30200, 10543, 14905, 56830,
            72336, 371425, 46812, 20431, 18084,
            151032, 41133, 16784, 11431, 23258)
)

pop <- left_join(placesSub, pop, by = "name") 
popTable <- bind_rows(popTable, pop)

homicide <- tibble(
  name = index,
  count = c(2, 0, 0, 1, 0,
            1, 0, 2, 0, 0,
            0, 2, 1, 
            0, 0, 0, 1, 2,
            0, 0, 1, 1, 0,
            2, 1, 1, 2, 107,
            2, 0, 1, 0, 1,
            0, 0, 0, 2, 1,
            1, 1, 1, 1, 0,
            0, 0, 3, 0, 0,
            1, 204, 0, 1, 2,
            5, 1, 1, 0, 0)
)

# homicide <- left_join(placesSub, homicide, by = "name") 

arson <- tibble(
  name = index,
  count = c(2, 0, 1, 2, 1,
            5, 0, 2, 3, 8,
            6, 26, 0,
            0, 3, 0, 2, 3,
            0, 7, 15, 16, 7,
            60, 5, 8, 14, 479,
            0, 0, 4, 1, 12,
            4, 4, 1, 0, 2,
            0, 1, 0 , 2, 1,
            11, 5, 5, 3, 30, 
            29, 769, 12, 0, 10,
            97, 20, 3, 6, 6))

arson <- left_join(placesSub, arson, by = "name") 
arsonTable <- bind_rows(arsonTable, arson)
