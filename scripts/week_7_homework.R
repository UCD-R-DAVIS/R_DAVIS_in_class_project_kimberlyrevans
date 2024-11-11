library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")


df<- gapminder%>%
  filter(continent %in% c("Africa", "Americas", "Asia", "Europe"))%>%
  filter(year >= 2002, year <= 2007)%>%
  select("country", "year", "pop", "continent")%>%
  pivot_wider(names_from=year, values_from=pop)%>%
  mutate(dpop = `2007` - `2002`)%>%
  group_by("continent")
  
# note, backtick for mutate refers to its numeric form, not character

p_gapminder<- df%>%
  ggplot(aes(x = reorder(country, dpop), y = dpop))+
  geom_col(aes(fill = continent))+
  facet_wrap(~continent, scales = "free")+
  theme(legend.position = 'none')+
  scale_fill_viridis_d()+
  theme(axis.text.x=element_text(hjust = 1, angle = 45), legend.position = "none")+
  xlab("Country") +
  ylab("Change in Population Between 2002 and 2007")
