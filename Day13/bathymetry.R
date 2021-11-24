# The 30DayMapChallenge for November 13, 2021 is to use Natural Earth Data.
# So I prepared a bathymetry map around the Calypso deep, the deepest point in the Mediterranean
# The script supposes you downloaded from https://www.naturalearthdata.com/
# 1) the coastlines in ne_10m_coastline
# 2) the bathymetry data in ne_10m_bathymetry_all
# by I. Nicolis
# Visit my https://github.com/INicolis for other contributions

library(ggplot2)
library(rgdal)
library(broom)

coast=readOGR("ne_10m_coastline/ne_10m_coastline.shp")
coast_t=tidy(coast)
carte=ggplot()+
  geom_path(data=coast_t,aes(x = long, y = lat, group = group),col="brown")+
  coord_map(xlim = c(20,24), ylim = c(34,38))+   # We restrain the map in the South East of Greece
  theme_minimal()

profondeurs=dir(path="ne_10m_bathymetry_all/",pattern = "*shp")
n=length(profondeurs)
for (niveau in 1:n)
{
  bathy=readOGR(paste0("ne_10m_bathymetry_all/",profondeurs[niveau]))
  bathy_t=tidy(bathy)
  carte=carte+
    geom_polygon(data=bathy_t,aes(x = long, y = lat, group = group),fill="blue",alpha=0.1)
}

carte=carte+
  annotate("point", y=36.566667, x=21.133333, colour = "red")+  # Calypso deep coordinates
  annotate("text", y=36.3, x=21.133333, label = "Calypso\ndeep",col="red")

png(file = "depth.png",width = 800,height = 800)
print(carte)
dev.off()
