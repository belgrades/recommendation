# Libraries
library(arules)
library(plyr)

scrap_trans = function(entry){
  map_from = c("item1", "item2",  "item3",  
               "item4", "item5",  "item6",
               "item7", "item8",  "item9",
               "item10", "item11", "item12")
  
  map_to = c("deportes/articulo1", "deportes/articulo2", "deportes/articulo3", 
             "politica/articulo1", "politica/articulo2", "politica/articulo3",
             "variedades/articulo1", "variedades/articulo2","variedades/articulo3",
             "internacional/articulo1", "internacional/articulo2", "internacional/articulo3")
  
  mapvalues(as.array(strsplit(substr(entry, 2, nchar(entry)-1),",")[[1]]), 
                   from = map_from,
                   to = map_to)
}

x = as.data.frame(Sys.time()+rnorm(n = 10, mean = 54000, 18000))
names(x) = c("timestamp")

# Sports with politics 
tipo_1 = random.transactions(nItems = 12, 
                             nTrans = 200,
                             method = "independent",
                             iProb = c(0.9, 0.7, 0.8,  # Deportes 
                                       0.1, 0.3, 0.1,  # Politica
                                       0.01, 0.05, 0.09, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

# Varieties
tipo_2 = random.transactions(nItems = 12, 
                             nTrans = 50,
                             method = "independent",
                             iProb = c(0.09, 0.07, 0.08,  # Deportes 
                                       0.1, 0.03, 0.1,  # Politica
                                       0.9, 0.4, 0.7, # Variedades
                                       0.1, 0.2, 0.09)) # Internacional

# Politica & Internacional
tipo_3 = random.transactions(nItems = 12, 
                             nTrans = 100,
                             method = "independent",
                             iProb = c(0.02, 0.01, 0.1,  # Deportes 
                                       0.8, 0.7, 0.65,  # Politica
                                       0.01, 0.05, 0.09, # Variedades
                                       0.1, 0.3, 0.5)) # Internacional

# Sports and varieties
tipo_4 = random.transactions(nItems = 12, 
                             nTrans = 50,
                             method = "independent",
                             iProb = c(0.5, 0.7, 0.8,  # Deportes 
                                       0.1, 0.3, 0.1,  # Politica
                                       0.5, 0.5, 0.45, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

# Don't know, Don't care
tipo_5 = random.transactions(nItems = 12, 
                             nTrans = 600,
                             method = "independent",
                             iProb = c(0.08, 0.07, 0.08,  # Deportes 
                                       0.01, 0.03, 0.01,  # Politica
                                       0.05, 0.05, 0.05, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

transacciones = c(tipo_1, tipo_2, tipo_3, tipo_4, tipo_5)



trans = as(transacciones, "data.frame")

x = inspect(transacciones)

image(transacciones)

transacciones[1:2]

x = Sys.time()+10
