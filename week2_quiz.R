# Question 1: 
# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. What time was it created?
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.

library(httr)
library(jsonlite)

myapp <- oauth_app(appname = "coursera_github",
                   key = "5f8d939f8ae1df9d2b48",
                   secret = "63034c5677bef26175ca9868ee5e3b0e1d4bb44b")


github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
json2 = jsonlite::fromJSON(toJSON(json1))

# Subset data.frame
json2[json2$full_name == "jtleek/datasharing", "created_at"]


#Question 2
#The sqldf package allows for execution of SQL commands on R data frames. 
#We will use the sqldf package to practice the queries we might send with the dbSendQuery 
#command in RMySQL. 
#
#Download the American Community Survey data and load it into an R object called: acs
#
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
#
#Which of the following commands will select only the data for the probability weights pwgtp1 with
#ages less than 50?


library(RSQLite)
library(sqldf)

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(file, destfile = "./q2.csv")

acs <- read.csv("q2.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")

#Question 3
#Using the same data frame you created in the previous problem, 
#what is the equivalent function to unique(acs$AGEP)

sqldf("select distinct AGEP from acs")

# Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html
# (Hint: the nchar() function in R may be helpful)

library(XML)
file <- "http://biostat.jhsph.edu/~jleek/contact.html"

html <- readLines(file)
lines <- html[c(10,20,30,100)]
nchar(lines)
