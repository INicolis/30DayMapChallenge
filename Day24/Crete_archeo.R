# The script supposes you downloaded from https://www.naturalearthdata.com/
# 1) the land data in ne_10m_land
# 2) the small island data in ne_10m_minor_islands
# and from http://archive.data.gov.gr
# 3) the archeological sites of Crete in Crete/arhaio_polygon
# by I. Nicolis
# Visit my https://github.com/INicolis for other contributions

library(sf)
library(rgdal)
library(ggplot2)

terres=read_sf("ne_10m_land/ne_10m_land.shp")
iles=read_sf("ne_10m_minor_islands/ne_10m_minor_islands.shp")

sites=readOGR(dsn = "Crete/arhaio_polygon/",layer = "arhaio_polygon")
sites=spTransform(sites,"+proj=longlat +datum=WGS84 +no_defs")
sites_sf=as(sites,"sf")

crete = ggplot() +
  geom_sf(data = terres, fill = "antiquewhite2") +
  geom_sf(data = iles, fill = "antiquewhite2") +
  geom_sf(data = sites_sf, fill = "chocolate2",col = "chocolate2") +
  coord_sf(xlim = c(23.2,26.5), ylim = c(34.7,35.9)) +
  xlab("Longitude") + 
  ylab("Latitude") + 
  ggtitle("Archeological sites of Crete") +
  theme(
    panel.grid.major = element_line(color = gray(.5), 
                                    linetype = "dashed", 
                                    size = 0.5), 
    panel.background = element_rect(fill = "aliceblue")
    )

png(file = "crete_archeo.png",width = 800,height = 800)
print(crete)
dev.off()
