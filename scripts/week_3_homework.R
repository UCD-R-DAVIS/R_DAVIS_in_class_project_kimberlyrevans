# load in data ----
surveys <- read.csv("data/portal_data_joined.csv")
## no spaces in between /, only quotes at beginning & end of directory

# new dataframe----
colnames(surveys)
surveys_base <- surveys[1:5000, c(6,9,13)]


# convert species id & plot type to factors
?as.factor()
as.factor(surveys_base$species_id)
as.factor(surveys_base$plot_type)
# doesn't actually connect it to df though until assigned
surveys_base$species_id <- factor(surveys_base$species_id)
class(surveys_base$species_id) 
surveys_base$plot_type <- factor(surveys_base$plot_type)
class(surveys_base$plot_type)

#remove NAs----
surveys_base <- surveys_base[!is.na(surveys_base[,2]), ]
# can also use the complete cases function

# why use factors----
# factors are hierarchical, while characters are not. With factors,
# we can easily reorder data

# example of when factor would be preferred: examining growth data with 
#3 different growth categories (low, medium, & high).

# weights >150kg
challenge_base <- surveys_base[surveys_base[,2]>150,]
# question; why do we need the second comma?