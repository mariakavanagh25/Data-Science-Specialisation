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

