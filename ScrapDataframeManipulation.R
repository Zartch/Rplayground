library(XML)  
library(httr)
library(pracma)

#1.1
#Definimos un target para el scraping
target <- handle("http://www.myne-us.com")
target <- handle("https://www.mediawiki.org")
target$url

#Descargamos el HTML 
html <- GET( handle = target, path="/2010/08/from-0x90-to-0x4c454554-journey-into.html")  
html <- GET( handle = target, path="/wiki/MediaWiki")  
html

#Parseamos como texto
content <- content(html, as = "text")
content

#parseamos nuestro texto a HTML (solucionando posibles fallos)
parsedHtml <- htmlParse(content, asText = TRUE)
parsedHtml

#1.2
#scrapeamos el titulo
title <- xpathSApply(parsedHtml, "//title", xmlValue)
title

#1.3
#xpathApply es para que los vectores no queden a null
#scrapeamos los textos de los enlaces
links_text <- xpathSApply(parsedHtml, "//a", xmlValue)
str(links_text)
#scrapeamos links de enlaces
links_url	<- xpathSApply(parsedHtml, "//a", xmlGetAttr, 'href')  
str(links_url)



#función para cambiar nulls por 'N/A'
clearNulls <- function(x){
  if (is.null(x) || x == "javascript:void(0)"){
    x <- 'N/A'
  }
  return(x) 
}

#aplicamosla función
links_text <- sapply(links_text,clearNulls)
links_url <- sapply(links_url,clearNulls)

#ahora sin nulos podemos quitar la lista y estos no desaparecerán
links_url <- unlist(links_url)
links_text <- unlist(links_text)

str(links_url)
str(links_text)

#1.4
#Creamos un dataframe con nuestros enlaces y nuestras url
df <- data.frame("texto"=links_text, "enlace"=links_url, stringsAsFactors=FALSE)
str(df) 

#limpiamos el df para que sea mas facil trabajar con el
clean_df <- df[(df$enlace != 'N/A'),]
clean_df

#contamos ocurrencias
occ = table(links_url)
str(occ)
occ <- as.data.frame(occ)
str(occ)

#cambiamos el nombre de la tabla para poder hacer un join por la columna
names(occ)[1] <- "enlace"
str(occ)



#juntamos la columna 
library(plyr)
df2 <- arrange(join(clean_df,occ),enlace) 
df2

#1.5

#ponemos todos los enaces en absoluto
to_absolute <- function(url,domain){
  #print(url)
  a <- length (grep("http", url )) > 0 | length (grep("www", url )) > 0
  if(startsWith(url , "//"))
  {
    url <- paste("http:",url, sep = "")
    return(url)
  }
  if(startsWith(url , "#"))
  {
    url <- domain
    return(url)
  }
  if (a > 0) {
    return(url)
  }
  return(paste(domain,url, sep = ""))
}

#vectorizamos la función para poderla usar
abs_url<- Vectorize(to_absolute)

#aplicamos la función para poner nuestras url como absolutas
df3 <- mutate(df2, abs_url = abs_url(enlace, target$url))


#Función para comprobar el status
get_http_status <- function(url){
  tryCatch(
    expr = {
      Sys.sleep(1)
      print(url)
      ret <- HEAD(url)
      print(toString(ret$status_code))
      return(toString(ret$status_code))
    },
    error = function(e){ 
      #usaremos este error para ver aquellas url que no son correctas por algún motivo
      return("i500")
    }
  )
}

#vectorizamos la función para poderla usar
get_httpstatus <- Vectorize(get_http_status)

#comprobamos que es correcto solo con una parte del dataframe
#head(df3,n=10)
#df5<-head(df3,n=10)
#df6 <- mutate(df5, status = get_httpstatus(enlace))


#Aplicamos la función a todo el dataframe
df4 <- mutate(df3, status = get_httpstatus(abs_url))

#podriamos aplicar la función con un vapply y no con un mutate
#df5$newcolum <- vapply(df5$enlace, get_http_status, character(1)) 
#View(df5)


#Aplicar Graficos
#2.1

#creamos un nuevo campo para saber directamente si son relativas o absolutas
df4$abs <- FALSE
df4[df4$abs_url == df4$enlace,]$abs <- TRUE
str(df4)


library(ggplot2)
#plot por frequencia
#preparamos el lienzo
par(mfrow = c(1,1))
#aplicamos la función qplot, que nos mostrará la frequencia
qplot(Freq, data=df4, color = abs,main="Frequencia enlaces relativos y absolutos")


#preparamos el lienzo
par(mfrow = c(2,2))
#historigramas absolutos/relativos
hist(subset(df4,abs==FALSE)$Freq, col="green",  main="Frequencia enlaces relativos")
hist(subset(df4,abs==TRUE)$Freq, col="red", breaks = 5,  main="Frequencia enlaces absolutos")


#2.2
library(stringr)
df5 <- df4
df5$interno <- mapply(str_detect, df5$abs_url,target$url)
#grafico de barras
barplot(table(df5$interno),col="wheat", main="Enlaces Internos")

#2.3
#grafico de tarta. 
pie(table(df5$status),col="wheat", main="Url http Status")
