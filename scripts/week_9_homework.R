library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")
#1. Using a for loop, print to the console the longest species name of each taxon
for(i in unique(surveys$taxa)){
  alltaxa<-surveys[surveys$taxa==i,]
  speciesname<- alltaxa[nchar(alltaxa$species) == max(nchar(alltaxa$species)),] %>% select(species)
  print(paste0("Longest name of the ", i, "s is: "))
  print(unique(speciesname$species))
}

#2
# code didn't work as pipe all together? may have been my own error
mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
install.packages("purrr")
library(purrr)

maxcolumn<- mloa %>% select(windDir, windSpeed_m_s, baro_hPa, temp_C_2m, temp_C_10m, temp_C_towertop, rel_humid, precip_intens_mm_hr)
mapping<- maxcolumn %>% map(~ max(.x, na.rm = T))
mapping

#3
C_to_F<- function(x){
  x * 1.8 + 32
}
mloa$temp_F_2m<- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m<- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop<- C_to_F(mloa$temp_C_towertop)
mloa$temp_F_2m
mloa$temp_F_10m
mloa$temp_F_towertop
