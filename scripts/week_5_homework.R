#This week’s questions will have us practicing pivots and conditional statements.
library(tidyverse)
# Create a tibble named surveys from the portal_data_joined.csv file. 
surveys <- read.csv("data/portal_data_joined.csv")

# Then manipulate surveys to create a new dataframe called surveys_wide with a 
#column for genus and a column named after every plot type, with each of these 
#columns containing the mean hindfoot length of animals in that plot type and 
#genus. So every row has a genus and then a mean hindfoot length value for 
#every plot type. The dataframe should be sorted by values in the Control plot 
#type column. This question will involve quite a few of the functions you’ve 
#used so far, and it may be useful to sketch out the steps to get to the final 
#result.

surveys2<- surveys%>%
  filter(!is.na(hindfoot_length))%>%
  group_by(genus, plot_type)%>%
  summarize(mean_hindfoot=mean(hindfoot_length))

surveys_wide <- surveys2%>%
  pivot_wider(id_cols = 'genus', names_from = 'plot_type',
              values_from = 'mean_hindfoot')

  
# Using the original surveys dataframe, use the two different functions we laid 
#out for conditional statements, ifelse() and case_when(), to calculate a new 
#weight category variable called weight_cat. For this variable, define the 
#rodent weight into three categories, where “small” is less than or equal to 
#the 1st quartile of weight distribution, “medium” is between (but not 
#inclusive) the 1st and 3rd quartile, and “large” is any weight greater than or 
#equal to the 3rd quartile. (Hint: the summary() function on a column summarizes 
#the distribution). For ifelse() and case_when(), compare what happens to the 
#weight values of NA, depending on how you specify your arguments.
surveys$weight
summary(surveys$weight)

surveys_weight <- surveys %>%
  mutate(weight_cat = case_when(weight <= 20 ~ "Small",
                                weight > 20 & weight < 48 ~ "Medium",
                                weight>=48 ~ "Large"))

surveys_weight <- surveys %>%
  mutate(weight_cat = ifelse(weight <= 20, "Small", 
                             ifelse(weight >20 & weight <48, "Medium", "Large")))
  ## did not get this one at first-- note that you can nest the ifelse function

#BONUS: How might you soft code the values (i.e. not type them in manually) of 
#the 1st and 3rd quartile into your conditional statements in question 2?

#in theory: you can subset the sections surveys$weight summary to be the first or third quartile
# allows it to automaticaly update if data changes & quartile changes
#will work on this later