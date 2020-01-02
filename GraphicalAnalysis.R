#Analisis de datos con graficos

#download.file("https://github.com/humbertcostas/courses/blob/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv","avgpm25.csv")
download.file("https://raw.githubusercontent.com/humbertcostas/courses/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv","avgpm25.csv")

#read the CSV
pollution <- read.csv("avgpm25.csv", colClasses = c("numeric","character","factor","numeric","numeric"))

#explore csv
head(pollution)
summary(pollution$pm25)



#Boxplot: Donde estan situados los valores
#lo que esta dentro de la caja es el 50%
#lo que esta dentro del 99% es las rayas
#lo que queda fuera de el 99% queda reflejado en puntitos
boxplot(pollution$pm25,col = "blue")
#con abline dibujamos lineas rectas en el catual grafico 
?abline
abline(h=12)
#multiple boxplot
boxplot(pm25 ~ region, data = pollution, col= "red")

data(airquality)
air <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, air, xlab = "Month", ylab = "Ozone")


#Histograma: por cada valor/rango indica la frequencia de cada valor
hist(pollution$pm25, col = "green", breaks = 50)
#añade la frequencia visible en el eje de cordenadas
rug(pollution$pm25)
#lwd = ancho de la linea
abline(v=12, lwd=5)
abline(v=median(pollution$pm25), col="magenta", lwd=4)
#multiple histogramas
#•preparamos el grafico para que pinte los gaficos sefinidos en mfrow con los margener definidos en mar
par(mfrow = c(2,1), mar = c(4,4,2,1))
#separamos el dataframe en east/west y piontamos esos 2 graficos sobre pm25
hist(subset(pollution,region=="east")$pm25, col="green")
hist(subset(pollution,region=="west")$pm25, col="red")



#Grafico de barras
barplot(table(pollution$region),col="wheat", main="Obs. Region")

barplot(height = c(10,6,8,4,5))
#Aañadimos titulo a cualquier grafico 
title(main="some title")



#Grafico tarta
library(MASS);
pie(table(pollution$region))


#grafico de puntos
?plot
#plot usa el grafico mas singificativo que le parece
#con 2 cordenadas usa el de puntos
plot(pollution$longitude,pollution$latitude)
#con solo 1 barplot o boxplot 
plot(pollution$region)
#interesante con el csv entero
plot(pollution)


#grafico de dispersión con color
with(pollution,plot(latitude,pm25,col=region))
abline(h=12,lwd=2,lty=2)


#Dispersión multiple
par(mfrow=c(1,2), mar=c(5,7,2,1))
with(subset(pollution,region=="east"), plot(latitude,pm25,main="East"))
with(subset(pollution,region=="west"), plot(latitude,pm25,main="West"))





#GRAFICOS MAS BONITOS  (para comunicar resultados)
library(datasets)
data(cars)
with(cars,plot(speed,dist))
abline(h=60)
#añadir leyenda
legend("topleft","some legend",pch =1)


library(lattice)
data(state)
state <- data.frame(state.x77,region= state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))


#esta permite hacer transformaciones sobre los graficos
library(ggplot2)
data(mpg)
qplot(displ,hwy,data=mpg)


#añadir capas extra a un mismo grafico
data(airquality)
air <- transform(airquality, Month = factor(Month))

with(air, plot(Wind,Ozone, main="Ozone and Wind in New York City"))
with(subset(air, Month==5), points(Wind,Ozone,col="blue"))
with(subset(air, Month!=5), points(Wind,Ozone,col="red"))
legend("topright", pch=1,col=c("blue","red"), legend = c("May","Other Months"))

#varios graficos con titulillos, colores y transparencia
par(mfrow=c(1,3),oma=c(0,0,2,0))
with(air,{
  plot(Wind,Ozone, main = "Wind and ozone")
  plot(Solar.R, Ozone)
  plot(Temp, Ozone, col = rgb(0.3,0.1,0.6,0.5))
  mtext("Cosas", outer = TRUE)
})


#para exportar a ficheros:
pdf(file="myplot.pdf")
png(file="myplot.png")
jpeg(file="myplot.jpeg")
#...
#haces tu grafico
dev.off()#escribe en el fichero



#Para hacerlos bonitos
colors()#los ~700 colores de R
#grDevices pakage gestión de colores

#♥paletas predefinidas
library(RColorBrewer)
cols<- brewer.pal(3,"BuGn")
cols
pal <- colorRampPalette(cols)
data(volcano)
image(volcano, col = pal(20))


#varios graficos con titulillos









