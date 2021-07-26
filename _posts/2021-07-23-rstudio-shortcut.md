---
title: "The best thing I ever did with R"
author: TRM
date: July 23, 2021
output:
  md_document:
    variant: markdown_github
editor_options: 
  chunk_output_type: console
---

A few years back, I created an RStudio shortcut that has ended up being my most-used function in R, probably by far. What does the shortcut do? It wraps the current line in the RStudio editor (or the console, if the cursor is there) in a `View()` function, which opens the data.frame in RStudio's built-in data viewer.

What's so special about that? Aren't there some shortcuts that already do that? There are, but they're not as good. Here is why:

There are two shortcuts (that I know of) to view data in RStudio - `F2` and `Ctrl + left-click`. These do work when you have a data.frame/data.table/tibble as environment variable in your editor. But, they *only* work on an 
un-altered version of the object. As someone who does a lot of data wrangling and exploratory analysis and data cleaning, I like to go through my data.tables in the Viewer while I am running queries on them. This won't work with 
`F2` or `Ctrl + left-click`:

What you see             |  Not what you get
:-------------------------:|:-------------------------:
![what you see](/post-images/rstudio-shortcut/no-2.PNG)  |  ![what you get](/post-images/rstudio-shortcut/no-2_2.PNG)


For










