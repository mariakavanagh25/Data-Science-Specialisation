# Question 1
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# Create a logical vector that identifies the households on greater than 10 acres who sold more than 
# $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the logical vector 
# is TRUE. which(agricultureLogical) 
# What are the first 3 values that result?


file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file, destfile = "./q1.csv")
q1 <- read.csv("q1.csv")

agricultureLogical <-  ifelse(q1$ACR==3 & q1$AGS ==6, TRUE, FALSE)
which(agricultureLogical)[1:3]

# Question 2
# Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 

# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
# (some Linux systems may produce an answer 638 different for the 30th quantile)# 

install.packages("jpeg")
library(jpeg)

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(file, destfile = "q2.jpg", mode ="wb")

q2 <- readJPEG("q2.jpg", native = TRUE)
quantile(q2, probs = c(0.3, 0.8))

# Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

# Load the educational data from this data set:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in 
# descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?

install.packages("tidyr")
library(tidyr)

# Look at file - data starts on row 6 - skip the first 5 rows, but do not take 1st row as headers
# Select only the columns with data and select only the ranked countries

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file, destfile = "gdp.csv")
gdp <- read.csv("gdp.csv",skip =5,header=FALSE)
gdp2 <- select(gdp, c(1,2,4,5)) %>% 
  rename(CountryCode = V1, Rank_gdp = V2,economy_gdp= V4,gdp = V5) %>% 
  transform(Rank_gdp = as.numeric(Rank_gdp))%>%
  filter(Rank_gdp %in% (1:190))



file2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(file2, destfile = "edu.csv" )
edu <- read.csv("edu.csv")

#Merge the 2 data frames , set all to FALSE to take only matched records
merged_df <- merge(gdp2, edu, by="CountryCode", all=FALSE)
nrow(merged_df)

sort_df <- arrange(merged_df, desc(Rank_gdp))
sort_df[13,c(1,3)]


