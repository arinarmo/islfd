## Instalación de paquetes

# Para instalar paquetes del CRAN
install.packages("dplyr")
install.packages("file:///tmp/dplyr.tgz", repos=NULL)

# Si no hay una versión binaria disponible, `install.packages` compilará 
# las fuentes indicadas, también se encarga de resolver dependencias de paquetes.

# Para instalar todos los paquetes en un task view
install.packages("ctv")
library("ctv")
install.views("NaturalLanguageProcessing")

# El paquete `devtools` nos permite instalar un paquete directamente desde su 
# fuente en github, bitbucket, svn, etc.
install.packages("devtools")
library("devtools")
install_github("hadley/ggplot2")

## Ayuda

# R ofrece una manera de acceder a la documentación de una función a través de `?`.
# Es común que las funciones que un paquete expone estén documentadas, así como 
# encontrar documentación de un paquete en general

?library
?devtools

# También podemos obtener ayuda acerca de un operador
?`+`

# Además, algunos paquetes con funcionalidad compleja ofrecen vignettes, 
# con quickstarts o tutoriales acerca de su uso
vignette(package = "dplyr")
vignette("databases", package = "dplyr")

# Si todo lo demás falla, existe una comunidad activa en stack overflow 
# para todo lo relacionado con R como lenguaje, así como cross validated 
# (http://stats.stackexchange.com/) para todas las preguntas de índole estadística.

## Tipos de datos

# Existen 6 tipos de datos "atómicos" en R
class(TRUE)
class(42)
class(42L)
class(4 + 2i)
class("42")
class(charToRaw("B"))

# Adicionalmente, un factor puede ser usado para expresar variables categóricas.
# Un factor puede ser ordenado.
class(factor(1))
?ordered

# NULL representa al objeto nulo. Indica que un valor o función no está definida
is.null(NULL)
is.null(NA)
1 == NULL

# NA representa datos faltantes, es una constante de longitud 1. 
# NA puede ser cualquier tipo de dato excepto "raw". NA no es NULL, y 
# existen comportamientos predefinidos para lidiar con datos faltantes.
NA + 1
sum(c(1, 2, 3, NA), na.rm = TRUE)
na.fail(c(1, 2, 3, NA))


## Tipos de objeto

# Existen muchos tipos de objeto en R, y dos maneras comunes de definir tipos 
# de objeto (clases S3 y S4). Sin embargo, los tipos más comunes son 
# vectores, listas,matrices y data frames.

# No existe el tipo de objeto "escalar" en R, el dato atómico es el vector.
length(1)

## Vectores

# Un vector sólo puede contener un tipo de dato. Si un elemento de otro tipo se
# concatena a un vector, el vector resultante es del tipo más general. 
# La manera más fácil de construir vectores es a través de `c`
c(TRUE, FALSE)
c(TRUE, FALSE, 2)
c(TRUE, FALSE, 2, "")

# Se puede acceder de manera posicional a los elementos de un vector
v <- 10:13
v[[1]]
v[c(1:2)]

# Los elementos de un vector pueden ser nombrados y también accedidos de ese modo
names(v) <- c("uno", "dos", "tres")
v[["uno"]]

## Listas

# Una lista puede contener cualquier tipo de objeto y combinar distintos tipos de datos.
l <- list(1, TRUE, "...")
l

# Al igual que un vector, se puede acceder de manera posicional o a través de 
# nombre. A diferencia de un vector, se puede acceder usando el operador `$`
names(l) <- c("uno", "true", "ellipsis")
l$uno

# Se pueden borrar elementos de una lista refiriendolos a `NULL`
l$true <- NULL
l

## Matrices

# Una matriz es como un vector, aunque con dos dimensiones. 
# Las matrices se llenan y se despliegan en orden de columnas.
m <- matrix(c(1,2,3,4), nrow = 2)
m
m[1, 2]
# Al igual que un vector, sólo pueden contener un tipo de dato

# Las columnas y las filas se pueden nombrar por separado
colnames(m) <- c("col1", "col2")
rownames(m) <- c("row1", "row2")
m
m["row1", "col1"]

## Matrices
# `dim`, `nrow` y `ncol` nos dan las dimensiones de una matriz
dim(m)
nrow(m)
ncol(m)

## Data Frames

# Un data frame es una colección de variables, que se comporta como matriz o
# como lista de columnas, según la función que se le aplique.
df <- data.frame(col1 = c(1,2), col2 = c("tres","cuatro"))
df
dim(df)
df$col1
names(df)

# Un data frame puede contener distintos tipos de datos

## Factores
f <- factor(c("A veces", "Siempre", "A veces", "Nunca"), 
            levels = c("Nunca", "A veces", "Siempre"))
