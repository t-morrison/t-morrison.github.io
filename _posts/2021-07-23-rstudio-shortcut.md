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

There are two shortcuts (that I know of) to view data in RStudio - `F2` and `Ctrl + left-click`. These do work when you have a data.frame/data.table/tibble as environment variable in your editor. But, they *only* work on an un-altered version of the object. As someone who does a lot of data wrangling and exploratory analysis and data cleaning, I like to go through my data.tables in the Viewer while I am running queries on them. This won't work with 
`F2` or `Ctrl + left-click`:

What you see             |  Is not what you get
:-------------------------:|:-------------------------:
![what you see](/post-images/rstudio-shortcut/no-2.PNG)  |  ![what you get](/post-images/rstudio-shortcut/no-2_2.PNG)


For the built-in RStudio shortcuts, they just grab `iris` and open it in the Viewer, ignoring the rest of the query.

My shortcut, on the other hand, wraps the entire line in `View()`, using RStudio's API functions, and returns the whole dang query in the Viewer. As someone who does most of their work with `data.table`, this is extremely helpful for the long transformations that don't wrap lines:


What you see             |  Is what you get!
:-------------------------:|:-------------------------:
![what you see](/post-images/rstudio-shortcut/no-3.PNG)  |  ![what you get](/post-images/rstudio-shortcut/no-3_2.PNG)


And now, this shortcut is available in my own R package, `viewDat`, available here: https://github.com/t-morrison/viewDat

I have the shortcut bound to `Ctrl + ,`, which not otherwise occupied and easy to reach. The shortcut won't currently work on piped queries, but could probably be extended with some extra effort (I don't use pipes much, so haven't gotten to this).






