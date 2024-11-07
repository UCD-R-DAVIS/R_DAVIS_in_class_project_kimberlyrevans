library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

#1. First calculate mean life expectancy on each continent. Then create a plot 
#that shows how life expectancy has changed over time in each continent. Try to 
#do this all in one step using pipes! (aka, try not to create intermediate 
#dataframes)
p_life_exp<- gapminder%>%
  group_by(continent, year)%>%
  summarise(avgexp = mean(lifeExp))%>%
  ggplot()+
  geom_line(aes(x=year, y= avgexp, color= continent))



#2. Look at the following code and answer the following questions. What do you 
#think the scale_x_log10() line of code is achieving? What about the 
#geom_smooth() line of code?

# scale_x_log10() puts the x axis on a logarithmic scale
# #geom_smooth averages the points to show trends + adds standard error bounds



#Challenge! Modify the above code to size the points in proportion to the 
#population of the country. Hint: Are you translating data to a visual feature 
#of the plot?

# in the geom_point line, you could add in the "size = pop" 



#3. Create a boxplot that shows the life expectancy for Brazil, China, El 
#Salvador, Niger, and the United States, with the data points in the backgroud 
#using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” 
#and title the plot “Life Expectancy of Five Countries”.

p_lifeexp2<- gapminder%>%
  filter(country %in% c("Brazil", "China", "El Salvador", "Niger", "United States"))%>%
  group_by(country)%>%
  ggplot()+
  geom_jitter(aes(x=country, y=lifeExp, color= country))+
  geom_boxplot(aes(x=country, y=lifeExp, color= country), alpha=0.3)+
  xlab("Country")+
  ylab("Life Expectancy")+
  ggtitle("Life Expectancy of 5 Countries")
# == instead of %in% means that we are saying we want a row with all of these, not just one of them
# we only want any of these to appear, not all, so we used %in%


# notes:

# |> is a pipe that can be used without loading tidyverse