---
title: "@GreenGridUSA: a green data twitter bot"
author: TRM
date: February 4, 2021
output:
  md_document:
    variant: markdown_github
editor_options: 
  chunk_output_type: console
---

I launched [@GreenGridUSA](https://twitter.com/GreenGridUSA) last week (feel free to follow)! This is an automated Twitter bot that parses data and posts insights from the U.S. Energy Information Administration (EIA). The EIA has a ton of in-depth and timely data on the US electric grid, including on power plants, transmission, power demand and power generation, and I wanted to put something together to bring that data out.

<table><tr><td>
    <img src="/post-images/greengridusa/image1.PNG" />
</td></tr></table>

<table><tr><td>
    <img src="/post-images/covid-school/plot1.png" />
</td></tr></table>

Currently, @GreenGridUSA posts a daily update on how much utility-level power generation came from wind and solar power plants the prior day. This data is available [here](https://www.eia.gov/beta/electricity/gridmonitor/dashboard/electric_overview/US48/US48) on the hourly electric grid monitor, with about a twelve hour delay for this dataset.

I plan to add in a monthly and perhaps weekly review with some more detailed analysis of the green grid, perhaps drilling down by region or balancing authority. But I need to do a little research first to find out what might be worthwhile to look into. Beyond that, I'll look into combining the EIA data with some other data sources to make this 

This is the first Twitter bot I've made, and probably not the last, now. I use the `rtweet` package to interact with the Twitter API and post the tweets, while the data transformation, analysis and visualization is done primarily with `data.table` and `ggplot2`. To use the Twitter API, you need to create a developer account and get access to your accounts API keys, which takes some time. The EIA does offer [an API](https://www.eia.gov/opendata/) for data access, which is convenient, but it is one-dimensional; you can download most any of their data series, but you get the whole thing, there is no way to limit the days or query within the series. For the hourly electric grid data, this means you get 20,000+ rows each time you pull down data, even if you just want yesterday's figures. The program runs via cronjob on a small AWS EC2 instance.

As of this writing, we are at 2 followers, including myself! Here's to a few more, hopefully.










