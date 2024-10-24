# Conditional statements ---- 
## ifelse: run a test, if true do this, if false do this other thing
## case_when: basically multiple ifelse statements
# can be helpful to write "psuedo-code" first which basically is writing out what steps you want to take & then do the actual coding
# great way to classify and reclassify data

## Load library and data ----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

## ifelse() ----
# from base R
# ifelse(test, what to do if yes/true, what to do if no/false)
## if yes or no are too short, their elements are recycled
## missing values in test give missing values in the result
## ifelse() strips attributes: this is important when working with Dates and factors
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < mean
                               (surveys$hindfoot_length, na.rm = T), yes
                               ='small', no='big')

head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)
summary(surveys$hindfoot_length)
surveys$record_id
unique(surveys$hindfoot_length)

## case_when() ----
# GREAT helpfile with examples!
# from tidyverse so have to use within mutate()
# useful if you have multiple tests
## each case evaluated sequentially & first match determines corresponding value in the output vector
## if no cases match then values go into the "else" category

# case_when() equivalent of what we wrote in the ifelse function
surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big", 
    TRUE ~ "small"
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()

# if_else can handle NAs, case_when does not handle as well
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length>31.5 ~ 'big',
    hindfoot_length >29 ~ 'medium',
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ 'small'
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head(n=10)
# the 'TRUE' is basically the catch all;
# code goes from top to bottom for each line
# if >31.5, labeled big. if not, goes down to see if it is > 29.
# eventually, if it is not "caught" by any of these conditions, 
# we can just use TRUE as the name

# if no "else" category specified, then the output will be NA


# lots of other ways to specify cases in case_when and ifelse
surveys %>%
  mutate(favorites = case_when(
    year < 1990 & hindfoot_length > 29.29 ~ "number1", 
    species_id %in% c("NL", "DM", "PF", "PE") ~ "number2",
    month == 4 ~ "number3",
    TRUE ~ "other"
  )) %>%
  group_by(favorites) %>%
  tally()

#case_when is hierarchical compared to if_else
#if you put a range that conflicts with another later down, it keeps the og assignment
