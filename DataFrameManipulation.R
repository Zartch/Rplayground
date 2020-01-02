
#esto es para que todos los resultados "aleatorios", sean iguales entre maquinas.
set.seed(666)

#sample desordena un vector
x <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x

#Escogemos de la fila 1 a la 5, DESORNDENADAS
x <- x[sample(1:5),]
x

#setea la fila 1 y la 3 de var2 NA, para coger el rango usar :
x$var2[c(1,3)] <- NA
x


#accedemos al dataset por filas
x[,1]

#Accedemos a un rango de una fila concreta
x[1:4, "var2"]


#Accedemos según condiciones
x[(x$var1 <= 3 & x$var3 > 11 ),]

#witch evita los NA
x[which(x$var2>6),]

#ordena el vector
sort(x$var1, na.last = TRUE, decreasing = TRUE)

#ordena el conjunto según la fila var1
x[order(x$var1),]

#install.packages("plyr")
library(plyr)
#orden
arrange(x, var2)
arrange(x, desc(var2))

#Añade columnas al dataframe, tiene que tener la misma cantidad de datos
x$var4 <-rnorm(3)

Y<- cbind(x,rnorm(5))
Y

#rnorm / dnorm / pnorm /
#https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/Normal



#añade filas al dataframe, le da igual los datos que tenga
Y<- rbind(Y, rnorm(6000))
#mete una fila de 4 y otra de 1
Y<- rbind(x, 4,1)
#el primer numero es el que toma por defecto
Y<- rbind(x, c(4,1))
Y<- rbind(x, c(6,2))
Y


#analisis de datos de baltimore https://data.baltimorecity.gov/culture-Arts/Restauranrs/k5ry-ef3g

if (!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

#inspeccionamos las n primeras/ultimas filas`
head(restData, n= 3)
tail(restData, n= 3)
    
#esto, esta mu bien.
summary(restData)

str(restData)

#quantfica datos que no sean faactores
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, na.rm = FALSE)


#Tablas para agrupar valores
table(restData$zipCode)

#genera una matriz de coincidencia de valores
table(restData$councilDistrict ,restData$zipCode)

#conocer quantos valores NA tenemos
sum(is.na(restData$councilDistrict)) #cantidad
any(is.na(restData$councilDistrict))  #boleano

#buscar NA en todas las columnas
colSums(is.na(restData)) # numero por columnas
all(colSums(is.na(restData))== 0 ) # boleano

#tablas con datos concretos
table(restData$zipCode %in% c("21212","21213"))

#filtrando el dataframe solo las lineas con los cp
head(restData[restData$zipCode %in% c("21212","21213"),])

#tamaño en bytes
object.size(restData)
#mega bytes
print(object.size(restData), units = "Mb")


#Secuencias
s1 <- seq(1,10, by=2)
s1

#equidistantes
s2 <- seq(1,10, length = 3); s2

#indice para sequenciar
x<- c(1,3,8,25,100) 
seq(along = x)


#librearia con datasets ejemplo
library(datasets)

data(mtcars)

mtcars$carname <- row.names(mtcars)
mtcars$carname
str(mtcars)

library(reshape2)

#juntamos columnas, mantenemos las de id y generamos nuevos registros para mpg y hp (cada una tiene una linea)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))

class(carMelt)

head(carMelt, n = 33)


#Tablas agregadas (Cuenta ocurrencias)
#para cada cilindrada "cyl" nos dice que valores 'hp' y 'mpg' y el recuento de estos
cylData <- dcast(carMelt, cyl ~ variable); cylData

#para cada cilindrada hará la media "mean"
cylData <- dcast(carMelt, cyl ~ variable, mean); cylData

#el paquete plyr permite hacer cosas parecidas a sql
library(plyr)
df1 <- data.frame(id = sample(1:10), x = rnorm(10))
df2 <- data.frame(id = sample(1:5), y = rnorm(10))
#junta por id INNER JOIN
arrange(join(df1,df2),id)

df3 <- data.frame(id = sample(1:5), z = rnorm(10))
dfList <- list(df1,df2,df3)
join_all(dfList)


list <- strsplit("punk is not death", " ")
list
unlisted <- unlist(list)
unlisted


