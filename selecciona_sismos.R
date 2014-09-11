#Extrae la Informacion sismica
#Lee la base de datos
base <- read.table("sismos_2011-2013_t.txt",header=F)
colnames(base)<- c("year", "month","day","hour","minute","second","Loc","latitude","longitude",
	"depth","age","noest","rms","magnitude","typ_mag")
base$date <-as.Date(paste(base$year,base$month,base$day,sep="-"))

#Convierte la base en lista
base_F <- as.list(base)

library(ssBase)
library(maps)
library(ssEDA)

lat_c <- 10+7/60+56.08/3600
lon_c <- -(71+14/60+56.44/3600)
as.catalogue(base_F, catname="funvisis")
b <- subsetcircle(funvisis, centrelat=lat_c, centrelong=lon_c, 
                   maxradius=100,minmag=0)
as.catalogue(b,catname="lagunillas")
lagun <- as.data.frame(lagunillas)
write.table(lagun,file="lagunillas.txt",quote=FALSE,sep="\t",row.names=FALSE)

write.catalogue(lagunillas,file="lagunillas.txt",eol="\n")


#Prueba de graficos ejemplo
data <- cbind(latitude=c( 10, 20, 30, 40, 35, 32),
              longitude=c(172.20,  177.00, 175.50, 178.42, 179.97, 181.21),
              depth=c(20, 30, 45, 12, 300, 339),
              magnitude=c(7.8, 7.8, 7.6, 7.4, 7.4, 7.9))

epicentres(data, usr=c(172, 182, -42, -28), cex=2, mapname="nz")
par(par.reset)