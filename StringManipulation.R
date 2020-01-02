

###
grep()
nchar()
paste()
sprintf()
substr()
strsplit()
regex()
gregexpr()

##
##Pattern matching and replacement
?grep
#return positions mattched
grep("b+", c("abc", "bda", "cca a", "abd"), perl=TRUE, value=FALSE)
#return strings mattched
grep("b+", c("abc", "bda", "cca a", "abd"), perl=TRUE, value=TRUE)



#recuento de letras
str <- "Ni tan sols de signes vivim, del so dels signes"
?nchar
nchar(str)

nchar(c("ni","tan","sols"))


#Juntar strings
paste("ni","tan","sols", sep= "-")



#Format String
sprintf()
sprintf("%s scored %.2f percent", "Matthew", 72.3)



#substring
substr()
str <- "Ni tan sols de signes vivim, del so dels signes"
substr(str, 4, 16)
substr(str, 5, 10)


#split
strsplit(str, " ") #devuelve un vector de vectores
unlist(strsplit(str, " "))


#REGEX
str <- "Line 129: No a la vida del mot, si no la pell del so! 37"
out <- regexpr("\\d+",str)
out
#Respuesta:
#(position))first ocurrence
#(lengt)number of chars maching parent (R starts by 1)
#(find)
#?substr(str,out[1],out[2])


#texto
tolower("MAYUS")
toupper("minus")

#replacment
sub("pattern_search", "replacement_string" , "Some pattern to find pattern_search and replaced by replacement_string")


library(stringr)

#trim
str_trim("   ni tan sols   ")



