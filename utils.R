
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
