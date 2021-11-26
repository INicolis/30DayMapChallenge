# Covid vaccination in Greece by department.
# Data from gov.gr, 25 November 2021
# Not necessarily representative because recorded by
# vaccination department and by residence.
# See it just as an exercice of combining python and R i a script
library(ggplot2)
library(sf)
library(ggthemes)
library(reticulate)

census=read.csv("resident_population_census2011.csv",sep=";",header=F)
names(census)=c("dep","pop")

py_run_file("vaccination_gov_gr.py")
vac=py$vaccinations

pervac=data.frame(matrix(ncol=2,nrow=0,data = NA,dimnames = list(NULL,c("area","percentage"))))
for (i in 1:length(vac))
{
  pervac[i,"area"]=paste0("ΠΕΡΙΦΕΡΕΙΑΚΗ ΕΝΟΤΗΤΑ ",census$dep[i])
  pervac[i,"percentage"]=vac[[i]]$totaldistinctpersons/census$pop[i]*100
}
pervac[75,]=c("ΑΓΙΟ ΟΡΟΣ",NA)

shp <- st_read(dsn = 'perif_enot/',layer = "ΠΕΡΙΦΕΡΕΙΑΚΕΣ_ΕΝΟΤΗΤΕΣ",options = "ENCODING=WINDOWS-1253")

vacmap=st_sf(dplyr::left_join(pervac,shp,by=c("area"="LEKTIKO")))
vacmap$percentage=as.numeric(vacmap$percentage)

carte=ggplot(vacmap)+
  geom_sf(aes(fill=cut(percentage,breaks=c(0,40,50,60,70,200))))+
  theme_map()+
  scale_fill_brewer(type="seq",palette="Blues",name="% vac",labels=c("29-40","40-50","50-60","60-70",">70"))

png("greece_vaccination_26nov2021.png")
print(carte)
dev.off()

