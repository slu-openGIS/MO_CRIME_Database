
# connect to database
con <- dbConnect(RSQLite::SQLite(), "data/MO_CRIME_Database.sqlite")

# write homicide table
copy_to(con, popTable, "population",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
                "year", 
                "name",
                "placefp"
        )
)

# write homicide table
copy_to(con, homicideTable, "homicide",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
          "year", 
          "name",
          "placefp"
        )
)

# write rape table
copy_to(con, rapeTable, "rape",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
                "year", 
                "name",
                "placefp"
        )
)

# write robbery table
copy_to(con, robberyTable, "robbery",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
          "year", 
          "name",
          "placefp"
        )
)

# write aggrevated assault table
copy_to(con, agAssaultTable, "agAssault",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
          "year", 
          "name",
          "placefp"
        )
)

# write burglary table
copy_to(con, burglaryTable, "burglary",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
          "year", 
          "name",
          "placefp"
        )
)

# write larceny table
copy_to(con, larcenyTable, "larceny",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
          "year", 
          "name",
          "placefp"
        )
)

# write motor vehicle larceny table
copy_to(con, autoTheftTable, "autoTheft",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
          "year", 
          "name",
          "placefp"
        )
)

# write arson table
copy_to(con, arsonTable, "arson",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
                "year", 
                "name",
                "placefp"
        )
)

# write arson table
copy_to(con, rapeTable, "rape",
        temporary = FALSE,
        overwrite = TRUE,
        indexes = list(
                "year", 
                "name",
                "placefp"
        )
)

# disconnect from database
dbDisconnect(con)
rm(con)
