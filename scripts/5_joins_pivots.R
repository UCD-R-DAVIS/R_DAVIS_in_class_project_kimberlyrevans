# joins----
# left join keeps everything in the first dataframe
# inner join keeps only the same things that overlap, ONLY matches
# "df tend to get small in an inner join"
# people never use right join. just assume you're keeping records in first df
# full join keeps EVERYTHING, looks for common column names and keeps everything
# full join gets crazy when a secindary column has same name and diff data

library(tidyverse)
tail<- read_csv('data/tail_length.csv')
surveys<- read_csv('data/portal_data_joined.csv')

dim(tail)
dim(surveys)
head(tail)

surveys_inner<- inner_join(x = surveys, y=tail)
dim(surveys_inner)
# keeps all common column names, and only similar rows
#example: if we are inner joining by ID:
# if we had 4 IDs in df 'x', and 10 IDs in df 'y', the max amount of IDs we will have is 4
# will have the same or less amount of rows as df with less rows


surveys_right <- right_join(x=surveys, y=tail)

head(surveys_right)

?rename()
#  need to fix this, but can rename a cloumn in r to match another dataset
tail %>% rename(record_id == 'record_id2')
left_join(surveys, tail, by = c('record_id', 'record_id2'))

# pivots----
surveys_mz<- surveys%>%
  filter(!is.na(weight))%>%
  group_by(genus, plot_id)%>%
  summarize(mean_weight=mean(weight))

surveys_mz
# this dataset is long data
# we can pivot this to make the dataset wide
#some things cannot be pivoted
surveys_mz %>% pivot_wider(id_cols = 'genus', names_from = 'plot_id',
                           values_from = 'mean_weight')
