# function for subsetting crime tables
subset_tables <- function(input, update, table){
  
  # create count_var value
  if (table == "population"){
    count_var <- "pop"
  } else if (table == "homicide"){
    count_var <- "homicide"
  } else if (table == "robbery"){
    count_var <- "robbery"
  } else if (table == "aggravated assault"){
    count_var <- "ag_assault"
  } else if (table == "rape"){
    count_var <- "rape"
  } else if (table == "burglary"){
    count_var <- "burglary"
  } else if (table == "larceny"){
    count_var <- "larceny"
  } else if (table == "auto theft"){
    count_var <- "mv_larceny"
  } else if (table == "arson"){
    count_var <- "arson"
  }
  
  # update input object
  modified_input <- input[c("year", "name", "placefp", count_var)]
  modified_input <- rename(modified_input, count = !!count_var)
  
  # create output object
  if (missing(update) == TRUE){
    out <- modified_input
  } else if (missing(update) == FALSE){
    out <- bind_rows(update, modified_input) 
  }

  # return output
  return(out)
  
}
