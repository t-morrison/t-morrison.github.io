library(data.table); library(feedeR); library(rvest)



rss <- feedeR::feed.extract("https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&CIK=&type=abs-ee&company=&dateb=&owner=include&start=0&count=80&output=atom")
rss2 <- feedeR::feed.extract("https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&CIK=&type=abs-ee&company=&dateb=&owner=include&start=81&count=80&output=atom")
rss <- as.data.table(rss$items)
rss2 <- as.data.table(rss2$items)
rss <- rss[link !="alternate" & link != "text/html"]

if(nrow(rss2)>0){
  rss2 <- rss2[link !="alternate" & link != "text/html"]
  rss <- unique(rbind(rss, rss2))
  
}; rm(rss2)




rss_cik <- data.table(
  cik = substr(rss$link, 40, 46),
  compare_cik = as.character(paste0("000", substr(rss$link, 40, 46)))
)



###
#Any new CIK numbers?

companies_current <- fread("data/companies.csv", stringsAsFactors = FALSE)


new_cik <- rss_cik[!compare_cik %in% companies_current$cik]


###
#Any new sources?

all_sources <- fread("data/sources.csv")






###
#Update log


log_file <- fread("data/log.csv")


if(nrow(new_cik)>0){
  action <- paste0("New companies added: ", nrow(new_cik))
  new_comps <- paste0(new_cik$compare_cik, collapse = "; ")
} else {
  action <- "Nothing added"
  new_comps <- ""
}

change_table <- data.table(
  timestamp=as.character(Sys.time()),
  action=action,
  added=new_comps
)

new_log <- rbind(log_file, change_table)
write.csv(new_log, file="data/log.csv", row.names=FALSE)

print(paste0("Added: ", nrow(new_cik)))





###
#If new companies, find company name and url
if(nrow(new_cik)==0) {
  stop() 
}

l <- list()

for(i in 1:nrow(new_cik)){
  rss <- feedeR::feed.extract(paste0("https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=000", new_cik[i]$cik, "&type=&dateb=&owner=include&start=0&count=40&output=atom"))
  
  comp <- trimws(substr(rss$title, 0, nchar(rss$title)-12))
  
  l[[i]] <- data.table(
    Company = comp,
    cik = new_cik[i]$compare_cik,
    deal_url = paste0("https://www.sec.gov/cgi-bin/browse-edgar?CIK=000", new_cik[i]$cik, "&action=getcompany")
  )
  print(i)
}; rm(rss, comp)

add <- rbindlist(l)

all_comp <- unique(rbind(companies_current, add))

###
#Write to data file

write.csv(all_comp, file="data/companies.csv", row.names = FALSE)



####






