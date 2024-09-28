---
title: "Gapminder Plot"
author: "Scott Townsend"
date: "September 28, 2024"
execute: 
  keep-md: true
  
output: 
  html_document:
    theme: cerulean
    code_folding: hide
    markdown: default
---


::: {.cell}

:::

::: {.cell}

```{.r .cell-code}
ggplot(gapminder_filtered, aes(x = lifeExp, y = gdpPercap, size = pop, color = continent)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(1, 10), name="Population (100k)") +
  scale_y_continuous(trans = "sqrt", labels = scales::comma) + 
  facet_wrap(~year, nrow=1) +
  theme_bw(base_size = 12) +
  labs(x = "Life Expectancy", y = "GDP per Capita", title = "GDP vs Life Expectancy") +
  theme(legend.position = "right")
```

::: {.cell-output-display}
![](Gapminder_files/figure-html/GDP vs Life Expectancy Plot-1.png){width=1152}
:::
:::
