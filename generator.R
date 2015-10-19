# Libraries
library(arules)
library(arulesviz)
library(plyr)

scrap_trans = function(entry, map_from, map_to){
  paste(mapvalues(as.array(strsplit(substr(entry, 2, nchar(entry)-1),",")[[1]]), 
                   from = map_from,
                   to = map_to,
                   warn_missing = FALSE),
        collapse = ",")
}

lappend <- function ( lst, ...){
  lst <- c(lst, list(...))
  return(lst)
}

eappend <- function(elem, ...){
  elem <- c(elem, ...)
  return(elem)
}

create_transactions = function(trans){
  transactions = list()
  for(i in 1:nrow(trans)){
    single = character()
    for(page in strsplit(x = trans$items[i], split = ",")[[1]]){
      single = eappend(single, page)
    }
    transactions = lappend(transactions, single)
  }
  return(transactions)
}

# map_from 
n_articles = 27

map_from = character()

for(n in 1:n_articles){
  map_from = eappend(map_from, paste("item", as.character(n), sep = ""))
}

# map_to

types_articles = c("deportes", "politica", "variedades", "internacional",
                   "nacionales", "sucesos", "comunidad", "negocios", "opinion")

articles = c("articulo1", "articulo2", "articulo3")

map_to = character()

for(type in types_articles){
  for(article in articles){
    map_to = eappend(map_to, paste(type,"/",article, sep = ""))
  }
}

# Sports with politics 
tipo_1 = random.transactions(nItems = 12, 
                             nTrans = 2000,
                             method = "independent",
                             iProb = c(0.9, 0.7, 0.8,  # Deportes 
                                       0.1, 0.3, 0.1,  # Politica
                                       0.01, 0.05, 0.09, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

# Varieties
tipo_2 = random.transactions(nItems = 12, 
                             nTrans = 500,
                             method = "independent",
                             iProb = c(0.09, 0.07, 0.08,  # Deportes 
                                       0.1, 0.03, 0.1,  # Politica
                                       0.9, 0.8, 0.7, # Variedades
                                       0.1, 0.2, 0.09)) # Internacional

# Politica & Internacional
tipo_3 = random.transactions(nItems = 12, 
                             nTrans = 1000,
                             method = "independent",
                             iProb = c(0.02, 0.01, 0.1,  # Deportes 
                                       0.8, 0.7, 0.65,  # Politica
                                       0.01, 0.05, 0.09, # Variedades
                                       0.1, 0.3, 0.5)) # Internacional

# Sports and varieties
tipo_4 = random.transactions(nItems = 12, 
                             nTrans = 500,
                             method = "independent",
                             iProb = c(0.5, 0.7, 0.8,  # Deportes 
                                       0.1, 0.3, 0.1,  # Politica
                                       0.5, 0.5, 0.45, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

# Don't know, Don't care
tipo_5 = random.transactions(nItems = 12, 
                             nTrans = 6000,
                             method = "independent",
                             iProb = c(0.08, 0.07, 0.08,  # Deportes 
                                       0.01, 0.03, 0.01,  # Politica
                                       0.05, 0.05, 0.05, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

transacciones = c(tipo_1, tipo_2, tipo_3, tipo_4, tipo_5)

trans = data.frame(Sys.time()+rnorm(n = 10000, mean = 54000*6, 18000*6), 
                   as(transacciones, "data.frame"))

trans$transactionID = NULL
trans$items = as.character(trans$items)

names(trans) = c("timestamp", "items")

for(i in 1:10000){
  trans$items[i] = scrap_trans(trans$items[i], map_from, map_to)
}

write.csv(x = trans, file = "prueba.csv", row.names = F)
pru = read.csv(file = "prueba.csv")


transactions = create_transactions(trans)

k = apriori(transactions, 
            parameter = list(supp = 0.0025, 
                             conf = 0.7,
                             target = "rules"))

subrules = head(sort(k, by="confidence"), 10)
plot(subrules, method="graph")

plot(k, method="paracoord")

plot(k,  method="grouped", main = "Grouped rules, finding clusters")

saveAsGraph(head(sort(k, by="lift"),20), file="rules.graphml")


inspect(k)
