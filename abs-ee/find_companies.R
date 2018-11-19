#Create table w/ deal name, CIK, link to deal page
#Run once per month to update with new companies
library(data.table); library(rvest)

###
#Current companies
companies_current <- read.csv("C:/Users/TRM/Documents/GitHub/moman822.github.io/abs-ee/companies.csv", stringsAsFactors = FALSE)

###
#Parsing edgar search result URLs

total <- as.numeric(html_text(html_node(read_html("https://www.sec.gov/cgi-bin/srch-edgar?text=abs-ee&first=2016&last=2018"), css="body > div > b:nth-child(3)")))
total_times <- (total %/% 80)
urls <- paste0("https://www.sec.gov/cgi-bin/srch-edgar?text=abs-ee&start=", c(1,((1:total_times)*80)+1), "&count=80&first=2016&last=2018")


###
#Scrape rows from edgar "abs-ee" search results; any company that files this type we are interested in

tables <- list()

for(i in 1:length(urls)) {
  doc <- read_html(urls[i])
  tbl <- html_table(doc, fill=TRUE)[[5]]
  setDT(tbl)
  t <- html_node(doc, "body > div > table")
  n <- html_nodes(t, "a")
  href_tbl <- data.table(text = html_text(n),href = html_attr(n, "href"))[!text%in%c("[text]","[html]")]
  href_tbl[, href:=paste0("https://www.sec.gov", href)]
  tbl[, href:=href_tbl$href]
  tables[[i]] <- tbl
  print(i)
}

tables2 <- rbindlist(tables)

###
#Get the CIK from the href field in every company/href combo

tables2[, cik:=gsub("/", "", paste0("000", substr(href, 41 , 47)))]
companies <- unique(tables2[, c('Company', 'cik')])
companies[, deal_url:=paste0("https://www.sec.gov/cgi-bin/browse-edgar?CIK=", cik, "&action=getcompany")]


###
#Combine the new with the old
companies <- unique(rbind(companies, companies_current))

write.csv(companies, file="C:/Users/TRM/Documents/GitHub/moman822.github.io/abs-ee/companies.csv", row.names = FALSE)





