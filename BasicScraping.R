# CRAWLERS


# Obtenemos los enlaces  proporcionados por el crawler


# get all href attributes from html link tag
'<div class="offer-name">
  <a href="http://www.somesite.com" itemprop="name">Fancy Product</a>
    </div>' -> xData
library(httr)
library(xml2)
parsedHtml <- xmlParse(xData)

enlaces <- xpathSApply(parsedHtml, "//a",  xmlGetAttr, "href") 
enlaces

Products <- xpathSApply(parsedHtml, "//div[@class='offer-name']", xmlValue) 
Products

hrefs <- xpathSApply(parsedHtml, "//div/a", xmlGetAttr, "href")
hrefs

# Iteramos sobre los enlaces URL relativa/absoluta

# url relativa o absoluta
url <- "http://www.e-katec.com"
url1 <- "/video1.mp4"

?grep
grep("http", url)
grep("http", url1)

# URL Completa
a <- length (grep("http", url )) > 0 | length (grep("https", url )) > 0   # Absoluta
a
a1 <- length (grep("http", url1 )) > 0 | length (grep("https", url1 )) > 0 # Relativa
a1

#URL sin protocolos
b <- length(grep("www.e-katec.com", url)) > 0 | a     # Absoluta
b
b1 <- length(grep("www.e-katec.com", url1)) > 0 | a1   # Relativo
b1

library(httr)

# Si la URL es relativa, debemos  completarla para que GET sepa en qu? dominio debe buscar

handler <- handle("http://www.e-katec.com");
html <- GET(handle = handler, url = url);
html 

# Si la URL es absoluta, podemos hacer  GET directamente 

# download url content
html <- GET(url=url);  
html

# wait 2 seconds
Sys.sleep(2)

# SCRAPPING

library(XML)  
library(httr)

html <- GET("http://www.e-katec.com")  

content <- content(html, as = "text")
content

parsedHtml <- htmlParse(content, asText = TRUE)
parsedHtml


title <- xpathSApply(parsedHtml, "//title", xmlValue)
title

texts <- xpathSApply(parsedHtml, "//p", xmlValue)  
texts

links_text <- xpathSApply(parsedHtml, "//a", xmlValue)
links_text

links_url	<- xpathSApply(parsedHtml, "//a", xmlGetAttr, 'href')  
links_url

images_url <- xpathSApply(parsedHtml, "//img", xmlGetAttr, 'src')
images_url


# Prueba url imagenes relativa o no 
imagen_prueba <- images_url[1]
a <- length (grep("http", imagen_prueba )) > 0 | length (grep("https", imagen_prueba )) > 0
if(a==0) { 'URL RELATIVA' 
 }  else { 'URL ABSOLUTA'}

