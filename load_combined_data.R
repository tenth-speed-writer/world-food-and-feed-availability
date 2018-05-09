source("food_feed/process.R")
source("population/process.R")
library(dplyr)

# Convert raw availability to per-capita availability
inner_join(x = food,
           y = world_pop,
           by = c(c("Area.Abbreviation" = "Country Code"),
                  c("Year" = "Year"))) %>%
  # Rename UN country abbreviation
  rename(CountryCode = Area.Abbreviation) %>%
  # Perform calculations, converting from kilotonnes to kilograms per capita
  mutate(AlcoholicBeverages = 1e6 * AlcoholicBeverages/Population,
         Beans = 1e6 * Beans/Population,
         Cereals = 1e6 * Cereals/Population,
         Coffee = 1e6 * Coffee/Population,
         Fruits = 1e6 * Fruits/Population,
         InfantFood = 1e6 * InfantFood/Population,
         Meat = 1e6 * Meat/Population,
         Nuts = 1e6 * Nuts/Population,
         Seafood = 1e6 * Seafood/Population,
         Spices = 1e6 * Spices/Population,
         Sweeteners = 1e6 * Sweeteners/Population,
         Tea = 1e6 * Tea/Population,
         Vegetables = 1e6 * Vegetables/Population) -> food_per_capita