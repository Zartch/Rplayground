library(XML)  
library(httr)
library(pracma)

#1.1
#Definimos un target para el scraping
target <- handle("http://www.myne-us.com")
target$url

#Descargamos el HTML 
html <- GET( handle = target, path="/2010/08/from-0x90-to-0x4c454554-journey-into.html")  
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

links_text <- sapply(links_text,clearNulls)
links_url <- sapply(links_url,clearNulls)

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
  a <- length (grep("http:", url )) > 0 | length (grep("www", url )) > 0
  if(startsWith(url , "//"))
  {
    #♣print("h")
    url <- paste("http:",url, sep = "")
    return(url)
  }
  #print(url)
  if (a > 0) {
    #print("b")
    return(url)
  }
  #print("a")
  return(paste(domain,url, sep = ""))
}

#vectorizamos la función para poderla usar
abs_url<- Vectorize(to_absolute)

#aplicamos la función para poner nuestras url como absolutas
df3 <- mutate(df2, enlace = abs_url(enlace, target$url))


#Función para comprobar el status
get_http_status <- function(url){
  tryCatch(
    expr = {
      Sys.sleep(1)
      print(url)
      ret <- HEAD(url)
      print(ret$status_code)
      return(str(ret$status_code))
    },
    error = function(e){ 
      #usaremos este error para ver aquellas url que no son correctas por algún motivo
      return(5000)
    }
  )
}


df5$newcolum <- vapply(df5$enlace, get_http_status, character(1)) 
View(df5)

#vectorizamos la función para poderla usar
get_httpstatus <- Vectorize(get_http_status)

#comprobamos que es correcto solo con una parte del dataframe
head(df2,n=10)
df5<-head(df2,n=10)
#df6 <- mutate(df5, status = get_httpstatus(enlace))


#Aplicamos la función a todo el dataframe
df4 <- mutate(df3, status = get_httpstatus(enlace))




df4 <- mutate(df5, status = get_http_status(enlace))
str(df5)



str(df2)
#get_http_status("https://www.mediawiki.org")




df33 <- mutate(df5, link = to_absolute(enlace, target$url))
df44 <- mutate(df5, status = get_http_status(enlace))


so <- vapply(df5$enlace, get_http_status )

clean_url = function(x)

df5$enlace


get_http_status("www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=Attribution&widgetId=Attribution1&action=editWidget&sectionId=footer-3"  )
get_http_status("www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=BlogArchive&widgetId=BlogArchive1&action=editWidget&sectionId=sidebar-right-1")
get_http_status("//www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=BlogSearch&widgetId=BlogSearch1&action=editWidget&sectionId=sidebar-right-1")
get_http_status("//www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=Followers&widgetId=Followers1&action=editWidget&sectionId=sidebar-right-1")
get_http_status("//www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=PageList&widgetId=PageList1&action=editWidget&sectionId=crosscol")
get_http_status("//www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=Text&widgetId=Text1&action=editWidget&sectionId=sidebar-right-1")
get_http_status("http://www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=Text&widgetId=Text2&action=editWidget&sectionId=sidebar-right-1")
get_http_status("http://5d4a.wordpress.com/2010/08/02/smashing-the-stack-in-2010/")
get_http_status("http://advancedwindowsdebugging.com/ch06.pdf")
get_http_status("http://beej.us/guide/bgc/" )

get_http_status(to_absolute("//www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=BlogArchive&widgetId=BlogArchive1&action=editWidget&sectionId=sidebar-right-1" ))


ret <- HEAD("https://www6.software.ibm.com/developerworks/education/l-rubysocks/l-rubysocks-a4.pdf")
str(ret)
ret$status_code


s <- c("https:","http:")
any(startsWith("http://beej.us/guide/bgc/" , s))





df4 <- mutate(df2, status = get_http_status(enlace))




abs_url(df5$enlace, target$url)


df5$newurl = lapply(df5,abs_url(df5$enlace, target$url))
df5$enlace

library(dplyr)
to_absolute("//www.blogger.com/rearrange?blogID=451456",target$url )
to_absolute("/rearrange?blogID=4514563088285989046&widgetType=Attribution&widgetId=Attribution1&action=editWidget&sectionId=footer-3" , target$url )
to_absolute("www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=BlogArchive&widgetId=BlogArchive1&action=editWidget&sectionId=sidebar-right-1",target$url )
to_absolute("//www.blogger.com/rearrange?blogID=4514563088285989046&widgetType=BlogSearch&widgetId=BlogSearch1&action=editWidget&sectionId=sidebar-right-1",target$url )

df3 <- mutate(df2, url2 = to_absolute(enlace, target$url))
#df4 <- summarise(df2, enlace = to_absolute(enlace, target$url))




