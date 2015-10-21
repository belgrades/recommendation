# Libraries
library(arules)
library(arulesViz)
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

create_type = function(nItem, nTran, iPro){
  type = random.transactions(nItems = nItem, 
                             nTrans = nTran,
                             method = "independent",
                             iProb = iPro)
  return(type)
}

# Sports with politics 

type_1 = create_type(27, 1000, c(0.9, 0.7, 0.8,     # Deportes 
                                 0.1, 0.3, 0.1,     # Politica
                                 0.01, 0.05, 0.09,  # Variedades
                                 0.01, 0.05, 0.09,  # Internacional
                                 0.09, 0.07, 0.08,  # Nacionales
                                 0.01, 0.03, 0.01,  # Sucesos
                                 0.01, 0.05, 0.09,  # Comunidad
                                 0.01, 0.05, 0.09,  # Negocios
                                 0.01, 0.05, 0.09)) # Opinion

# Variedades con opinion

type_2 = create_type(27, 500, c(0.09, 0.07, 0.08,   # Deportes 
                                 0.01, 0.03, 0.01,  # Politica
                                 0.9, 0.5, 0.8,     # Variedades
                                 0.01, 0.05, 0.09,  # Internacional
                                 0.09, 0.07, 0.08,  # Nacionales
                                 0.01, 0.03, 0.01,  # Sucesos
                                 0.01, 0.05, 0.09,  # Comunidad
                                 0.01, 0.05, 0.09,  # Negocios
                                 0.1, 0.3, 0.4))    # Opinion

# Política & Internacional - Opinion

type_3 = create_type(27, 1500, c(0.02, 0.01, 0.03,  # Deportes 
                                0.8, 0.7, 0.65,     # Politica
                                0.009, 0.05, 0.08,  # Variedades
                                0.9, 0.8, 0.7,     # Internacional
                                0.09, 0.07, 0.08,   # Nacionales
                                0.01, 0.03, 0.01,   # Sucesos
                                0.01, 0.05, 0.09,   # Comunidad
                                0.01, 0.05, 0.09,   # Negocios
                                0.1, 0.3, 0.4))     # Opinion

# Sports & varieties

type_4 = create_type(27, 1000, c(0.3, 0.4, 0.3,      # Deportes 
                                 0.01, 0.01, 0.01,   # Politica
                                 0.9, 0.8, 0.75,     # Variedades
                                 0.04, 0.05, 0.045,  # Internacional
                                 0.09, 0.07, 0.08,   # Nacionales
                                 0.01, 0.03, 0.01,   # Sucesos
                                 0.01, 0.05, 0.09,   # Comunidad
                                 0.01, 0.05, 0.09,   # Negocios
                                 0.01, 0.03, 0.04))  # Opinion

# Sucesos & Nacionales & Politica

type_5 = create_type(27, 1000, c(0.02, 0.01, 0.03,      # Deportes * 
                                 0.36, 0.45, 0.74,   # Politica *
                                 0.01, 0.02, 0.03,     # Variedades *
                                 0.04, 0.05, 0.045,  # Internacional
                                 0.7, 0.7, 0.8,   # Nacionales *
                                 0.6, 0.3, 0.9,   # Sucesos *
                                 0.01, 0.05, 0.09,   # Comunidad
                                 0.01, 0.05, 0.09,   # Negocios
                                 0.01, 0.03, 0.04))  # Opinion

# Comunidad & Deportes

type_6 = create_type(27, 1000, c(0.4, 0.5, 0.6,      # Deportes 
                                 0.06, 0.05, 0.04,   # Politica
                                 0.01, 0.02, 0.03,     # Variedades
                                 0.04, 0.05, 0.045,  # Internacional
                                 0.07, 0.07, 0.08,   # Nacionales
                                 0.08, 0.08, 0.09,   # Sucesos
                                 0.7, 0.5, 0.9,   # Comunidad
                                 0.01, 0.05, 0.09,   # Negocios
                                 0.01, 0.03, 0.04))  # Opinion

# Negocios & opinion & internacional & Politica

type_7 = create_type(27, 3000, c(0.02, 0.1, 0.003,      # Deportes 
                                 0.36, 0.45, 0.44,   # Politica
                                 0.01, 0.02, 0.03,     # Variedades
                                 0.4, 0.5, 0.45,  # Internacional
                                 0.7, 0.7, 0.8,   # Nacionales
                                 0.006, 0.003, 0.009,   # Sucesos
                                 0.01, 0.05, 0.09,   # Comunidad
                                 0.7, 0.7, 0.6,   # Negocios
                                 0.6, 0.8, 0.7))  # Opinion

# Don't know, Don't care

type_8 = create_type(27, 6000, c(0.02, 0.01, 0.003,      # Deportes 
                                 0.06, 0.045, 0.044,   # Politica
                                 0.01, 0.02, 0.03,     # Variedades
                                 0.04, 0.05, 0.045,  # Internacional
                                 0.007, 0.007, 0.08,   # Nacionales
                                 0.006, 0.003, 0.009,   # Sucesos
                                 0.01, 0.05, 0.09,   # Comunidad
                                 0.02, 0.03, 0.02,   # Negocios
                                 0.025, 0.03, 0.04))  # Opinion

transacciones = c(type_1, type_2, type_3, type_4, type_5, type_6, type_7, type_8)

trans = data.frame(Sys.time()+rnorm(n = 15000, mean = 54000*6, 18000*6), 
                   as(transacciones, "data.frame"))

trans$transactionID = NULL
trans$items = as.character(trans$items)

names(trans) = c("timestamp", "items")

for(i in 1:15000){
  trans$items[i] = scrap_trans(trans$items[i], map_from, map_to)
}

# write.csv(x = trans, file = "prueba.csv", row.names = F)
# pru = read.csv(file = "prueba.csv")

transactions = create_transactions(trans)

k = apriori(transactions, 
            parameter = list(supp = 0.007692308, 
                             conf = 0.7,
                             target = "rules"))

subrules = head(sort(k, by="support"), 10)
plot(subrules, method="grouped")

plot(subrules,method="graph",interactive=TRUE)

plot(subrules, method="grouped")

#plot(k)

# saveAsGraph(head(sort(k, by="lift"),20), file="rules.graphml")

#library(iplots)
#inspect(k)
