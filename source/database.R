library(DBI)
library(dplyr)

con <- dbConnect(RSQLite::SQLite(), "my-db.sqlite")

copy_to(con, nycflights13::flights, "flights",
        temporary = FALSE, 
        indexes = list(
          c("year", "month", "day"), 
          "carrier", 
          "tailnum",
          "dest"
        )
)

flights_db <- tbl(con, "flights")

flights_db %>% select(year:day, dep_delay, arr_delay)

flights_db %>% filter(dep_delay > 240)

flights_db %>% 
  group_by(dest) %>%
  summarise(delay = mean(dep_time))

tailnum_delay_db <- flights_db %>% 
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay),
    n = n()
  ) %>% 
  arrange(desc(delay)) %>%
  filter(n > 100)

tailnum_delay_db

tailnum_delay_db %>% show_query()

tailnum_delay <- tailnum_delay_db %>% collect()

tailnum_delay
