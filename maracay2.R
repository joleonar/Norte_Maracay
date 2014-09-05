#Leyendo archivo select.out y extrayendo la primera fila 
fileName="select.out"
con=file(fileName,open="r")
line=readLines(con) 
n=grep("^ 2014  ",line)
select <-line[n]
close(con)

#Corta posiciones del año, mes , dia,  etc y crea un  data frame 
year <- substr(select,2,5)
month <- substr(select,7,8)
day <- substr(select,9,10)
hour <- substr(select,12,13)
minute <-  substr(select,14,15)
sec <- substr(select,17,20)
rloc <- substr(select,22,22)
latitude <- as.numeric(substr(select,24,30))
longitude <- as.numeric(substr(select,31,38))
depth <- as.numeric(substr(select,39,43))
agency <- substr(select,46,48)
number_st <- substr(select,49,51)
rms <- substr(select,52,55)      
mag1 <- as.numeric(substr(select,57,59))
typ_mag <- substr(select,60,63)

select.df <- data.frame(year,month,day,hour,minute,sec,rloc,latitude,longitude,depth,mag1)

#Separa los eventos en dos regions:"norte" y "sur" y asigna una nuva columna llamada region
select.df$region <- rep("",nrow(select.df))
select.df[which(select.df$latitude >=10.4),]$region <- "norte"
select.df[which(select.df$latitude < 10.4),]$region <- "sur"

#Convierte los datos año mes y dia a Date
select.df$Fecha <-as.Date(paste(select.df$year,select.df$month,select.df$day,sep="-"))

#Selecciona los eventos a partir de la fecha indicada
select.df <- subset(select.df,Fecha>as.Date("2014-08-15"))

#Evento de mayor magnitud de cada region
bn<-subset(select.df,region=="norte")
FN<-bn[which(bn$mag1==max(bn$mag1)),]
bs<-subset(select.df,region=="sur")
FS<-bs[which(bs$mag1==max(bs$mag1)),]
SM <- rbind(FN,FS)

library(ggplot2)
#No sismos día
ggplot(select.df, aes(x=Fecha,fill=region)) + geom_histogram(binwidth=1,colour="black") +facet_grid(region ~.) +
xlab("Fecha")+ylab("No sismos") + scale_fill_manual(values=c("blue", "green"))
	#scale_x_date(breaks=date_breaks(width="1 week"))

#No sismos magnitud
ggplot(select.df, aes(x=mag1,fill=region)) + geom_histogram(binwidth=.5, colour="black") + facet_grid(region ~.)+
  xlab("Magnitud")+ylab("No sismos") + scale_fill_manual(values=c("blue", "green"))


ggplot(select.df, aes(x=Fecha,fill=region)) + geom_histogram(binwidth=1,colour="black",alpha=.5,position="identity") +
xlab("Fecha")+ylab("No sismos") + scale_fill_manual(values=c("blue", "green"))
	#scale_x_date(breaks=date_breaks(width="1 week"))

ggplot(select.df, aes(x=mag1,fill=region)) + geom_histogram(binwidth=.5, colour="black",alpha=.2) + facet_grid(region ~.)+
  xlab("Magnitud")+ylab("No sismos") + scale_fill_manual(values=c("blue", "green"))

