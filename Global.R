# Library
library(ggplot2) # Untuk membuat plot statis
library(ggpubr) # melakukan eksport plot
library(scales) # melakukan edit di plot
library(glue) # menambah tooltip
library(plotly) # eksport plot statis menjadi interaktif
library(lubridate) # bermain dengan tipe data tanggal 
library(dplyr)
library(tidyr)

library(shiny)
library(shinydashboard)
library(DT) 

# Read Data
mxmh <- read.csv("mxmh_survey_results.csv")

#Pembuatan fungsi
convert_type <- function(x){
  if (x==0)
  {x <- "No experience it"
  }
  else if (x >0 & x <= 3)
  {
    x <- "Regularly" # video dengan publish_hour antara tengah malam hingga 8 pagi 
  }
  else if (x > 3 & x <= 7)
  {
    x <- "Constantly" # video jam 9 pagi hingga 4 sore
  }
  else
  {x <- "Extreme" # video jam 5 sore hingga tengah malam
  }
}


# Data Cleansing 
mxmh <- mxmh %>% 
  select(-c(Permissions, BPM)) %>% 
  filter(Music.effects!= "", !is.na(Age)) %>% 
  mutate(
    Fav.genre = as.factor(Fav.genre), 
    Music.effects= as.factor(Music.effects),
    While.working= as.factor(While.working)
  )

#second

mxmh_pivot <- mxmh %>% 
  pivot_longer(cols = c("Anxiety", "Depression","OCD","Insomnia"),
               names_to = "Mental_Health_types",
               values_to = "Level")

mxmh_pivot<- mxmh_pivot %>% 
  mutate(Level=as.integer(Level))

mxmh_pivot$Level<- sapply(X = mxmh_pivot$Level,
                          FUN = convert_type)