f
as.ordered(f)

nms <- c("John", "Paul", "George", "Ringo")
df <- data.frame(nombre=nms, sexo=f, stringsAsFactors = F)
df
summary(df)

## Operaciones básicas

# Aritméticas
7 + 2
7 - 2
7 * 2
7 / 2
7 %% 2
7 %/% 2
7 / 2
7 ^ 2
7 ** 2
7 %/% 2
7 %% 2

# Lógicas
TRUE & FALSE
TRUE | FALSE
!TRUE

# Todas estas operaciones se pueden aplicar a vectores, y se aplicarán 
# componente a componente, repitiendo el vector más pequeño como sea necesario
c(1, 2) + c(3, 0)
c(2, 1) * c(2, 2)
c(1, 2, 3, 4) ^ c(2, 3)

## Estructuras de control
# `if`, `else`, `for`, `while`, `break`, `next` funcionan como en otros lenguajes.
for(i in 1:5) {
  if(i < 3) {
    print(i)
  } else {
    print(6 - i)
  }
}


## Funciones
# Para definir una función
do.something <- function(x, y) {
  x + y
}
do.something(10, 3)

# Valores por defecto en argumentos
do.something <- function(x, y=1) {
  x + y
}
do.something(10)
do.something(y=3, 10)

# Argumentos adicionales, no definidos
do.something <- function(x, y=1, ...) {
  x + y + sum(...)
}
do.something(10, z=3, a=5)
# `...` sólo puede ser usado como argumento de una función

# `do.call` llama la función especificada con una lista de argumentos
args <- list(x=4, y=3, z=1)
do.call(do.something, args)
do.call("do.something", args)


## Attach, Detach
# `attach` añade un objeto a `search()`. Este objeto puede ser un environment,
# lista o data frame, permitiendo acceso a su lista de nombres en el environment en el que se esta trabajando.
attach(mtcars)
head(mpg)
detach(mtcars)

## Attach, Detach
# `library` funciona como `attach`, para quitar un paquete podemos usar `detach`
library(pryr)
detach("package:pryr", unload=T)
search()

## Vectorización
# Muchas funciones base en R incluyen llamadas a `.Internal`, `.Primitive` o `.Call`
sum
paste

## Vectorización
# Estas funciones de hecho son llamadas a rutinas de C o Fortran, por razones
# de velocidad. Esto a menudo quiere decir que es más rápido llamar una función
# predefinida que replicarla
for.sum <- function(m) {
  s <- 0
  for(i in v) s <- s + i
  s
}

v <- matrix(rbinom(1e6, 100, 0.5), ncol = 1e3)
system.time(rep(for.sum(v), 1e6))
system.time(sum(v, 1e6))

# Para reducir el overhead de llamar repetidamente las funciones de C, es útil 
# pensar en aritmética de vectores y en utilizar funciones primitivas, en lugar 
# de escribir ciclos `for`. Esto es especialmente un problema si R tiene que 
# cambiar el tamaño de un objeto en cada paso del ciclo

# Otra manera de "vectorizar" es utilizar funciones de la familia `apply`. 
# En este caso no siempre se están reduciendo las llamadas a funciones internas,
# pero se está asegurando que no haya efectos secundarios y el código se vuelve más leíble

# vectorizado
apply(v, MARGIN=2, FUN=mean)[1:5]

# no vectorizado
m <- nrow(v)
n <- ncol(v)
means <- rep(0, n)
for(j in 1:n) {
  col.sum <- 0
  for(i in 1:m) {
    col.sum <- col.sum + v[i, j]
  }
  means[j] <- col.sum/m
}
means[1:5]

# Por último, si la función a aplicar a una secuencia se va a utilizar sólo una
# vez, y es fácil de leer, se puede utilizar una función anónima.
apply(v, MARGIN=2, FUN = function(col) quantile(col, 0.3) )[1:5]

## Paquetes útiles
# Hay paquetes que mejoran algunos aspectos de R en general, y ayudan a evitar 
# algunas deficiencias de la sintáxis. Todos los paquetes que incluyo en esta 
# sección están en el CRAN.

## Magrittr
# Magrittr añade un operador con funcionalidad de pipe
library(magrittr)
3 %>% sum(1) %>% prod(2) 
prod(2, sum(1, 3))
data.frame(a=rnorm(5, 5, 1), b=runif(5)) %>%
  scale() %>%
  summary()

# Añade también otros operadores con funcionalidad similar pero resultado 
# distinto, por ejemplo, `%<>%` funciona como `%>%` pero actualiza el nombre 
# en el lado izquierdo con el resultado de la expresión, ver `?magrittr` para más detalles.

