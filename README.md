# Getting and cleaning Data Project
Getting and cleaning data <p> 
https://www.coursera.org/learn/data-cleaning/home/welcome <p>
  
*********************************************
<p> 
Author: Maria Kavanagh <p> 
Date: 19 Jul 2021 <p> 
 
*********************************************
# Project Objective

1. Write an R scrpit called <b> run_analysis.R, </b> that does the following:
    - Merges the training and the test sets to create one data set.
    - Extracts only the measurements on the mean and standard deviation for each measurement.
    - Uses descriptive activity names to name the activities in the data set
    - Appropriately labels the data set with descriptive variable names.
    - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
2. Provide link to <b> Github repository </b> with your script for performing the analysis
3. Provide CodeBook, called <b> CodeBook.md </b> that describes: 
    - the variables, the data, any transformations you performed 
4. Provide a <b> README.mf </b> file in the github repo that:
    - explains how all of the scripts work, how they are connected
 
**********************************************
## The Data set  
  
The data used for this project is collected from the accelerometers from the Samsung Galaxy S smartphone.
The data can be obatined from the following location 
 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

##  run_analysis.R  
  
The script run_analysis.R does the following: 
  
* Downloads the files from the above location
* unzips/exracts the data
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a tidy data set with the average of each variable for each activity and each subject (tidy_data_set.txt).
