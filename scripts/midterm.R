#1. Read in the file tyler_activity_laps_10-24.csv from the class github page. 
#This file is at url https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv, 
#so you can code that url value as a string object in R and call read_csv() on 
#that object. The file is a .csv file where each row is a “lap” from an 
#activity Tyler tracked with his watch.
library(tidyverse)
tyler_activity_lap<- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")

#2. Filter out any non-running activities.
run<- tyler_activity_lap%>%
  filter(sport=="running")

#3. Next, Tyler often has to take walk breaks between laps right now because trying to change how you’ve run for 25 years is hard. You can assume that any lap with a pace above 10 minute-per-mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute-per-mile pace) and abnormally short records where the total elapsed time is one minute or less.
run2<- run%>%
  mutate(speed= ifelse(minutes_per_mile < 10 & minutes_per_mile > 5, "true", "false"))%>%
  filter(!speed=="false")%>%
  mutate(speed2=ifelse(total_elapsed_time_s >60, "true", "false"))%>%
  filter(!speed2=="false")%>%
  select(!speed)%>%
  select(!speed2)
                     
#4. Create a new categorical variable, pace, that categorizes laps by pace: 
#“fast” (< 6 minutes-per-mile), “medium” (6:00 to 8:00), and “slow” ( > 8:00). 
#Create a second categorical variable, form that distinguishes between laps run 
#in the year 2024 (“new”, as Tyler started his rehab in January 2024) and all 
#prior years (“old”).
pace <- run2%>%
  mutate(pace= case_when(minutes_per_mile<6 ~ "Fast",
                         minutes_per_mile> 6 & minutes_per_mile<8 ~"Medium",
                         minutes_per_mile>8 ~ "Slow"))%>%
  mutate(form= ifelse(year==2024, "new", "old"))


#5. Identify the average steps per minute for laps by form and pace, and 
#generate a table showing these values with old and new as separate rows and 
#pace categories as columns. Make sure that slow speed is the second column, 
#medium speed is the third column, and fast speed is the fourth column (hint: 
#think about what the select() function does).
pace2<-pace%>%
  filter(!is.na(steps_per_minute))%>%
  group_by(form,pace)%>%
  summarize(avg_steps= mean(steps_per_minute))%>%
  pivot_wider(id_cols = "form", names_from = "pace", values_from = "avg_steps")

#6. Finally, Tyler thinks he’s been doing better since July after the doctors 
#filmed him running again and provided new advice. Summarize the minimum, mean, 
#median, and maximum steps per minute results for all laps (regardless of pace 
#category) run between January - June 2024 and July - October 2024 for 
#comparison.


improved<- pace%>%
  mutate(improvement = ifelse(month < 7, "Early", "Late"))%>%
  filter(year=="2024")%>%
  filter(improvement=="Early")
  summary(improved$steps_per_minute)

improved2<- pace%>%
    mutate(improvement = ifelse(month < 7, "Early", "Late"))%>%
    filter(year=="2024")%>%
    filter(improvement=="Late")
  summary(improved2$steps_per_minute)