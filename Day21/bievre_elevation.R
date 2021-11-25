# Altimetric plot of the bed of river Bièvres https://en.wikipedia.org/wiki/Bièvre_(river)
# by I. Nicolis
# Visit my https://github.com/INicolis for other contributions

library(elevatr)
library(sf)
library(raster)
library(ggplot2)

# Coordonnées du flux de la Bièvre
bievre=data.frame(x=c(2.03,2.41),y=c(48.72,48.85))

# Altimétrie
bievre_elevation = get_elev_raster(locations = bievre,
                                   prj="+proj=longlat +datum=WGS84 +no_defs",
                                   z = 12,
                                   clip = "locations",
                                   serial=T)
bievre_elevation_df=na.omit(as.data.frame(bievre_elevation,xy=TRUE))
colnames(bievre_elevation_df)[3]="altitude"

# Tracé
vallee=ggplot() +
  geom_raster(data = bievre_elevation_df, aes(x = x, y = y, fill = altitude)) +
  scale_fill_gradient(low = 'cyan', high = 'brown') +
  labs(title = "Bievre river bed",
       x = "Longitude",
       y = "Latitude",
       fill = "Elevation (meters)")+
  coord_equal()

# Source
vallee=vallee+
  annotate("point", y=48.7768, x=2.049, colour = "gold")+  # Source coordinates
  annotate("text", y=48.77, x=2.05, label = "Source",col="gold")
# Confluence
vallee=vallee+
  annotate("point", y=48.8412, x=2.3928, colour = "gold")+  # Confluence coordinates
  annotate("text", y=48.835, x=2.38, label = "Confluence",col="gold")

png(file = "bievre.png",width = 1000,height = 400)
print(vallee)
dev.off()
