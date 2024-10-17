# Homework 3 Review -----
#Load your survey data frame with the read.csv() function. Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. Have this data frame only be the first 5,000 rows. 


#Convert both species_id and plot_type to factors. Remove all rows where there is an NA in the weight column. 


#Explore these variables and try to explain why a factor is different from a character. Why might we want to use factors? Can you think of any examples?

#CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.















# Data Manipulation Part 1b ----
# Goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)


# Adding a new column
# mutate: adds a new column
surveys <- surveys %>%
  mutate(weight_kg = weight/1000)

str(surveys)
# Add other columns
surveys <- surveys %>%
  mutate(weight_kg = weight/1000,
         weight_kg2= weight_kg*2)

surveys$weight_kg2 = as.character(surveys$weight_kg2)
# Filter out the NA's
average_weight <- surveys %>%
  mutate(weight_kg = weight/1000,
         weight_kg2= weight_kg*2)%>%
  filter(!is.na(weight))%>%
  mutate(mean_weight= mean(weight))

str(surveys)
# Group_by and summarize ----
# A lot of data manipulation requires us to split the data into groups, apply some analysis to each group, and then combine the results
# group_by and summarize functions are often used together to do this
# group_by works for columns with categorical variables 
# we can calculate mean by certain groups
df<- surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) 
table(df$mean_weight)

# multiple groups
df<- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
summary(df)

# remove na's

# sort/arrange order a certain way
df<- surveys %>%
  group_by(sex, species_id) %>%
  filter(sex != "")%>%
  summarize(mean_weight = mean(weight, na.rm=T))%>%
  arrange(mean_weight)

df<- surveys %>%
  group_by(sex, species_id) %>%
  filter(sex != "")%>%
  summarize(mean_weight = mean(weight, na.rm=T))%>%
  arrange(-mean_weight) # organizes by descending order

# Challenge
#What was the weight of the heaviest animal measured in each year? Return a table with three columns: year, weight of the heaviest animal in grams, and weight in kilograms, arranged (arrange()) in descending order, from heaviest to lightest. (This table should have 26 rows, one for each year)
df<- surveys%>%
  select(year, weight, record_id)%>%
  group_by(year)%>%
  filter(!is.na(weight))%>%
  mutate(weight_kg = weight/1000)%>%
  mutate(max_weight =max(weight))%>%
  summarize(max_weight_g = max(weight),
            max_weight_kg = max(weight_kg))
  

str(df)
  
  

#Try out a new function, count(). Group the data by sex and pipe the grouped data into the count() function. How could you get the same result using group_by() and summarize()? Hint: see ?n.

  
