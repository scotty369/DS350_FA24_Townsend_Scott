---
title: "W04 Task - Stock Data"
author: "Scott Townsend"
date: "October 08, 2024"

execute:
  keep-md: true

format:
  html:
    code-fold: true
    code-line-numbers: true
---



# Required Libraries & RDS File


::: {.cell}

```{.r .cell-code}
library(readr)
library(tidyr)
library(dplyr)
library(downloader)
library(pander)

url <- "https://raw.githubusercontent.com/byuistats/data/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS"

download(url, destfile = "Dart_Expert_Dow_6month_anova.RDS", mode = "wb")
dart_dow <- readRDS("Dart_Expert_Dow_6month_anova.RDS")
```
:::


# Tidying the Data


::: {.cell}

```{.r .cell-code}
dow_sep <- dart_dow %>%
  separate(contest_period, into = c("month_end", "year_end"), sep = -4) %>% 
  separate(month_end, into = c("month_start", "month_end"), sep = "-")  

saveRDS(dow_sep, file = "dow_tidy.rds")

dow_vis <- dow_sep %>%
  filter(variable == "DJIA") %>% 
  select(month_end, year_end, value) %>%
  mutate(
    month_end = case_when(
      month_end == "Dec." ~ "December",
      month_end == "Febuary" ~ "February",
      TRUE ~ month_end
    )
  ) %>%
  group_by(year_end, month_end) %>% 
  mutate(year_number = case_when(  
    month_end == "December" ~ 12,
    month_end == "November" ~ 11,
    month_end == "October" ~ 10,
    month_end == "September" ~ 9,
    month_end == "August" ~ 8,
    month_end == "July" ~ 7,
    month_end == "June" ~ 6,
    month_end == "May" ~ 5,
    month_end == "April" ~ 4,
    month_end == "March" ~ 3,
    month_end == "February" ~ 2,
    month_end == "January" ~ 1
  ))

dow_table <- dow_vis %>%
  pivot_wider(names_from = year_end, values_from = value) %>%  
  arrange(year_number) %>% 
  select(-year_number) %>%  
  rename(Month = month_end) 

dow_table[] <- lapply(dow_table, function(x) {
  ifelse(is.na(x), "-", x)
})

pander(dow_table)
```

::: {.cell-output-display}

----------------------------------------------------------------------------
   Month     1990    1991   1992   1993   1994   1995   1996   1997   1998  
----------- ------- ------ ------ ------ ------ ------ ------ ------ -------
  January      -     -0.8   6.5    -0.8   11.2   1.8     15    19.6   -0.3  

 February      -      11    8.6    2.5    5.5    3.2    15.6   20.1   10.7  

   March       -     15.8   7.2     9     1.6    7.3    18.4   9.6     7.6  

   April       -     16.2   10.6   5.8    0.5    12.8   14.8   15.3   22.5  

    May        -     17.3   17.6   6.7    1.3    19.5    9     13.3   10.6  

   June       2.5    17.7   3.6    7.7    -6.2    16    10.2   16.2    15   

   July      11.5    7.6    4.2    3.7    -5.3   19.6   1.3    20.8    7.1  

  August     -2.3    4.4    -0.3   7.3    1.5    15.3   0.6    8.3    -13.1 

 September   -9.2    3.4    -0.1   5.2    4.4     14    5.8    20.2   -11.8 

  October    -8.5    4.4     -5    5.7    6.9    8.2    7.2     3       -   

 November    -12.8   -3.3   -2.8   4.9    -0.3   13.1   15.1   3.8      -   

 December    -9.3    6.6    0.2     8     3.6    9.3    15.5   -0.7     -   
----------------------------------------------------------------------------


:::
:::
