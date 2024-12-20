---
title: "W08 Task - U.S. Cities"
author: "Scott Townsend"
date: "November 12, 2024"

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
library(dplyr)
library(ggplot2)
library(sf)
library(ggrepel)
```
:::


# Task - Visualization


::: {.cell}

```{.r .cell-code}
states <- us_states() %>%
  filter(!(state_abbr %in% c("AK", "HI")))

idaho_counties <- us_counties(states = "Idaho")

cities <- us_cities() %>%
  filter(state_abbr != "HI" & state_abbr != "AK" & state_abbr != "PR" & state_abbr != "DC") %>%
  group_by(state_name) %>%
  arrange(desc(population)) %>%
  slice_head(n = 3) %>%
  mutate(rank = row_number()) %>%
  ungroup()

cities <- cities %>%
  mutate(lng = st_coordinates(geometry)[, 1],
         lat = st_coordinates(geometry)[, 2])

cities_coords <- st_coordinates(cities)
cities$lon <- cities_coords[, 1]
cities$lat <- cities_coords[, 2]

ggplot() + 
  geom_sf(data = states, fill = NA, color = "black", linewidth = 0.8) +
  geom_sf(data = idaho_counties, fill = NA) +
  geom_sf(data = cities, aes(color = population, size = population / 1000)) +
  geom_label_repel(aes(label = city, x = lng, y = lat), data = cities, size = 4, color = "navyblue") +
  labs(size = "Population (1000's)", color = element_blank()) +
  scale_size_continuous(range = c(2, 8)) +
  scale_color_gradientn(colors = c("deepskyblue", "darkblue", "midnightblue")) +
  theme_bw() +
  theme(
    legend_title = element_text(color = "royalblue", face = "bold"),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    plot.title = element_text(color = "royalblue", face = "bold", size = 16),
    axis.title.x = element_text(color = "royalblue"),
    axis.title.y = element_text(color = "royalblue"),
    panel.grid.major = element_line(color = "lightgrey", size = 0.2),
    panel.grid.minor = element_blank()
  )
```

::: {.cell-output-display}
![](Task---U.S.-Cities_files/figure-html/unnamed-chunk-2-1.png){width=2304}
:::

```{.r .cell-code}
ggsave("us_map.png", width = 16, height = 10)
```
:::
