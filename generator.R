# Libraries
library(arules)

# Sports with politics 
tipo_1 = random.transactions(nItems = 12, 
                             nTrans = 200,
                             ITrans = 3,
                             method = "independent",
                             iProb = c(0.9, 0.7, 0.8,  # Deportes 
                                       0.1, 0.3, 0.1,  # Politica
                                       0.01, 0.05, 0.09, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

# Varieties
tipo_2 = random.transactions(nItems = 12, 
                             nTrans = 50,
                             ITrans = 2,
                             method = "independent",
                             iProb = c(0.09, 0.07, 0.08,  # Deportes 
                                       0.1, 0.03, 0.1,  # Politica
                                       0.9, 0.4, 0.7, # Variedades
                                       0.1, 0.2, 0.09)) # Internacional

# Politica & Internacional
tipo_3 = random.transactions(nItems = 12, 
                             nTrans = 100,
                             ITrans = 4,
                             method = "independent",
                             iProb = c(0.02, 0.01, 0.1,  # Deportes 
                                       0.8, 0.7, 0.65,  # Politica
                                       0.01, 0.05, 0.09, # Variedades
                                       0.1, 0.3, 0.5)) # Internacional

# Sports and varieties
tipo_4 = random.transactions(nItems = 12, 
                             nTrans = 50,
                             ITrans = 3,
                             method = "independent",
                             iProb = c(0.5, 0.7, 0.8,  # Deportes 
                                       0.1, 0.3, 0.1,  # Politica
                                       0.5, 0.5, 0.45, # Variedades
                                       0.01, 0.05, 0.09)) # Internacional

transacciones = c(tipo_1, tipo_2, tipo_3, tipo_4)

image(transacciones)
