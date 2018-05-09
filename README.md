# Data Sourcing & Preparation

## Overview and Origins

The data in question are presented by Kaggle user Dorbicycle and - as of the time of the publishing of this document - are hosted at https://www.kaggle.com/dorbicycle/world-foodfeed-production/. These data are themselves extracted from that made public by the United Nations Food & Agriculture Organization.

As presented:

* The window of study spans, inclusively, 1961 through 2013.
* Countries which were dissolved prior to 2013 are not represented.
* Countries which were recognized subsequent to 1961 are represented from the first available year of record following their inception.

Each distinct record in the set - once rightly formatted - [represents the amount of food or feed made available for human or livestock consumption](https://www.kaggle.com/dorbicycle/world-foodfeed-production/discussion/43794), respectively, in the specified location during the specified year. These values are given in metric kilotonnes, or units of one million (1 * 10^6) kilograms.

## Values of Interest

There appear to be both general and specific categories of items presented in the data.

We shall utilize a smaller subset of item types, using summaries of staple food types and a handful of individual types of note.

## Cleaning Procedure

1. Filter by Item those categories of items which we wish to review. Hold as variables both the string values of those Items and the corresponding properly-formatted column names to which we will assign them.
2. Gather all yearly value columns (Y1961 through Y2013) into rows with a column Year containing the corresponding C.E. year (1961:2013).
3. Use select to remove redundant information such as item & area codes
4. Spread these rows by Item into columns bearing the aforementioned names using those stored values.
5. Export the results, based on Element, to food.csv and feed.csv.