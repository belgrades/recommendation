library(parsedate)
library(urltools)

get_url = function(data, prdctvID, timestamp){
  url = data$get_params.url[data$get_params.prdctvId == prdctvID & data$timestamp == timestamp]
  return(url)
}

transform_url <-function(url){
  parameter_values <- param_get(url, c("college","q","cat","size_range","apparel_collection"))
  htp = strsplit(url, "\\?")[[1]][[1]]
  nombres = names(parameter_values)
  i = 1 
  nombres[[1]]
  for (row in parameter_values) {
    if (parameter_values[nombres[[i]]][[1]] != ""){
      htp = param_set(htp, nombres[[i]],parameter_values[nombres[[i]]][[1]])
    }
    #  print(htp)
    i = i + 1
  }

  htp = substr(x = htp, start = 28, stop = nchar(htp))

  return(htp)  
}

create_trans = function(data, tolerance = 120){
  id = unique(data$get_params.prdctvId)
  # To fill in Data Frame
  source.id = character()
  trans.id = numeric()
  transaction = character()
  actual = 1
  
  for(i in id){
    whom = data$timestamp[data$get_params.prdctvId==i]
    if(length(whom)>=2){
      # Agregamos el primer URL
      trans.nueva = get_url(data, i, whom[1])
      
      for(x in 2:length(whom)){
        if(as.double(difftime(whom[x], whom[x-1], units="secs"))<tolerance){
          trans.nueva = paste(trans.nueva, get_url(data, i, whom[x]), sep = ",")
        }else{
          # Fallo la tolerancia, nueva transaccion
          
          # Agregamos indice, actualizamos indice
          source.id = c(source.id, i)
          trans.id = c(trans.id, actual)
          actual = actual + 1
          
          # Agregamos URL
          transaction = c(transaction, paste(unique(strsplit(trans.nueva, split = ",")[[1]]), collapse = ","))
          trans.nueva = get_url(data, i, whom[x])
        }
      }
      source.id = c(source.id, i)
      trans.id = c(trans.id, actual)
      actual = actual + 1
      transaction = c(transaction, paste(unique(strsplit(trans.nueva, split = ",")[[1]]), collapse = ","))
      # Terminamos de analizar para el is i actual
    }else{
      source.id = c(source.id, i)
      trans.id = c(trans.id, actual)
      actual = actual + 1 
      transaction = c(transaction, get_url(data, i, whom[1]))
    }
  }
  items = transaction
  x = data.frame(items)
  return(x)
}