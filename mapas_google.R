library(ggplot2)
library(ggmap)


# creating a sample data.frame with your lat/lon points
lon <- c(-68,-66)
lat <- c(10, 11)
df <- as.data.frame(cbind(lon,lat))

#Leyendo base de datos
base <- read.table("collect_2.out",header=T)
names(base)[1]<- "ANO"
base$MAG <-as.numeric(sub("Mw","",base$MAG))
base$PROF <-as.numeric(sub("F","",base$PROF))

# Evento de mayor magnitud
bmax <- base[which(base$MAG==max(base$MAG)),]


# getting the map
mapsismo <- get_map(location = c(lon = bmax$LON, lat = bmax$LAT), zoom = 9,
                      maptype = "terrain", scale = 2)

# plotting the map with some points on it
ggmap(mapsismo) +  geom_point(data = base, aes(x = LON, y = LAT, fill = "red"), size = 2, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)+labs(title = "Sismo: Agosto 2014") + xlab("Longitud") + ylab("Latitud") +
	geom_line(data=Fallas,aes(x=long,y=lat,group=group),colour="red") +  geom_point(aes(x=bmax$LON,y=bmax$LAT),shape=8,size=5,color="red") 

