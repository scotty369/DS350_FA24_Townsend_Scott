---
title: "Gapminder Plot"
author: "Scott Townsend"
date: "September 30, 2024"

execute:
  keep-md: true

format:
  html:
    code-fold: true
    code-line-numbers: true
---

# Needed Files

::: cell
``` {.r .cell-code}
library(tidyverse)
library(gapminder)

gapminder_filtered <- gapminder %>% 
  filter(country != "Kuwait")
```
:::

# Gapminder Plot

::: cell
``` {.r .cell-code}
ggplot(gapminder_filtered, aes(x = lifeExp, y = gdpPercap, size = pop / 100000, color = continent)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(1, 10), name="Population (100k)") +
  scale_y_continuous(trans = "sqrt", labels = scales::comma) + 
  facet_wrap(~year, nrow=1) +
  theme_bw(base_size = 12) +
  labs(x = "Life Expectancy", y = "GDP per Capita", title = "GDP vs Life Expectancy") +
  theme(legend.position = "right")
```

::: cell-output-display
![](Gapminder_files/figure-html/unnamed-chunk-2-1.png){width="1152"}
:::
:::
