library(stats4)
library(tidyverse)
library(stargazer)
library(readxl)
library(dbplyr)
library(tidyverse)
library(xtable)

data <- read_excel("/Users/axin/Library/Containers/com.microsoft.Excel/Data/Downloads/data sns w&c.xlsx",sheet = "R_testing_warmth")
data <- data %>%
  rename(states = state) %>%
  group_by(user_id)%>%
  mutate(ID = cur_group_id())
#count number of actions where 'engage' is 1 and 0 for each state and each individual
count_action <- data %>%
  select(ID, states, engage, nengage) %>%
  group_by(ID, states) %>%
  summarize(sum_e = sum(engage), sum_n = sum(nengage))
#arrange data by ID and states
count_action <- count_action %>%
  arrange(ID, states)
#calculates num of unique individuals and num of states
individs <- length(unique(data$ID))
nstates <- 3 # 3 states
#initialize empty matrix for action counts of each individuals per state
engage <- matrix(NA, nrow = individs, ncol = nstates)
nengage <- matrix(NA, nrow = individs, ncol = nstates)



