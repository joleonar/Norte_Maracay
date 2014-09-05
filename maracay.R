library(ggplot2)
base <- read.table("collect_2.out",header=T)
names(base)[1]<- "ANO"
base$MAG <-as.numeric(sub("Mw","",base$MAG))
base$PROF <-as.numeric(sub("F","",base$PROF))

base$region <- rep("",nrow(base))

base[which(base$LAT >=10.4),]$region <- "norte"
base[which(base$LAT < 10.4),]$region <- "sur"
base$Fecha <-as.Date(paste(base$ANO,base$MES,base$DD,sep="-"))

#Evento de mayor magnitu de cada region
bn<-subset(base,region=="norte")
FN<-bn[which(bn$MAG==max(bn$MAG)),]
bs<-subset(base,region=="sur")
FS<-bs[which(bs$MAG==max(bs$MAG)),]
SM <- rbind(FN,FS)


#Histograma no.sismos por dia en cada region
ggplot(base, aes(x=Fecha,fill=region)) + geom_histogram(binwidth=1,position="dodge",colour="black") +
  xlab("Fecha")+ylab("No sismos") + scale_fill_manual(values=c("white", "grey45"))
#geom_vline(xintercept=as.numeric(c(FN,FS))+0.25)

#Profundidad vs Latitud
ggplot(base, aes(x=LON, y=LAT,colour=region))+geom_point(size=4)+
  geom_point(aes(x=SM$LON,y=SM$LAT,colour=SM$region),shape=17,size=5) 

#Profundidad vs Latitud
ggplot(base, aes(x=LAT, y=-PROF,colour=region))+geom_point(size=4)+
  geom_point(aes(x=SM$LAT,y=SM$PROF,colour=SM$region),shape=17,size=5)

#Profundidad vs Longitud
ggplot(base, aes(x=LON, y=-PROF,colour=region))+geom_point(size=4)+
  geom_point(aes(x=SM$LON,y=SM$PROF,colour=SM$region),shape=17,size=5)


#Histogram mag - freq x region
ggplot(base, aes(x=MAG,fill=region)) + geom_histogram(binwidth=.5, position="dodge",colour="black") + 
  xlab("Magnitud")+ylab("Frecuencia") + scale_fill_manual(values=c("white", "grey45"))

#Histograma  Mag-Frec sencillo
ggplot(bn, aes(x=MAG,fill=region)) + geom_histogram(binwidth=.5,colour="black", fill="gray") +
  xlab("Magnitud")+ylab("No sismos")

#Density plot with histogram 
ggplot(base, aes(x=MAG)) + 
  geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                 binwidth=.1,
                 colour="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +xlab("Magnitud")+ylab("Densidad")



#Density plot of two regions
ggplot(base, aes(x=MAG, fill=region)) + geom_density(alpha=.3)


plot(base$Fecha,base$MAG, pch="o", main="Sismicidad 2014",xlab="1982-1989",
     ylab="Magnitude", cex.lab=1.0,cex.axis=0.5)

b <- hist(base$MAG, breaks=seq(0,5,0.1),plot=FALSE)


# Plot the linear frequecy histogram
#par(mfrow=c(2,1))
plot(b,freq=TRUE, main="",xlab="Magnitud",ylab="Frecuencia", cex.lab=0.7,cex.axis=0.6)