## Lubridate, Zoo
# `lubridate` y `zoo` añaden mejor soporte para fechas. Aunque R incluye soporte para fechas, estos paquetes lo mejoran.
library(zoo)
library(lubridate)
interval(as.Date("2016-01-01"), Sys.Date()) / months(1)
as.Date("2016-01-31") %m+% months(0:4)
as.yearmon(Sys.Date()) 

# `yearmon` además puede ser operado como numérico, con el entero representando un año completo
as.yearmon(Sys.Date()) + 1/12
as.Date("2016-01-31") %m+% months(0:4) %>% as.yearmon() + 1

## Pryr
# `pryr` incluye algunas funciones para lidiar con los componentes internos de 
# R (como `where`). De sus funciones más útiles es partial
library(pryr)
my.mean <- partial(mean, na.rm=T)
my.mean(c(1, 2, 3, NA, 4))

## Jsonlite
# `jsonlite` añade la capacidad de leer y serializar JSON a partir de objetos de R. 
library(jsonlite)
j <- '[{"a": 1, "b": 2, "c": "A"}, {"a": 4, "b": 1, "c": "B"}]'
d <- fromJSON(txt = j)
d
toJSON(d)

## Dplyr
# `dplyr` añade muchas funciones para manipulación de datos a través de data 
# frames, con un gran performance y backends para varias bases de datos. Nos 
# permite manipular directamente tablas de una BD, sin escribir SQL, toda la 
# evaluación es lazy y, de ser posible, se realiza directamente en la BD.

# Para estos ejemplos utilizaremos un data frame local. Para saber más de como 
# usar `dplyr` con bases de datos, revisar `vignette("databases", package="dplyr")`

## Dplyr
library(dplyr)
mtc <- tbl_df(mtcars)
mtc$car <- row.names(mtcars)
head(mtc)

# Select
mtc %>% select(car, cyl, mpg) %>%
  head()

# Filter
mtc %>% select(car, cyl, mpg) %>%
  filter(cyl >= 6) %>%
  head()

# Arrange
mtc %>% select(car, cyl, mpg) %>%
  filter(cyl >= 6) %>%
  arrange(desc(mpg)) %>%
  head()

# Mutate
mtc %>% select(car, cyl, mpg) %>%
  filter(cyl >= 6) %>%
  arrange(desc(mpg)) %>%
  mutate(kpl = 1.6/3.78*mpg) %>%
  head()

# Group By + Summarise
mtc %>% 
  select(car, cyl, mpg) %>%
  filter(cyl >= 6) %>%
  arrange(desc(mpg)) %>%
  mutate(kpl = 1.6/3.78*mpg) %>%
  group_by(cyl) %>%
  summarise(mean.kpl = mean(kpl), n = n())

# Join
cyls <- mtc %>% select(car, cyl) %>% sample_n(20)
mpgs <- mtc %>% select(car, mpg) %>% sample_n(20)
inner_join(mpgs, cyls) %>% head()

# Las operaciones que se realizan después de `group_by` se aplican a cada grupo
# por separado. e.g. `arrange` organiza las filas adentro de cada grupo por las 
# columnas indicadas. 

# Existen versiones de todos estos verbos que toman cadenas de caracteres en 
# lugar de nombres para indicar las columnas, simplemente hay que agregar un _ 
# (`select_` , `mutate_`, etc).

# Para una introducción más extensa ver `vignette("introduction", package="dplyr")`

## Ggplot2
# `ggplot2` es un sistema de graficación, basado en gramática de gráficas.
# Los componentes de una gráfica se pueden "sumar" unos a otros, causando 
# overlay de capas o modificaciones, según corresponda

# Scatter
library(ggplot2)
ggplot(mtc, aes(x=mpg, y=disp)) + geom_point()

# Color aesthetic
ggplot(mtc, aes(x=mpg, y=disp, color=as.factor(cyl))) + geom_point()

# Smooth curve (loess)
ggplot(mtc, aes(x=mpg, y=disp)) + geom_point() + geom_smooth()

# Histogram + Density
ggplot(mtc, aes(x=mpg, y=..density..)) + geom_histogram() + geom_density()

# Bar (counts)
ggplot(mtc, aes(x=as.factor(cyl))) + geom_bar()

# Boxplot 
ggplot(mtc, aes(x=as.factor(cyl), y=mpg)) + geom_boxplot()

# Facet wrap
ggplot(mtc, aes(x=disp, y=mpg)) + geom_point() + facet_wrap(~cyl, scales="free")

# `ggplot2` también permite controlar leyendas, etiquetas, ejes, etc. 
# Para más detalles ver la documentación (http://docs.ggplot2.org/current/)
