---
title: "W08 Task - Idaho Water"
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
library(sf)
library(ggplot2)
library(USAboundaries)
library(dplyr)
library(USAboundariesData)
library(rio)
```
:::


### Data Sets


::: {.cell}

```{.r .cell-code}
url1 <- "https://byuistats.github.io/M335/data/Wells.zip"
url2 <- "https://byuistats.github.io/M335/data/Idaho_Dams.zip"
temp_dir <- tempdir()

temp_zip <- file.path(temp_dir, "Wells.zip")
download.file(url1, temp_zip, mode = "wb")
unzip(temp_zip, exdir = temp_dir)
wells_data <- st_read(file.path(temp_dir, "Wells.shp"))
```

::: {.cell-output .cell-output-stdout}

```
Reading layer `Wells' from data source 
  `/private/var/folders/zs/zycd14f96ks5gpx0bsb97xtr0000gn/T/RtmpWrX1kQ/Wells.shp' 
  using driver `ESRI Shapefile'
Simple feature collection with 195091 features and 33 fields
Geometry type: POINT
Dimension:     XY
Bounding box:  xmin: -117.3642 ymin: 41.02696 xmax: -111.0131 ymax: 49.00021
Geodetic CRS:  WGS 84
```


:::

```{.r .cell-code}
temp_zip <- file.path(temp_dir, "Idaho_Dams.zip")
download.file(url2, temp_zip, mode = "wb")
unzip(temp_zip, exdir = temp_dir)
Idaho_Dams_data <- st_read(file.path(temp_dir, "Dam_Safety.shp"))
```

::: {.cell-output .cell-output-stdout}

```
Reading layer `Dam_Safety' from data source 
  `/private/var/folders/zs/zycd14f96ks5gpx0bsb97xtr0000gn/T/RtmpWrX1kQ/Dam_Safety.shp' 
  using driver `ESRI Shapefile'
Simple feature collection with 1127 features and 23 fields
Geometry type: POINT
Dimension:     XY
Bounding box:  xmin: -117.0866 ymin: 42.00058 xmax: -111.0725 ymax: 48.95203
Geodetic CRS:  WGS 84
```


:::

```{.r .cell-code}
wells_filtered <- wells_data %>% filter(Production > 5000)
dams_filtered <- Idaho_Dams_data %>% filter(SurfaceAre > 50, Source %in% c("SNAKE RIVER", "HENRYS FORK"))

ID_counties <- USAboundaries::us_counties(states = "Idaho")
```
:::


# Task - Visualization


::: {.cell}

```{.r .cell-code}
ggplot() +
  geom_sf(data = ID_counties, fill = "lightgrey", color = "darkgrey", linewidth = 0.5) +
  geom_sf(data = wells_filtered, color = "black", size = 2, shape = 10) +
  geom_sf(data = dams_filtered, color = "blue", size = 3, shape = 7, linewidth = 2) +
  theme_bw() +
  labs(title = "Idaho Water Map", subtitle = "Filtered Wells and Dams in Idaho") +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "navyblue"),
    plot.subtitle = element_text(size = 14, color = "darkblue")
  )
```

::: {.cell-output-display}
![](W08-Task---Idaho-Water_files/figure-html/unnamed-chunk-3-1.png){width=1152}
:::
:::
