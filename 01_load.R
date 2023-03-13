
# Script to load datasets and trim to AOI ---------------------------------

library(sf)
library(bcdata)
library(dplyr)
library(bcmaps)
library(mapview)


## Create out directory ----------------------------------------------------

out_dir <- file.path("out")
dir.create(out_dir)

# Dataset with route on it

route <- st_read(dsn="data/bonnington-tracks.gpkg") |> 
  transform_bc_albers() |> #transform to crs 3005
  rename_all(tolower) |> 
  st_make_valid() |> #looking for valid geometry
  filter(name != "BT-Escape") # focus on main route

# Creating a buffer around the route - setting AOI
route_buffer <- st_buffer(route, 1)

## Trimming DEM to AOI -----------------------------------------------------

bc_dem <- cded(aoi=route_buffer)

## Save outputs ------------------------------------------------------------

saveRDS(c(bc_dem, route_buffer), file='out/cropped-files.RDS')

