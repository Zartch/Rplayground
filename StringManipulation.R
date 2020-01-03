

#↨Tostring
a <- 1234
as.character(a)
toString(a)

#Format String
sprintf()
sprintf("%s scored %.2f percent", "Matthew", 72.3)

#texto
tolower("MAYUS")
toupper("minus")


#trim
library(stringr)
str_trim("   ni tan sols   ")


#recuento de letras
str <- "Ni tan sols de signes vivim, del so dels signes"
?nchar
nchar(str)

nchar(c("ni","tan","sols"))


#Juntar strings
paste("ni","tan","sols", sep= "-")


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



##Pattern matching
?grep
#return positions mattched
grep("b+", c("abc", "bda", "cca a", "abd"), perl=TRUE, value=FALSE)
#return strings mattched
grep("b+", c("abc", "bda", "cca a", "abd"), perl=TRUE, value=TRUE)


#replacment
sub("pattern_search", "replacement_string" , "Some pattern to find pattern_search and replaced by replacement_string")



library(stringi)

# NOT RUN {
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "a")
str_detect(fruit, "^a")
str_detect(fruit, "a$")
str_detect(fruit, "b")
str_detect(fruit, "[aeiou]")

# Also vectorised over pattern
str_detect("aecfg", letters)

# Returns TRUE if the pattern do NOT match
str_detect(fruit, "^p", negate = TRUE)
# }
