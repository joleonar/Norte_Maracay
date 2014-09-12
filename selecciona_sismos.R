# Extrae la Informacion sismica dentro de una región circular
setwd("~/Norte_Maracay_2014")

#Lee la base de datos
base <- read.table("FUNVISIS_SD_VEN.txt",header=F)
colnames(base)<- c("year", "month","day","hour","minute","second","latitude","longitude",
	"depth","magnitude")

base2 <- read.table("sismos_2011-2013_t.txt",header=F)
colnames(base2)<- c("year", "month","day","hour","minute","second","Loc","latitude","longitude",
	"depth","age","noest","rms","magnitude","typ_mag")
#base$date <-as.Date(paste(base$year,base$month,base$day,sep="-"))

#Integracion de las dos bases con nr de columnas diferentes
columnas <- c("year", "month","day","hour","minute","second","latitude","longitude",
	"depth","magnitude")

base_1a <- base[,columnas]  # periodo 1530 - 2010
base_1b <- base2[,columnas] # periodo 2011 - 2013
base_F  <- rbind(base_1a,base_1b)

#selecciona los sismos desde 2004 
base_F2 <- subset(base_F,year>=2004)
#Convierte la base en objeto tipo lista para poder utilizar librerias de Corssa
base.list <- as.list(base_F2)

library(ssBase)
library(ssEDA)
as.catalogue(base.list, catname="funvisis",dp.second=1)

#Coordenadas de Lagunillas
lat_c <- 10+7/60+56.08/3600
lon_c <- -(71+14/60+56.44/3600)
#Seleccion de sismos dentro de un circulo centro C y radio R
b <- subsetcircle(funvisis, centrelat=lat_c, centrelong=lon_c, 
                   maxradius=100,minmag=4.5)
as.catalogue(b,catname="catal")

lagunillas$time2 <- format(lagunillas$time)

write.table(lagunillas,file="lagunillas.txt",quote=FALSE,sep="\t",row.names=FALSE)

#Formato de datos para archivo de salida
year <- years1(catal$time)
month <- months1(catal$time)
day <- days1(catal$time)
hhmmss <- hrs.mins.secs(catal$time)
hour <- hhmmss$hour
minute <- hhmmss$minute
second <- hhmmss$second


catal_f=data.frame(year=year,month=month, day=day, hour=hour,minute=minute,second=second)
catal_f <- cbind(catal_f,latitude=catal$latitude, longitude=catal$longitude,depth=catal$depth,
	magnitude=catal$magnitude)

write.table(catal_f,file="catal_f.txt",quote=FALSE,sep="\t",row.names=FALSE)

library(maps)
library(mapdata)
map("worldHires","Venezuela", xlim=c(-73,-68), ylim=c(5,13), col="gray90", fill=TRUE)
points(catal_f$longitude, catal_f$latitude, pch=19, col="red", cex=0.5) 

