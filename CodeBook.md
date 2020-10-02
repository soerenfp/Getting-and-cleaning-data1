---
title: "CodeBook.md"
author: "Soren Pedersen"
date: "10/2/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

The run_analysis.R script contains the code to preform the tasks from the coursera assignment

#0_Install and load packages
Installs and loads "dplyr" used for the assignments

#1_LOADING, CHECKING AND ASSIGNING THE DATA
loads the data to accel_data1, then checking the data and assigning the data to the features

features = contains the features from the the accelerometer and gyroscope 3-axial raw signals
activities = list fo activities performed when the measurements were taken
subject_test = contains the test data from volounteer tests
x_test = recorded test-data
y_test = recorded test-data from activites' code
subject_train = contains test data from volounteers 
x_train = recorded train-data
y_train = recorded train-data from activites' code

#2_STEP 1: Merges the training and the test sets to create one data set.
First assignment 

X = contains the combined data from x_train and x_test using rbind()
Y = contains the combined data from y_train and y_test using rbind()
subject_train_test = contains the combined data from subject_train and subject_test using rbind()
merge_data = is the merged data from subject_train_test, X and Y using cbind()

#3_STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.
Second assignment

ExtractData_mean_STD = takes the mean and standard deviation from merge_data for each measurement

#4_STEP 3: Uses descriptive activity names to name the activities in the data set
Third assignment

ExtractData_mean_STD$code = names the activities in the data set descriptively

#5_STEP 4: Appropriately labels the data set with descriptive variable names.
Fourth assignment

Names the shortenings of labels with descriptive names using names() and gsub()

#6_STEP 5: From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
Fifth assignment

Creates a final, independent, tidy data set called "Tidy_data_set" with the average of each variable from activity and subject, and exports the Tidy_data_set into Tidy_data_set.txt

#7_CHECKING THE DATA

Checks the Tidy_data_set

