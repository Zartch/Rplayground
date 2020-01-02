
#se pueden agrupar estos puntos?
set.seed(1234)
x<-rnorm(12, mean= rep(1:3,  each = 4), sd = 0.2)
y<-rnorm(12, mean= rep(c(1,2,1),  each = 4), sd = 0.2)
plot(x,y,col="blue",pch=19,cex=2)
text(x+0.05, y+0.05, labels= as.character(1:12))


#aproximación por aglomeración
#Custering jerárquico
#generamos un dendograma
df <- data.frame(x=x, y=y)
distxy <- dist(df)
cluster <- hclust(distxy)
plot(cluster)
#http://rpubs.com/gaston/dendograms



#aproximación por partición
#el algoritmo coloca unos centros, tagea los objetos contra el centro más cercano, coloca ahí el centro y repite

df<-data.frame(x,y)
#definimos los centros que queremos para obtener:
kmeansObj <- kmeans(df,centers = 3)
#Que cluster pertenece cada elemento
kmeansObj$cluster
#Donde estan los centros
kmeansObj$centers



#representación grafica del clustering
par(mfrow=c(1,2), mar=c(5,7,2,1))
#los datos
plot(x,y,col=kmeansObj$cluster,pch=19,cex=3)
#los centros
points(kmeansObj$centers,col=1:3,pch=3,cex=3,lwd=2)



