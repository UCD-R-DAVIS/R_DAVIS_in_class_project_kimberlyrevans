# data types ----
## lists
c(4,6,"dog")
a <-list(4,6,"dog")
# the list creates different vectors, can have different data types
str(a) # info about the data


letters
df <- data.frame(letters)
# turns long data into tall data frame (more columns than rows)

length(df)  # doesn;t work the best here
dim(df)
nrow(df)

#factors
animals <- factor(c("duck", "duck", "goose", "goose"))
animals #organizes levels by alphabet (most of the time)

class(animals)
levels(animals)
nlevels(animals) #how many levels

animals <- factor(x = animals, levels = c("goose", "pigs", "duck"))
# rearrange how the factors are ordered, not by alphabet anymore
levels(animals)

year<- factor(c(1978, 1980, 1934, 1979))
year
class(year)
as.numeric(year)
mean(as.numeric(year))
# as.numeric represents the order of the levels, not # itself

# how to hack it to keep years as year
as.numeric(as.character(year))
# does not keep customization of levels, though

# spreadsheet----
?read.csv
# sep = separation value, csv = ","
surveys <- read.csv("data/portal_data_joined.csv")
nrow(surveys)
ncol(surveys)
dim(surveys)
str(surveys)


summary(surveys)
# creates a summary of each column / variable
# numeric summary, not much info given on character variables
?summary
summary.data.frame(surveys)
# aka, summary is same as summary.data.frame when used on data frame

surveys[1:5,] # rows 1-5, all columns
surveys[,1:5] # all rows, columns 1-5
surveys[1,5] # specifies the row and column
surveys[,1] # every value from the first column of surveys

dim(surveys[,1:5]) # how many rows and columns in subsetted data
dim(surveys[1]) #assumed you want all rows, column 1
head(surveys, 1) # first row
surveys[c('record_id', 'year', 'day')]
tail(surveys, 1) # last row


head(surveys["genus"]) #give me the row in the df
head(surveys[["genus"]]) # give me the vector from df


head(surveys[ ,'genus'])
surveys$genus # give me the column named genus
surveys$hindfoot_length
# $ can only select one thing at a time
# only works if you have the part of the list named
# does not work for rows, only column operator

# [] open an indexing fucntion

class(surveys$hindfoot_length)
# integer

library(tidyverse)
# includes packages: dplyr, readr, forcats, stringr,
# ggplot2, tibble, lubridate, tidyr, and purrr

t_surveys <- read_csv("data/portal_data_joined.csv")
class(t_surveys)
t_surveys
# tibble prints df that doesnt print the entire thing
# in your dataframe (similar to head function)

