---
title: "W12 Task - Chipotle Functions"
author: "Scott Townsend"
date: "December 03, 2024"

execute:
  keep-md: true

format:
  html:
    code-fold: true
    code-line-numbers: true
---



### Libraries & Data Sets


::: {.cell}

```{.r .cell-code}
library(tibble)
library(dplyr)
library(stringr)
```
:::


# Task - Visualization


::: {.cell}

```{.r .cell-code}
parse_popularity <- function(input_string) {
  cleaned_string <- str_remove_all(input_string, "[{}\"]")
  key_value_pairs <- str_split(cleaned_string, ",")[[1]]
  
  parsed_data <- tibble(
    day = sapply(key_value_pairs, function(x) str_split(x, ":")[[1]][1]),
    visits = as.numeric(sapply(key_value_pairs, function(x) str_split(x, ":")[[1]][2]))
  )
  
  return(parsed_data)
}

find_most_popular_day <- function(input_string) {
  data <- parse_popularity(input_string)
  
  max_visits <- max(data$visits)
  
  most_popular <- data %>%
    filter(visits == max_visits) %>%
    pull(day)
  
  return(paste(most_popular, collapse = ", "))
}

# Test Case 1
input1 <- "{\"Monday\":94,\"Tuesday\":76,\"Wednesday\":89,\"Thursday\":106,\"Friday\":130,\"Saturday\":128,\"Sunday\":58}"
print(parse_popularity(input1))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 7 × 2
  day       visits
  <chr>      <dbl>
1 Monday        94
2 Tuesday       76
3 Wednesday     89
4 Thursday     106
5 Friday       130
6 Saturday     128
7 Sunday        58
```


:::

```{.r .cell-code}
print(find_most_popular_day(input1))
```

::: {.cell-output .cell-output-stdout}

```
[1] "Friday"
```


:::

```{.r .cell-code}
# Test Case 2
input2 <- "{\"Monday\":18,\"Tuesday\":16,\"Wednesday\":14,\"Thursday\":27,\"Friday\":26,\"Saturday\":36,\"Sunday\":20}"
print(parse_popularity(input2))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 7 × 2
  day       visits
  <chr>      <dbl>
1 Monday        18
2 Tuesday       16
3 Wednesday     14
4 Thursday      27
5 Friday        26
6 Saturday      36
7 Sunday        20
```


:::

```{.r .cell-code}
print(find_most_popular_day(input2))
```

::: {.cell-output .cell-output-stdout}

```
[1] "Saturday"
```


:::

```{.r .cell-code}
# Test Case 3
input3 <- "{\"Monday\":0,\"Tuesday\":0,\"Wednesday\":1,\"Thursday\":0,\"Friday\":0,\"Saturday\":1,\"Sunday\":0}"
print(parse_popularity(input3))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 7 × 2
  day       visits
  <chr>      <dbl>
1 Monday         0
2 Tuesday        0
3 Wednesday      1
4 Thursday       0
5 Friday         0
6 Saturday       1
7 Sunday         0
```


:::

```{.r .cell-code}
print(find_most_popular_day(input3))
```

::: {.cell-output .cell-output-stdout}

```
[1] "Wednesday, Saturday"
```


:::
:::