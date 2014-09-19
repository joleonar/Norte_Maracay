library(ggplot2)
library(ggmap)

#Base da datos de fallas
Fallas <- readShapeLines("./Venezuela/2012_FALLASactivas_Vzla.shp")

#Estaciones
esta <- read.table("ESTACIONES.txt",header=T)

# getting the map
mapsismo <- get_map(location = c(lon = -67, lat = 7.5), zoom = 6,maptype = "terrain", scale = 2)

# plotting the map with some points on it
g <- ggmap(mapsismo) 
g <- g + guides(fill=FALSE,alpha=FALSE,size=FALSE)+labs(title="ESTACIONES SISMOLÓGICAS") + xlab("Longitud") + ylab("Latitud")
# Fallas
 g <- g + geom_line(data=Fallas,aes(x=long,y=lat,group=group),colour="red") 
# Estaciones
 g <- g + coord_fixed() + geom_point(aes(x =LON ,y = LAT),data = esta, shape=17,colour="yellow",size = 6)+
 geom_text(data=esta,aes(x=LON,y=LAT),label=esta$COD,vjust=-1.6,size=3)
print(g)
	
