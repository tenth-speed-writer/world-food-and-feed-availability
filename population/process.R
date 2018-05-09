library(dplyr)
library(tidyr)

(function() {
  # The raw data has been pulled to correspond with the world food availability
  # data - it is reported annually, with country codes, from 1961 through 2013.
  raw <- read.csv("population/data/API_SP.POP.TOTL_DS2_en_csv_v2.csv",
                  header = F,
                  stringsAsFactors = F)
  
  # Drop the leading two rows of the document and treat the third as the header
  trimmed <- raw[3:dim(raw)[1], ]
  colnames(trimmed) <- trimmed[1, ]
  trimmed <- trimmed[2:dim(trimmed)[1], ]
  
  # We'll gather across the columns named for years 1961 to 2013
  cols_to_gather <- as.character(1961:2013)
  
  trimmed %>%
    # Gather yearly data
    gather(key = "Year",
           value = "Population",
           ... = cols_to_gather) %>%
    # Explicitly typecast columns
    mutate(Year = as.integer(Year),
           Population = as.integer(Population)) %>%
    # Specify desired columns
    select("Country Code", "Year", "Population")
})() -> world_pop

write.csv(x = world_pop,
          file = "world_pop.csv",
          row.names = F)