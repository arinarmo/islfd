## FizzBuzz
# Escribir una función que dado un vector de enteros, regrese un vector donde:
# * los números divisibles entre 3 en el vector original sean reemplazados por 'fizz'
# * los números divisibles entre 5 en el vector original sean reemplazados por 'buzz'
# * los números divisibles entre 15 en el vector original sean reemplazados por 'fizzbuzz'
# * todos los demás números en el vector se mantengan iguales
# No usar estructuras de control para crear ciclos
# HINTS: ?paste0, ?`%%`
fizzbuzz <- function(x) {

}

## Dado
# Escribir una función que, dado un número entero n, regrese una función que
# simule un lanzamiento de dado de n caras
# HINT: ?sample
dice <- function(n) {
  function() {
    
  }
}

## Dado + Moneda
# Escribir una función que, dado un número entero n, regrese una función que 
# simule el siguiente experimento aleatorio
# * Lanzar un dado de n caras y ver el resultado k
# * Lanzar k monedas
# * Contar el número de monedas que muestran cara
dice.coin <- function(n) {
  function() {
    
  }
}

## K vecinos más cercanos
# Escribir una función que dado un número entero k, un data frame, una métrica para
# comparar filas del mismo y un vector de respuesta y, regrese una función que
# encuentre la estimación por k vecinos más cercanos a una lista 
# (con la misma estructura que el data frame). Se vale usar fuerza bruta
knn <- function(k, data, y, f.metric) {
  
  f <- function(x) {
    
  }
}

## Cross Validation
# Escribir uan función que, dado una función predictiva, un conjunto de datos y
# un número entero k, realice validación cruzada con k partes y estime el error
# de predicción de la función
cross.val <- function(f.pred, data, k) {
  
}