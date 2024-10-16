# Data Transformation with dplyr 5 queries

install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

data(package = "nycflights13")
glimpse(flights)
glimpse(airlines)

# 5 dplyr Queries
# Query 1: Find the average arrival delay for flights to Seattle (SEA)

flights %>%
  filter(dest == "SEA") %>%
  summarise(avg_arr_deley = mean(arr_delay,na.rm = T))
# This code filters the data for flights to Seattle, calculates the average arrival delay, and removes missing values (NA) using na.rm = TRUE.

# Query 2: Find the top 5 airlines with the highest average departure delay

flights %>%
  group_by(carrier) %>%
  summarise(avg_dep_deley = mean(dep_delay,na.rm = T)) %>%
  arrange(desc(avg_dep_deley)) %>%
  left_join(airlines, by = "carrier") %>%
  head(5)
# This code groups the data by carrier, calculates the average departure delay for each carrier, arranges the results in descending order of average departure delay, and finally selects the top 5 rows.

# Query 3: Count the number of flights for each month

flights %>%
group_by(month) %>%
count() %>%
arrange(n)
# This code creates a new column month from the flight_date column, groups the data by month, and counts the number of flights for each month.

# Query 4: Find the flights that were cancelled and delayed by more than 3 hours

flights %>%
  filter((is.na(dep_time)) | (dep_delay > 180) )
# This code filters the data to include flights that were cancelled (indicated by NA in dep_delay) or had a departure delay greater than 180 minutes (3 hours).

# Query 5: Calculate the average flight distance for each airline

flights %>%
  group_by(carrier) %>%
  summarise(average_flight_bycarrier = mean(distance,na.rm = TRUE)) %>%
  left_join(airlines,by = "carrier") %>%
  arrange(average_flight_bycarrier)
# This code groups the data by carrier and calculates the average flight distance for each carrier.
