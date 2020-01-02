# Introducción a R ----------------------------

var_a <- "hola"
var_b <- 1:10
var_c <- c(1,4,6)
var_d <- seq(2,3,by=0.5)
var_e <- rep(1:2,times=3)
var_f <- rep(1:2,each=3)


im.true <- T || FALSE
im.false <- TRUE && F
myBool <- xor(im.true, !im.false)

# Operación no vectorizada (tradicional)
for (i in 2:length(var_b)) {
  aux <- paste(var.a, var_b[i], sep = " ")
  print(aux)
}

# Operación Vectorizada
aux <- paste(var.a, var_b, sep = "")
print(aux)

# Realizamos operaciones aritméticas
var_a1 <- 50 + 10

var_a1              # esto si estamos en una consola R
print(var_a1)       # esto si estamos en un script R

# Operaciones con variables
var_a2 <- var_a1 + 20
var_a2

rm(i)   # Elimina variables

## Tipos de datos --------------------------
# Tipos primitivos o Básicos
my.double <- 5			# numero 5: real [numeric]
my.integer <- 3L		# numero 3: entero [integer]
my.logical <- TRUE		# Valor cierto: booleano [logic]
my.character <- "hola"		# Tecto "hola": string [character]
my.factor <- as.factor(c("H","M")) 	# Etiqueta "H": [factor]

my.double / 2
my.integer
my.factor

# Obtener el tipo de datos
class(my.integer)
class(my.factor)

# Vectores o Arrays
v1 <- c(5,11,13,17,23)    	# Vector/array de "numerics" de forma explícita
class(v1)

is.vector(v1)

my.vector <- 10:100		# Crear un vector, con una secuéncia
length(my.vector)

my.vector[c(5, 40)]
my.vector[c(5:40)]


# Matrices

m1 <- matrix(1:12, nrow = 4, ncol = 3) 	#Matrix 4 f x 3 c
m1
m1[2,] 		# acceso a una fila (devuelve un vector)

m1[,3] 		# acceso a una columna (devuelve un vector)

m1[2,3]		# acceso a una posición (devuelve un valor)

m1[c(1,2),]	# acceso a una submatriz (devuelve una matriz)
m1[c(1:3),]

# Data Frames
d1 <- data.frame(Columna1 = c(1,3,5,7,9),
		 Columna2 = c("a","b","c","d","e"),
		 Columna3 = c(TRUE, FALSE, FALSE, TRUE, TRUE),
		 stringsAsFactors = FALSE)
#rm(d1)

d2 <- data.frame(Columna1 = c(1,3,5,7,9),
		 Columna2 = c("a","b","c","d","e"),
		 Columna3 = c(TRUE, FALSE, FALSE, TRUE, TRUE),
		 stringsAsFactors = TRUE)  

d1$Columna2
d2$Columna2

# stringsAsFactors, Si no se pone, por defecto TRUE

d1

# Acceso a una fila
d1[3,] 	

# Acceso a una posición
d1[2,"Columna2"]  

# Acceso a una columna, igual que [,1]
d1$Columna1   

d2

# Accesos según condiciones
d1[d1$Columna1 == 9 | d1$Columna3 == FALSE,]

class(d1)
# Por defecto, los Data.Frames entienden los character como
# factors. Podemos evitarlo con "stringsAsFactors = FALSE"

# Listas

my.list <- list(Element1 = c(1,2,3), 
	              Element2 = c("a","b","c","d"), 
	              OtherElement = TRUE, 
	              Another = 3:7)

my.list

# Acceso a elem. = my.list[[2]] = my.list$Element2
my.list[["Element2"]]  

# Acceso a posición = my.list[[c(2,3)]] = ...
my.list[[2]][[3]]	

# Numero de elementos (que no valores)
length(my.list)  	

## Operaciones Básicas ---------------------------

# Suma / Resta
5 + 6
5 - 6

# Multiplicación / División
5 * 10.8
512 / 128

# Potencias
sqrt(81)
3^2

# Módulo
513 %% 64

# Operaciones lógicas
TRUE & FALSE

all(TRUE, TRUE, FALSE)  

my.vector.of.booleans <- c(T,T,T,F)
all(my.vector.of.booleans)

any(TRUE, TRUE, FALSE)

!5 %in% c(4,7,2,10,5,3)

# Membresía
5 %in% c(4,7,2,10,5,3)


# Vectorización ---------------------

v3 <- c(5, 11, 29, 37, 51)
v3

m2 <- matrix(1:12, nrow= 4, ncol = 3)
m2
m2 * 4

# Aplica una función por filas (1), además sum, prod, sqrt,...
apply(m2, 1, sum)	

# Aplica por columnas (2)
apply(m2, 2, prod)	
apply(m2, 2, sqrt)

sapply(v3, function(x) {
  x^3
})

sapply(v3, function(x) {
  if (x %% 10 > 3) x^3
  else 0
})

## Creación de funciones ----------------

my.square <- function(param1) {
  return(param1^2)
}

my.square(3)			# Aplica la función

class(my.square)		# Ver la clase de la función

my.square			# Ver el código de una función R

# Puede suceder que una función de una librería corresponda
# a una llamada externa, y no podámos ver el código

r2str <- function(risk) {
  if (risk <= 5) return("low")
  ifelse (risk < 7.5, "medium", "high")
}

r2str		# Código función
r2str(2)

r2str(c(1,2,3))	# Error, ya que NO está vectorizada, no le podemos pasar un vector

?Vectorize	# Este tipo de comentario (?) da acceso al manual, con (??) a todo

?sum
# lo que contenga ese texto ??sum --> Todo lo que el manuel contenga sum
??sum

risk2string <- Vectorize(r2str)

risk2string(2)

risk2string(6)

risk2string(8)

risk2string(c(1,2,3,4,5,6,7,8,9,10))



# Preguntas

# Comentario multilínea Ctrl + FlechaArriba + C













