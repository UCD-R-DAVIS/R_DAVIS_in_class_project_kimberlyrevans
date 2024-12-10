#Read in the file tyler_activity_laps_12-6.csv from the class github page. This 
#file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, 
#so you can code that url value as a string object in R and call read_csv() on 
#that object. The file is a .csv file where each row is a “lap” from an activity 
#Tyler tracked with his watch.
library(tidyverse)
tyler_activities<- read_csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")


#Filter out any non-running activities.
tyler_activity_lap<- tyler_activities%>%
  filter(sport== "running")
  

#We are interested in normal running. You can assume that any lap with a pace 
#above 10 minutes_per_mile pace is walking, so remove those laps. You should 
#also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally 
#short records where the total elapsed time is one minute or less.
tyler_activity_lap_update1<- tyler_activity_lap%>%
  filter(!minutes_per_mile>10, !minutes_per_mile<5, !total_elapsed_time_s<=60)


#Group observations into three time periods corresponding to pre-2024 running, 
#Tyler’s initial rehab efforts from January to June of this year, and activities 
#from July to the present.
tyler_activity_lap_update2<-tyler_activity_lap_update1%>%
  mutate(periods= case_when(year<2024 ~"Pre-2024",
                            year= 2024 & month<7 ~"Early 2024",
                            year= 2024 & month>=7 ~ "Late 2024"))%>%
  group_by(periods)

         
#Make a scatter plot that graphs SPM over speed by lap.
tyler_activity_lap_scatter<- ggplot(data = tyler_activity_lap_update2, 
                                    mapping = aes(x=steps_per_minute, y=minutes_per_mile))+
  geom_point()

tyler_activity_lap_scatter

#Make 5 aesthetic changes to the plot to improve the visual.
tyler_activity_lap_scatter<- ggplot(data = tyler_activity_lap_update2, 
                                    mapping = aes(x=steps_per_minute, y=minutes_per_mile, color=periods))+
  geom_point()+
  geom_smooth()+
  theme_bw()+
  labs(x= "Steps Per Minute", y = "Pace (mins/mile)", title= "Tyler's SPM by Pace")+
  theme(plot.title = element_text(hjust = 0.5))

tyler_activity_lap_scatter

#Add linear (i.e., straight) trendlines to the plot to show the relationship 
#between speed and SPM for each of the three time periods (hint: you might want 
#to check out the options for geom_smooth())
?geom_smooth
tyler_activity_lap_scatter<- ggplot(data = tyler_activity_lap_update2, 
                                    mapping = aes(x=steps_per_minute, y=minutes_per_mile, color=periods))+
  geom_point()+
  geom_smooth(method = lm)+
  theme_bw()+
  labs(x= "Steps Per Minute", y = "Pace (mins/mile)", title= "Tyler's SPM by Pace")+
  theme(plot.title = element_text(hjust = 0.5))

tyler_activity_lap_scatter

#Does this relationship maintain or break down as Tyler gets tired? Focus just 
#on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) 
#that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap 
#numbers, assuming that all laps on a given day correspond to the same run 
#(hint: check out the rank() function). Select only laps 1-3 (Tyler never runs 
#more than three miles these days). Make a plot that shows SPM, speed, and lap 
#number (pick a visualization that you think best shows these three variables).
?rank()
post_intervention<- tyler_activity_lap_update2%>%
  filter(periods == "Late 2024")%>%
  group_by(month, day)%>%
  arrange(timestamp)%>%
  mutate(rank= row_number())%>%
  filter(!rank>3)

intervention_plot<- post_intervention%>%
  group_by(rank)%>%
  ggplot(mapping = aes(x=steps_per_minute, y=minutes_per_mile, color= rank, group=rank))+
  geom_point()+
  geom_smooth()+
  theme_bw()+
  labs(x= "Steps per Minute", y = "Speed (min/mile))", title= "Tyler's SPM by Lap")+
  theme(plot.title = element_text(hjust = 0.5))

intervention_plot

