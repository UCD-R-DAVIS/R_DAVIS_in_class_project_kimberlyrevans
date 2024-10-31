library(tidyverse)

surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

# these are two different ways of doing the same thing
head(surveys_complete %>% count(year,species_id))
head(surveys_complete %>% group_by(year,species_id) %>% tally())

yearly_counts <- surveys_complete %>% count(year,species_id)

head(yearly_counts)

ggplot(data = yearly_counts,mapping = aes(x = year, y = n)) +
  geom_point()

ggplot(data = yearly_counts,mapping = aes(x = year, y= n)) +
  geom_line()

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line()+
  geom_point()


ggplot(data = yearly_counts,mapping = aes(x = year, y= n, colour = species_id)) +
         geom_line()
# too mant plots on here

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id, scales='free_y') #free y = scales are all different

#we're saying map panels across the value of species id

# fucked up this code but it's pretty close
ggplot(data=yearly_counts[yearly_counts$species_id%in%c('BA', 'DM','DO')], 
       mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)+
  scale_y_continuous(name='obs', breaks= seq(0,600,100))

ggplot(data=yearly_counts, 
       mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)+
  scale_y_continuous(name='obs', breaks= seq(0,600,100))+
  theme_dark()
#from 0 - 600, intervals of 100

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id,scales = 'free')

install.packages('ggthemes')
install.packages('tigris')
install.packages('sf')
library(ggthemes)
library(tigris)
library(sf)

ca_counties = tigris::counties(state = 'CA', class = 'sf', year='2024')
ca_counties
ggplot(data=ca_counties)+geom_sf(aes(fill= AWATER)+theme_map())
                                 