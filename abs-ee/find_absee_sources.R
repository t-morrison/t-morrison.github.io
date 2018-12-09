#Get the ABS-EE filings for each deal
#Run once
library(data.table); library(rvest); library(feedeR)

sources_current <- fread("C:/Users/TRM/Documents/GitHub/moman822.github.io/abs-ee/data/sources.csv", stringsAsFactors = FALSE)
get_absee_link <- function(pre_link) {
  y <- read_html(pre_link)
  rvest::html_nodes(y, 'table')
  y_table <- html_table(y)[[1]]
  setDT(y_table)
  paste0(sub("^(.*)[/].*", "\\1", pre_link), "/", y_table[Type=="EX-102"]$Document)
}

###
#Loop through every company and pull RSS for ABS-EE filetypes
ciks <- unique(sources_current$cik)




l <- list()
for(i in 1:20){#length(ciks)){
  
  print(paste0("CIK: ", ciks[i]))
  x <- feedeR::feed.extract(
    paste0("https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=", ciks[i],"&type=abs-ee%25&dateb=&owner=exclude&start=0&count=100&output=atom")
  )$items
  setDT(x)
  
  
  
  x <- x[!link %in% c("alternate", "text/html")]
  
  if(nrow(x)>40){next}
  
  x[, date:=substr(date, 0, 10)]
  x[, absee_page:=link]
  x[, company:=sources_current[cik==ciks[i]]$company[1]]
  x[, cik:=ciks[i]]
  #x$absee_link <- get_absee_link(x$absee_page)
  
  for(j in 1:nrow(x)){
    
    x[j, absee_link := get_absee_link(absee_page)]
    print(paste0("absee: ", j, "/", nrow(x)))
  }
  
  l[[i]] <- x[, c("company","cik","date","absee_page","absee_link")]
  
  print(i)
  
}

sources <- rbindlist(l)


unique(rbind(sources, sources1))

# sources1 <- copy(sources)

write.csv(sources[, c('company', 'cik', 'date', 'absee_page', 'absee_link')], "C:/Users/TRM/Documents/GitHub/moman822.github.io/abs-ee/sources2.csv", row.names = FALSE)














































