# The script supposes you downloaded from https://www.naturalearthdata.com/
# 1) the land data in ne_10m_land
# 2) the small island data in ne_10m_minor_islands
# and from
# 3) the archeological sites of Crete in Crete/arhaio_polygon
# by I. Nicolis
# Visit my https://github.com/INicolis for other contributions

import shapefile as shp
import matplotlib.pyplot as plt
from descartes import PolygonPatch
# downloaded from https://geodata.gov.gr/en/dataset/periphereies-elladas
grece=shp.Reader("../../../../maps/periphereies/periphereies.shp", encoding="iso-8859-7")
fig = plt.figure() 
for shape in grece.shapeRecords():
    polygones = shape.shape.__geo_interface__
    BLUE = '#6699cc'
    ax = fig.gca() 
    ax.add_patch(PolygonPatch(polygones, fc=BLUE, ec=BLUE, alpha=0.5, zorder=2 ))
    ax.axis('scaled')
plt.savefig("grece_regions.png")