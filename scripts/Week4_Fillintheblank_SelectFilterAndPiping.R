#learning dplyr and tidyr: select, filter, and pipes
#only do this once ever:
install.packages(
  #We've learned bracket subsetting
  #It can be hard to read and prone to error
  #dplyr is great for data table manipulation!
  #tidyr helps you switch between data formats
  
  #Packages in R are collections of additional functions
  #tidyverse is an "umbrella package" that
  #includes several packages we'll use this quarter:
  #tidyr, dplyr, ggplot2, tibble, etc.
  
  #benefits of tidyverse
  #1. Predictable results (base R functionality can vary by data type) 
  #2. Good for new learners, because syntax is consistent. 
  #3. Avoids hidden arguments and default settings of base R functions
  
  #To load the package type:
  library(tidyverse)
  library(dplyr)
  #now let's work with a survey dataset
  surveys <- read_csv("data/portal_data_joined.csv")
  
  
  str(surveys)
   ## str is structure     
        
        
        
        
        
        
        
#select columns
month_day_year <- select(surveys, month, day, year)
          
#filtering by equals
year_1981 <- filter(surveys, year== 1981)
            
year_1981_baser <- surveys[surveys$year==1981,]#calls out row

identical(year_1981, year_1981_baser)

#filtering by range
the80s<- surveys[surveys$year %in% 1981:1983,]
the80sstudy<- filter(surveys, year %in% 1981:1983)
#5033 results in both
                   
                   
#review: why should you NEVER do:
the80srecycle<- filter(surveys, year == c(1981:1983))
#1685 results
                          
#This recycles the vector 
#(index-matching, not bucket-matching)
#If you ever really need to do that for some reason,
#comment it ~very~ clearly and explain why you're 
#recycling!
                          
#filtering by multiple conditions
bigfoot_with_weight <- filter(surveys, hindfoot_length >40 & !is.na(weight))
                                                      
#multi-step process
small_animals <- filter(surveys, weight<5)
  
#this is slightly dangerous because you have to remember 
#to select from small_animals, not surveys in the next step
small_animal_ids <- select(small_animals, record_id, plot_id)
                                                                                                           
#same process, using nested functions
small_animal_ids <- select(filter(surveys, weight<5)
                             
                                                                                                             
#same process, using a pipe
#Cmd Shift M
#or |>
#note our select function no longer explicitly calls the tibble
#as its first element
small_animal_ids <- select(filter(surveys, weight < 5), record_id, plot_id, species_id)

                                                                                                                 
#same as
small_animal_ids <- surveys %>% filter(., weight<5)
  
                                                                                                                   
                                                                                                                   
#how to do line breaks with pipes
small_animals_id<- surveys %>% filter(weight>5)%>%
  select(record_id, plot_id, species_id)
                                                                                                                     
#good:
surveys %>% 
filter(month==1)
                                                                                                                     
#not good:
surveys 
%>%filter(month==1)                                                                                                                   %>% filter(month==1)
#what happened here?

#line break rules: after open parenthesis, pipe,
#commas, 
#or anything that shows the line is not complete yet



#check out cute_rodent_photos!
#will be updated throughout the quarter
#as a bonus for checking out these videos
#and visiting the code demos on my repository


#one final review of an important concept we learned last week
#applied to the tidyverse

mini <- surveys[190:209,]
table(mini$species_id)
#how many rows have a species ID that's either DM or NL?
nrow(mini)


test<- mini %>% filter(species_id %in% c("DM", "NL"))
nrow(test)



                                                                                                                 