##### Question 1 #####
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# How many properties are worth $1,000,000 or more?

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file, destfile = "./q1.csv")
q1 <- read.csv("q1.csv")
x <- q1$VAL==24  # creates logical vector with TRUE or FALSE 
sum(x, na.rm = TRUE)  # can sum the logical vector (TRUE=1; FALSE = 1)

# 53

##### Question 2 #####
#Use the data you loaded from Question 1. 
#Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate? 

#Tidy data has one variable per column. 

##### Question 3 ####
#Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:dat
#What is the value of:sum(dat$Zip*dat$Ext,na.rm=T)
#(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

library (xlsx)
file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(file, destfile = "./q2.xlsx")

cols <- 7:15
rows <- 18:23
dat <- read.xlsx("q2.xlsx", sheetIndex = 1, colIndex = cols, rowIndex = rows)

sum(dat$Zip*dat$Ext,na.rm=T)

#36534720

#Question 4
#Read the XML data on Baltimore restaurants from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
#How many restaurants have zipcode 21231? 

#127

#Question 5
#The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
#using the fread() command load the data into an R object DT
#The following are ways to calculate the average value of the variable pwgtp15
#broken down by sex. Using the data.table package, which will deliver the fastest user time? 
#
#DT[,mean(pwgtp15),by=SEX]

