# how to get working directory:
getwd

# set working directory
# setwd(), put directory in parentheses

d <- read.csv("./data/tail_length.csv")
# ^ the period means start from this working directory
d

#make a new folder
dir.create("./scripts")

weight_g <- c(50, 60, 65, 82)

animals <- c("mouse", "rat", "dog")

length(weight_g)
length(animals)
str(weight_g)

# colon between numbers is a range


#stay organized ----
# put four dashes after a comment to add it as 
# a heading (right button next to source)


# change/ add to a vector
weight_g <- c(weight_g, 90)
weight_g


# challenge

num_char <- c(1,2,3, "a")
class(num_char)

num_logical <- c(1,2,3, FALSE)
class(num_logical)
?c()
# false is 0, true is 1 (in most cases)


tricky<- c(1,2,3, "4")
class(tricky)

animals <- c("mouse", "rat", "dog", "cat")
animals[2]
animals [c(2,3)]

#conditional subsetting
weight_g <- c(21, 34, 39, 54, 55)
weight_g > 50

weight_g[weight_g>50]
# would spit out all animals over 

## symbols 
# %in%
# ^ grab these values within another set of values
  
animals %in% c("rat", "cat", "dog", "duck", "goat")
# returns 4 values because we're looking if those 4 from animals
# are in the list, not vice versa

animals == c("rat", "cat", "dog", "duck")
# this means it'll look at the list and match them in the order-
# only true if they're in the same position and same value
