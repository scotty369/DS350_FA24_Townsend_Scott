---
title: "W08 Task - Idaho Water"
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
url3 <- "https://byuistats.github.io/M335/data/water.zip"
url4 <- "https://byuistats.github.io/M335/data/shp.zip"

temp_dir <- tempdir()

temp_zip <- file.path(temp_dir, "Wells.zip")
download.file(url1, temp_zip, mode = "wb")
unzip(temp_zip, exdir = temp_dir)
wells_data <- st_read(file.path(temp_dir, "Wells.shp"))
```

::: {.cell-output .cell-output-stdout}

```
Reading layer `Wells' from data source 
  `/private/var/folders/zs/zycd14f96ks5gpx0bsb97xtr0000gn/T/RtmplfTWnP/Wells.shp' 
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
  `/private/var/folders/zs/zycd14f96ks5gpx0bsb97xtr0000gn/T/RtmplfTWnP/Dam_Safety.shp' 
  using driver `ESRI Shapefile'
Simple feature collection with 1127 features and 23 fields
Geometry type: POINT
Dimension:     XY
Bounding box:  xmin: -117.0866 ymin: 42.00058 xmax: -111.0725 ymax: 48.95203
Geodetic CRS:  WGS 84
```


:::

```{.r .cell-code}
temp_zip <- file.path(temp_dir, "water.zip")
download.file(url3, temp_zip, mode = "wb")
unzip(temp_zip, exdir = temp_dir)
water_data <- st_read(file.path(temp_dir, "hyd250.shp"))
```

::: {.cell-output .cell-output-stdout}

```
Reading layer `hyd250' from data source 
  `/private/var/folders/zs/zycd14f96ks5gpx0bsb97xtr0000gn/T/RtmplfTWnP/hyd250.shp' 
  using driver `ESRI Shapefile'
Simple feature collection with 30050 features and 26 fields
Geometry type: LINESTRING
Dimension:     XY
Bounding box:  xmin: 2241685 ymin: 1198722 xmax: 2743850 ymax: 1981814
Projected CRS: NAD83 / Idaho Transverse Mercator
```


:::

```{.r .cell-code}
temp_zip <- file.path(temp_dir, "shp.zip")
download.file(url4, temp_zip, mode = "wb")
unzip(temp_zip, exdir = temp_dir)
county_data <- st_read(file.path(temp_dir, "County-AK-HI-Moved-USA-Map.shp"))
```

::: {.cell-output .cell-output-stdout}

```
Reading layer `County-AK-HI-Moved-USA-Map' from data source 
  `/private/var/folders/zs/zycd14f96ks5gpx0bsb97xtr0000gn/T/RtmplfTWnP/County-AK-HI-Moved-USA-Map.shp' 
  using driver `ESRI Shapefile'
Simple feature collection with 3115 features and 15 fields
Geometry type: MULTIPOLYGON
Dimension:     XY
Bounding box:  xmin: -2573301 ymin: -1889441 xmax: 2256474 ymax: 1565782
Projected CRS: Albers
```


:::

```{.r .cell-code}
wells_filtered <- wells_data %>% filter(Production > 5000)
dams_filtered <- Idaho_Dams_data %>% filter(SurfaceAre > 50, Source %in% c("SNAKE RIVER", "HENRYS FORK"))

county_proj <- st_transform(county_data, crs = 26912)
wells_proj <- st_transform(wells_filtered, crs = 26912)
dams_proj <- st_transform(dams_filtered, crs = 26912)
```
:::


# Task - Visualization


::: {.cell}

```{.r .cell-code}
ggplot() +
  geom_sf(data = county_proj, fill = "lightgrey", color = "black") +
  geom_sf(data = wells_proj, color = "darkgreen", size = 2, shape = 16) +
  geom_sf(data = dams_proj, color = "blue", size = 3, shape = 7, linewidth = 2) +
  labs(
    title = "Idaho Key Water System Features",
  ) +
  theme_minimal()
```

::: {.cell-output-display}
![](W08-Task---Idaho-Water_files/figure-html/unnamed-chunk-3-1.png){width=1152}
:::

```{.r .cell-code}
ggsave("Idaho_Water_System_Map.png", width = 12, height = 8)
```
:::
