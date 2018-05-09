# World Population Data

## Data & Origins

Here-in we have yearly population data by country provided by [The World Bank](https://data.worldbank.org/indicator/SP.POP.TOTL). This data spans the same timeframe of interest as our corresponding world food/feed availability data - 1961 through 2013.

## Cleaning & Tidying Procedures

1. Discard the leading two rows of the set
2. Apply the third row as the column names of the remainder of the table
3. Gather all yearly population count columns into Year and Population columns
4. Trim additional columns from the set, specifying Year, Population, and UN Country Code.