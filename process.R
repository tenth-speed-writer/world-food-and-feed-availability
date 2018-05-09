library("dplyr")
library("tidyr")

raw <- read.csv(file = "FAO.csv",
                sep = ",",
                stringsAsFactors = F)
(function() {
  # First, get a list of the names of columns we'll be gathering from
  year_column_names <- sapply(
    X = 1961:2013,
    FUN = function(year) {
      paste("Y", year,
            sep = "")
    }
  )
  
  # A function to swap those strings to integer values after they're rearranged.
  year_string_to_integer <- function(year) {
    # They're in the format Y19XX. Remove the Y.
    as.integer(substr(year,
                      start = 2,
                      stop = 5))
  }
  
  # The specific item values which we wish to gather
  item_values <-
    c(
      "Meat", "Fish, Seafood", "Vegetables", "Fruits - Excluding Wine",
      "Cereals - Excluding Beer", "Beans", "Nuts and products", "Infant food",
      "Coffee and products", "Tea (including mate)", "Sugar & Sweeteners", "Spices",
      "Alcoholic Beverages"
    )
  
  # Make sure item_values and column_names correspond. The former are the
  # desired item-specific column names and the latter are the values as they're
  # entered in the Item column of the data.
  column_names <-
    c(
      "Meat", "Seafood", "Vegetables", "Fruits", "Cereals", "Beans", "Nuts",
      "InfantFood", "Coffee", "Tea", "Sweeteners", "Spices",
      "AlcoholicBeverages"
    )
  item_values <-
    c(
      "Meat", "Fish, Seafood", "Vegetables", "Fruits - Excluding Wine",
      "Cereals - Excluding Beer", "Beans", "Nuts and products", "Infant food",
      "Coffee and products", "Tea (including mate)", "Sugar & Sweeteners", "Spices",
      "Alcoholic Beverages"
    )
  
  # A function to convert the item names as they appear in the data into strings
  # more appropriate for use as column names.
  convert_item_values <- function(item) {
    # The original value is the index. The desired value is the... well, value.
    names(column_names) <- item_values
    
    # So we just select by index using the original values, and get the desired ones.
    column_names[item]
  }
  
  desired_columns <- c("Year", "Area", "Area.Abbreviation", "Item", "Element",
                       "latitude", "longitude", "Amount")
  
  # Process and return tidy data
  raw %>%
    # Filter by desired item types
    filter(Item %in% item_values) %>%
    # Gather yearly value columns
    gather(key = "Year",
           value = "Amount",
           ... = year_column_names) %>%
    # Convert those year strings back to numbers
    mutate(Year = year_string_to_integer(Year)) %>%
    # Trim unneded/redundant identifying values
    select(desired_columns) %>%
    # Correct Item values to column-name-appropriate alternatives
    mutate(Item = convert_item_values(Item)) %>%
    # Spread by Item
    spread(Item, Amount)
})() -> food_feed_availability

food_feed_availability %>%
  filter(Element == "Food") %>%
  select(-one_of("Element")) -> food

food_feed_availability %>%
  filter(Element == "Feed") %>%
  select(-one_of("Element")) -> feed

write.csv(x = food,
          file = "food.csv")

write.csv(x = "feed",
          file = "feed.csv")