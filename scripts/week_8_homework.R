library(lubridate)
library(tidyverse)
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

# Use the README file associated with the Mauna Loa dataset to determine in 
#what time zone the data are reported, and how missing values are reported in 
#each column. 

# time = utc
# rel humidity missing = -99
# temp_c_2m missing = -999.9
# wind speed missing = -999.9

#remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s.
mloa_filtered<- mloa%>%
  filter(windSpeed_m_s != "-999.9")%>%
  filter(temp_C_2m != "-999.9")%>%
  filter(rel_humid != "-99")

#Generate a column called “datetime” using the year, month, day, hour24, and min columns.

mloa_filtered<- mloa%>%
  filter(!windSpeed_m_s == "-999.9")%>%
  filter(!temp_C_2m== "-999.9")%>%
  filter(!rel_humid== "-99")%>%
  mutate(datetime= ymd_hm(paste(year, "-", month,
                                "-", day, ", ", hour24, ":",
                                min, sep = "")))


#other option
mloa_filtered<- mloa%>%
  filter(!windSpeed_m_s == "-999.9")%>%
  filter(!temp_C_2m== "-999.9")%>%
  filter(!rel_humid== "-99")%>%
  mutate(datetime= ymd_hm(paste(year, month, day, hour24, min, sep = "-")))

#or
mutate(datetime = ymd_hm(paste(paste(year,month,day,sep= "-"), paste(hour24,min,sep=":"))))


#Next, create a column called “datetimeLocal” that converts the datetime column 
#to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz())

mloa_filtered<- mloa%>%
  filter(!windSpeed_m_s == "-999.9")%>%
  filter(!temp_C_2m== "-999.9")%>%
  filter(!rel_humid== "-99")%>%
  mutate(datetime= ymd_hm(paste(year, "-", month,
                                "-", day, ", ", hour24, ":",
                                min, sep = "")))%>%
  mutate(datetimelocal = with_tz(datetime, tz = "Pacific/Honolulu"))

#Then, use dplyr to calculate the mean hourly temperature each month using the 
#temp_C_2m column and the datetimeLocal columns.
mloa_meantemp<- mloa_filtered%>%
  mutate(monthlocal = month(datetimelocal),
         hourlocal = hour(datetimelocal))%>%
  group_by(monthlocal, hourlocal)%>%
  summarise(temp=mean(temp_C_2m))

ggplot(data = mloa_meantemp)+
  geom_point(aes(x=month(monthlocal, label =T), y= temp, col= hourlocal))+
  scale_colour_viridis_c() +
  xlab("Month") +
  ylab("Average temperature") +
  theme_dark()
#can change numbers to months by doing month([monthcolumn], label=T)
# another palette:
# scale_color_distiller(palette = "Oranges")