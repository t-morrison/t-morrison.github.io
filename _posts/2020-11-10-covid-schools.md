---
title: "COVID-19 in U.S. Schools(' websites)"
author: TRM
date: November 8, 2020
output:
  md_document:
    variant: markdown_github
editor_options: 
  chunk_output_type: console
---

Mid-way through the summer, it was looking pretty clear that the pandemic would not be over by the academic year, and school re-opening was uncertain all over the country. I was interested in how many public schools would be having in-person or virtual classes, and whether there would be a shift in schools re-opening or re-closing as the pandemic progressed. I couldn't find any hard data on this, so decided to curate my own by collecting and analyzing unstrucuted data from school websites.

For a data source, I settled on using school district websites. See more on the data collection process to find the websites [here](https://github.com/moman822/covid-schools/tree/master/data), which took a good bit of scraping and some [clever tactics](https://twitter.com/morrison_tommy/status/1298692488941785089) for getting some not-very-open data. My dataset consists of 14,678 school districts, 77% which are "regular public school districts", while the remainder are "independent charter districts".

The data collection process consists of scraping all text off of the school district website front page and storing it in a MongoDB database. I also identified all links on the front page (`<a>` HTML tags) and stored the ones that had a COVID-linked term in the link name, like "remote learning" or "reopening plan". On top of that, I stored any link to Twitter or Facebook, and have curated a dataset of school district Twitter and Facebook handles, which I may use later.

My first scrape of the data was around late August, then I did it weekly for about a month, and then didn't do it until early November.

## Results

### Keyword incidence

How many public school district websites had a hit for any of our keywords on their front page each time we scraped the data? I chose 28 keywords that I thought captured a wide range of COVID-related topics relevant to a school. Note in the chart that the bars represent, chronologically, a single date for when the website was checked, but they are not at equal intervals.

<table><tr><td>
    <img src="/post-images/covid-school/plot1.PNG" />
</td></tr></table>

The two aspects of this imperfect analysis that seem worthwhile to me are 1) the percent of schools with a certain keyword hit and 2) the trend of certain keywords on a page.

For 1), about half of school districts had a mention of *reopen*/*re-open* on their front page, though this doesn't differentiate between "We will re-open" and "We are not reopening". Remote/distance/virtual learning are also common. Notably, one third of school districts didn't have any mention of these keywords on their website front pages.

More interestingly, we can see some trends in keyword incidence over time. *Reopen* dropped most significantly, in raw terms, from websites between August and November. And from early October to early November, we observe a jump in *remote learning*, *virtual learning*, and, worryingly but not surprisingly, my keywords associated to people testing positive for COVID: *tested positive* and *positive test*.

### Positive tests

As of the most recent data collection, November 11, *tested positive* or *positive test* appeared on 409 school district website front pages. While this number is on an upward trend, it is clear from looking at the context surrounding the presence of these keywords, they are far from all announcing the presence of a positive test among students or staff. Here is a random selection of the sentences in which the keyword appeared; there were about 800 such sentences in the 409 school district websites.

<table><tr><td align='center'>
	<img src="/post-images/covid-school/positive-test.gif" />
</td></tr></table>

