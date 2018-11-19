#Get the ABS-EE filings for each deal
#Run once
library(data.table); library(rvest)l; library(feedeR)

sources_current <- fread("C:/Users/TRM/Documents/GitHub/moman822.github.io/abs-ee/sources.csv", stringsAsFactors = FALSE)


###
#Loop through every company and pull RSS for ABS-EE filetypes

l <- list()
for(i in 1:nrow(companies)){
  
  
  x <- feedeR::feed.extract(
    paste0("https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=", 0001347185,"&type=abs-ee%25&dateb=&owner=exclude&start=0&count=100&output=atom")
  )$items
  setDT(x)
  
  x <- x[!link %in% c("alternate", "text/html")]
  x[, date:=substr(date, 0, 10)]
  x[, absee_page:=link]
  x[, company:=companies[i]$Company]
  x[, cik:=companies[i]$cik]
  
  l[[i]] <- x
  print(i)
  
}

sources <- rbindlist(l)


###
#Go to each source page and get the link to the data

get_absee_link <- function(pre_link) {
  y <- read_html(pre_link)
  rvest::html_nodes(y, 'table')
  y_table <- html_table(y)[[1]]
  setDT(y_table)
  paste0(sub("^(.*)[/].*", "\\1", pre_link), "/", y_table[Type=="EX-102"]$Document)
}


for(i in 1:nrow(sources)){
  sources[i, absee_link:=get_absee_link(absee_page)]
  print(i)
}

write.csv(sources[, c('company', 'cik', 'date', 'absee_page', 'absee_link')], "C:/Users/TRM/Documents/GitHub/moman822.github.io/abs-ee/sources.csv", row.names = FALSE)














































