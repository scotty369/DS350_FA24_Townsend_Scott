---
title: "W08 Case Study - Building The Past"
author: "Scott Townsend"
date: "November 07, 2024"

execute:
  keep-md: true

format:
  html:
    code-fold: true
    code-line-numbers: true
---



### Libraries


::: {.cell}

```{.r .cell-code}
library(USAboundaries)
library(tidyverse)
library(sf)
library(buildings)
```
:::


### Data Sets


::: {.cell}

```{.r .cell-code}
us_states <- us_states()

idaho_counties <- us_counties(states = "Idaho")

data("permits")

single_family_permits <- permits %>% filter(variable == "Single Family")

state_permits <- single_family_permits %>%
  group_by(state, year) %>%
  summarize(total_permits = sum(value, na.rm = TRUE)) %>%
  mutate(state = as.character(state))  # Convert 'state' to character

county_permits <- single_family_permits %>%
  filter(StateAbbr == "ID") %>%
  group_by(countyname, year) %>%
  summarize(total_permits = sum(value, na.rm = TRUE))

idaho_counties_clean <- idaho_counties %>%
  select(-state_name)

state_map_data <- us_states %>%
  left_join(state_permits, by = c("statefp" = "state"))

idaho_county_map_data <- idaho_counties_clean %>%
  left_join(county_permits, by = c("geoid" = "countyname"))
```
:::


# Case Study - Visualizations


::: {.cell}

```{.r .cell-code}
ggplot(state_map_data) + 
  geom_sf(aes(fill = log1p(total_permits))) + 
  facet_wrap(~year) + 
  scale_fill_viridis_c(option = "plasma", name = "Permits (log)") + 
  labs(title = "Trends in Single-Family Building Permits by State",
       subtitle = "Log-transformed to manage disparities in scale") + 
  theme_minimal()
```

::: {.cell-output-display}
![](W08-Case-Study---Building-The-Past_files/figure-html/unnamed-chunk-3-1.png){width=2880}
:::
:::

::: {.cell}

```{.r .cell-code}
ggplot(idaho_county_map_data) + 
  geom_sf(aes(fill = log1p(total_permits)), color = "white", size = 0.2) + 
  facet_wrap(~year) +  # Facet by year to show trends over time
  scale_fill_viridis_c(option = "plasma", name = "Permits (log)") + 
  labs(title = "Trend in Single-Family Building Permits by County in Idaho",
       subtitle = "Log-transformed to manage disparities in scale") + 
  theme_minimal() + 
  theme(legend.position = "bottom", 
        strip.text = element_text(size = 10))
```

::: {.cell-output-display}
![](W08-Case-Study---Building-The-Past_files/figure-html/unnamed-chunk-4-1.png){width=2112}
:::
:::


# Summary of Insights

The maps show trends in building permits for single-family homes through different years across the United States and Idaho. The first map highlights differences between states. Large states like California have high numbers of permits, while smaller states like North Dakota have much lower numbers, even in their peak years. I used a log-transformation to make it easier to compare these states by reducing the effect of extreme numbers.

The second map focuses on Idaho, showing trends in each county. I also applied the log-transformation here to make it easier to compare areas with different levels of permits.

# Visualization Choices:
I chose maps for these visuals because they are great for showing geographic data and trends. The facet_wrap() function allows us to compare the data over time, showing how the trends change year by year. To deal with the big differences in permit numbers, I used a log-transformation to balance the data. I used the viridis color scale, which is easy to read and helps highlight the permit totals clearly.