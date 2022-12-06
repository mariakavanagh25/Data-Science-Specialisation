# Question 1
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file, destfile = "./q1.csv")
q1 <- read.csv("q1.csv")

split <- strsplit(names(q1), "wgtp") 
split[123]

# Question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table

library(tidyr)
library(dplyr)

file2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file2, destfile = "./q2.csv")

# again data starts on row 5, so skip first 5 rows, take only ranked countries (ranking 1-190)
q2 <- read.csv("q2.csv", skip=5, header=FALSE)%>%
      select(c(1,2,4,5)) %>% 
      rename(CountryCode = V1, ranking = V2,economy= V4, GDP= V5)%>%
      transform(ranking = as.numeric(ranking))%>%
      filter(ranking %in% (1:190))

#gsub will return a character vector, so need to coerce to numeric
q2$GDP <- as.numeric(gsub(",","",q2$GDP))
mean(q2$GDP, na.rm=TRUE)

# Question 3
# In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins 
# with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United? 

grep("^United", q2$economy, value=TRUE)


# Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?


file3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file3, destfile = "./q4_gdp.csv")
gdp <- read.csv("q4_gdp.csv", skip=5, header=FALSE)%>%
        select(c(1,2,4,5)) %>% 
        rename(CountryCode = V1, ranking = V2,economy= V4, GDP= V5)%>%
        transform(ranking = as.numeric(ranking))%>%
        filter(ranking %in% (1:190))
  
file4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(file4, destfile = "./q4_edu.csv")
edu <- read.csv("q4_edu.csv")

#Merge the 2 data frames , set all to FALSE to take only matched records
#Use NROW (rather than nrow), treats a vector as a 1 column matrix  

merged_df <- merge(gdp, edu, by="CountryCode", all=FALSE)
NROW(grep("Fiscal year end: June", merged_df$'Special.Notes'))


# Question 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price and get the times the data was sampled.

# library(quantmod)
# amzn = getSymbols("AMZN",auto.assign=FALSE)
# sampleTimes = index(amzn)

# How many values were collected in 2012? How many values were collected on Mondays in 2012

install.packages("quantmod")
install.packages("lubridate")
library(quantmod)
library(lubridate)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012?
amzn_2012 <- sampleTimes[grep("^2012", sampleTimes)]
NROW(amzn_2012)

# How many values were collected on Mondays in 2012
NROW(amzn_2012[weekdays(amzn_2012) == "Monday"])
