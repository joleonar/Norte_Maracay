library(ggplot2)
library(rgdal)
library(rgeos)
library(maptools)
library(ggmap)

base <- read.table("collect_2.out",header=T)
names(base)[1]<- "ANO"
base$MAG <-as.numeric(sub("Mw","",base$MAG))
base$PROF <-as.numeric(sub("F","",base$PROF))

esta <- read.table("ESTACIONES.txt",header=T)

Fallas <- readShapeLines("./Venezuela/2012_FALLASactivas_Vzla.shp")
Ph <- readShapePoly("./Venezuela/VEN3M11ESTADOS.shp")
Ar <- Ph[Ph$ESTADO=="ARAGUA",]
Cr <- Ph[Ph$ESTADO=="CARABOBO",]
Mr <- Ph[Ph$ESTADO=="MIRANDA",]
Df <- Ph[Ph$ESTADO=="DF",]

# Agrega poligonos
p <- ggplot()+geom_polygon(data = Ph,aes(x = long,y = lat,group = group),fill = "darkseagreen",colour="black")
#	geom_polygon(data=Cr,aes(x = long,y = lat,group = group),fill="yellow2",colour="black") +
#	geom_polygon(data=Mr,aes(x = long,y = lat,group = group),fill="yellow2",colour="black") +
#	geom_polygon(data=Df,aes(x = long,y = lat,group = group),fill="yellow2",colour="black") +

# Fallas y Estaciones
p <- p + geom_line(data=Fallas,aes(x=long,y=lat,group=group),colour="red")
p <- p + coord_fixed() + geom_point(aes(x =LON ,y = LAT),data = esta, shape=17,colour="yellow",size = 6)
p <- p + geom_text(data=esta,aes(x=LON,y=LAT),label=esta$COD,vjust=-1.6,size=3)

# Sismos
#p <- p + coord_fixed() + geom_point(aes(x = LON,y = LAT,size = MAG),data = base,alpha = 0.80)
p <- p + labs(title = "Sismo: Agosto 2014") + xlab("Longitud") + ylab("Latitud")

# Parametros del grafico
p <- p + theme(panel.background = element_rect(size = 2,colour = "black",fill = "lightsteelblue2"),
axis.ticks = element_line(size = 2),panel.grid.major = element_line(colour = "gray80",linetype = "dotted"),
panel.grid.minor = element_line(colour = "gray90",linetype = "dashed"),axis.title.x = element_text(size = rel(1.2),
face = "bold"),axis.title.y = element_text(size = rel(1.2),face = "bold"),plot.title = element_text(size = 20,
face = "bold",vjust = 1.5))
print(p)
