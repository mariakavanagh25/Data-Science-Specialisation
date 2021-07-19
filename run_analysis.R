# Getting and Cleaning Data Course Project
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
# A full description is available at the site where the data was obtained:
  
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Here are the data for the project:
  
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

# You should create one R script called run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(tidyr)
library(quantmod)
library(dplyr)

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file, destfile = "./accelerometer_zip.zip")
unzip("./accelerometer_zip.zip")

# Step 1: Merge the data sets
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  test_train <- rbind(x_train, x_test)

# Step 2: Extract only measurements on mean/std

  # get column headers from features.txt 
  # find only columns with mean or std
  col_headers <- read.table("./UCI HAR DATASET/features.txt")[,2]
  mean_std_cols <- grep("mean|std", col_headers)
  
  # rename columns and subset for mean/std
  names(test_train) <- col_headers
  subset <- test_train[, mean_std_cols]

# Step 3: Use descriptive activity names
  
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")%>% 
    rename(activity = V1)
  
  # merge activity data sets
  activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  activity_test_train <- rbind(activity_train, activity_test)%>% 
                         rename(activity = V1)
  
  # provide description for activity
  activity_test_train$activity_description <- if_else(activity_test_train$activity == 1, "WALKING",
                                              if_else(activity_test_train$activity == 2, "WALKING_UPSTAIRS",
                                              if_else(activity_test_train$activity == 3, "WALKING_DOWNSTAIRS",
                                              if_else(activity_test_train$activity == 4, "SITTING",
                                              if_else(activity_test_train$activity == 5, "STANDING",
                                              if_else(activity_test_train$activity == 6, "LAYING",
                                                      ""))))))
  
  # I Also wanted to add in subject id
  # get subject id from subject_test/train
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  subject_test_train <- rbind(subject_train, subject_test)%>% 
                        rename(subject = V1)
  
# Step 4: Appropriately label data set with descriptive variable names
  # Incorporated into Step 2 above
  test_train_file <- cbind(subset,activity_test_train,subject_test_train)

# Step 5: Create a tidy data set with the average of each variable for each activity and each subject
  tidy_data_set <- test_train_file%>% 
                    group_by(activity_description,subject)%>%
                    summarise_all(mean)
  

