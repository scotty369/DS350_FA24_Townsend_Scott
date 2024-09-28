---
title: "First Quarto File"
date: "September 28, 2024"

execute:
  keep-md: true

format:
  html:
    code-fold: true
    code-line-numbers: true
---



#### R Code for the plot

::: {.cell}

```{.r .cell-code}
# Generating a simple plot
plot(1:20)
```

::: {.cell-output-display}
![](First_Quarto_File_files/figure-html/unnamed-chunk-1-1.png){width=672}
:::
:::


Articles with Data Visualizations

### 1. ["How Will Your City Feel in the Future?" – The Pudding](https://pudding.cool/2024/06/climate-zones/)
Review:
What’s Unique/Good: This article presents climate change projections for different cities using interactive visualizations that simulate future temperatures. The map-based interface is intuitive, allowing users to easily explore how various cities’ climates may resemble others in the future. It’s also visually engaging, with smooth animations and a clear, concise user interface.
What Could Be Improved: One limitation is that while the visualizations are interactive, they might feel overwhelming for users unfamiliar with climate data. A more detailed guide or tutorial on how to use the interactive tools might improve accessibility.

### 2. ["Population Growth" – Our World in Data](https://ourworldindata.org/population-growth)
Review:
What’s Unique/Good: The visualizations in this article track global population growth over time, with clear graphs displaying population estimates across different regions and time periods. The interactivity allows for a granular look at historical trends and future projections. The visuals are clear, with data sources well-documented.
What Could Be Improved: The article contains a large amount of information, which may overwhelm readers. Breaking the data into smaller, more digestible sections could make it easier for users to focus on specific areas of interest without scrolling through long sections of content.

### 3. ["Most and Least Affordable Places to Buy a Home" – Priceonomics](https://priceonomics.com/most-and-least-affordable-places-to-buy-a-home/)
Review:
What’s Unique/Good: This article uses a combination of bar charts and heat maps to compare home affordability across different cities. The bar charts provide a clear ranking of cities by affordability, while the heat maps visually highlight regional differences. The analysis is simple but effective in conveying how affordability varies across geographic locations.
What Could Be Improved: The use of color in the heat map is somewhat limited, making it hard to differentiate between similar affordability levels. Adding more color gradients or interactive features, such as allowing users to filter cities by different metrics (e.g., median income), would enhance the user experience.
