library(dplyr)
library(ggplot2)

#### Ley de los grandes números ####

# Moneda

# Dado

# Dado + Moneda

#### Teorema Central de Límite ####

# Moneda a normal

# Moneda a normal

# Dado + Moneda a normal

#### Error y complejidad ####
library(FNN)

n.data <- 11000
n.train <- 10000
data <- data_frame(x1=rnorm(n.data, 10, 7), 
                   x2=rnorm(n.data, 6, 3), 
                   x3=rnorm(n.data, 15, 10), 
                   y = x1 + x2 + x3 + rnorm(n.data))
train <- data[1:n.train,]
test <- data[(n.train+1):n.data,]

preds <- sapply(1:40, function(k) {
  knn.reg(train=train[1:3], test=test[1:3], y=train$y, k=k)$pred
}) 
error <- apply(preds, 2, function(e) sum((e-test$y)**2)) %>% t() %>% 
  t() %>%
  data.frame() %>%
  setNames("error") %>%
  mutate(k = 1:40)
ggplot(error, aes(x=k, y=error)) + geom_line()

#### Maldición de la dimensionalidad ####
side.prop <- function(p, nn, r) {
  u <- replicate(p, runif(nn))
  x <- replicate(p, runif(1))
  x1 <- x - r/2
  x2 <- x + r/2
  length(which(colSums((t(u) >= x1) & (t(u) <= x2)) == p))/nn  
}
prop <- sapply(1:10, function(p) {
  mean(replicate(100, side.prop(p, 10000, 0.4)))
})
ggplot(data.frame(p=1:10, prop=prop), aes(x=p, y=prop)) + geom_line() + 
  geom_point() +
  scale_x_continuous(breaks = 1:10)

#### Modelo lineal en el seno ####
data <- data_frame(x = runif(100, min=1, max=20), y = 3*sin(x) + rnorm(100, 1, 1))
ggplot(data, aes(x=x, y=y)) + geom_point() + geom_smooth(method = "lm", formula = y~sin(x))
