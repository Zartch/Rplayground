library(XML)  
library(httr)
library(pracma)

#1.1
target <- handle("http://www.myne-us.com")
target$url


html <- GET( handle = target, path="/2010/08/from-0x90-to-0x4c454554-journey-into.html")  
html

content <- content(html, as = "text")
content

parsedHtml <- htmlParse(content, asText = TRUE)
parsedHtml

#1.2
title <- xpathSApply(parsedHtml, "//title", xmlValue)
title

#1.3
links_text <- xpathSApply(parsedHtml, "//a", xmlValue)
str(links_text)

links_url	<- xpathSApply(parsedHtml, "//a", xmlGetAttr, 'href')  
str(links_url)




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
  a <- length (grep("http", url )) > 0 | length (grep("www", url )) > 0
  s <- c("https:","http:")
  if(!any(startsWith(url , s)))
  {
    print("h")
    return(paste("http:",url, sep = ""))
  }
  if (a > 0) {
    print("b")
    return(url)
  }
  print("a")
  return(paste(domain,url, sep = ""))
}

library(dplyr)
to_absolute("//www.blogger.com/rearrange?blogID=451456")
df3 <- mutate(df2, url2 = to_absolute(enlace, target$url))
#df4 <- summarise(df2, enlace = to_absolute(enlace, target$url))


#añadimos el status
get_http_status <- function(url){
  if (!is.null(url)){
    Sys.sleep(3)
    print(url)
    ret <- HEAD(to_absolute(url))
    
    return(ret$status_code)
  }
  return("")
}
df4 <- mutate(df2, status = get_http_status(enlace))


head(df2,n=10)
df5<-head(df2,n=10)
df4 <- mutate(df5, status = get_http_status(enlace))
str(df5)



str(df2)
#get_http_status("https://www.mediawiki.org")


get_http_status_2 <- function(url){
  tryCatch(
    expr = {
      #Sys.sleep(3)
      print(url)
      ret <- HEAD(url)
      print(ret$status_code)
      return(ret$status_code)
    },
    error = function(e){ 
      return("")
    }
  )
}

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





