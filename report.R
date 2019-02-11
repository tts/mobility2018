library(tidyverse)
library(readxl)

# ACRIS report 'Mobility activity last year' exported as an Excel file
rawdata <- read_excel("Mobility_activities_last_year-11_02_2019.xls")

data <- rawdata %>%
  rename(start = `Period-4`,
         end = `End date-5`,
         person = `Source-ID-1`,
         type = `Type-2`) %>% 
  mutate(start = as.Date(start, "%d/%m/%Y"),
         end = as.Date(end, "%d/%m/%Y")) %>% 
  select(person, start, end, type)

mobility <- data %>% 
  mutate(days = end - start) %>% 
  filter(days > 30) %>% 
  group_by(type) %>% 
  summarize(count = n())

