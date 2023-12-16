#| warning: false
#| include: false

library(RandomFields)
library(terra)
library(purrr)
library(NLMR)
library(tmap)
library(landscapetools)
library(landscapemetrics)
library(ggplot2)
library(motif)
library(tidyr)
library(comat)
library(philentropy)

set.seed(2023-12-11)
# symulacja rastrów o różnej konfiguracji
sim1 = nlm_fbm(100, 100, fract_dim = 0.3)
sim3 = nlm_fbm(100, 100, fract_dim = 1.6)

# symulacja rastrów o różnej kompozycji
sim1_1 = landscapetools::util_binarize(sim1, breaks = 0.1) %>% raster::reclassify(rcl)
sim1_3 = landscapetools::util_binarize(sim1, breaks = 0.5) %>% raster::reclassify(rcl)

sim3_1 = landscapetools::util_binarize(sim3, breaks = 0.1) %>% raster::reclassify(rcl)
sim3_3 = landscapetools::util_binarize(sim3, breaks = 0.5) %>% raster::reclassify(rcl)

sim_stack = raster::stack(sim1, sim1_1, sim1_3,
                          sim3, sim3_1, sim3_3)

# wizualizacja symulowanych rastrów
tm_shape(sim_stack) +
  tm_raster(style = 'cont', breaks = c(0,1), palette = terrain.colors(255)) +
  tm_layout(asp = 1, legend.show = FALSE, panel.show = FALSE)
