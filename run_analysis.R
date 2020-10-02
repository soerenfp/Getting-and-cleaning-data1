#Getting and cleaning data, peer-reviewed assignment

#0_Install and load packages

install.packages("dplyr")
library(dplyr)


#1_LOADING, CHECKING AND ASSIGNING THE DATA

accel_data1 <- "Coursera_accel-data.zip"

#1.1_Checking the archieve
if (!file.exists(accel_data1)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, accel_data1, method="curl")
}  

#1.2_Checking the folder
if (!file.exists("UCI HAR Dataset")) { 
  unzip(accel_data1) 
}

#1.3_Assigning the data

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#2_STEP 1: Merges the training and the test sets to create one data set.

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject_train_test <- rbind(subject_train, subject_test)
merge_data <- cbind(subject_train_test, Y, X)


#3_STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.

ExtractData_mean_STD <- merge_data %>% select(subject, code, contains("mean"), contains("std"))


#4_STEP 3: Uses descriptive activity names to name the activities in the data set

ExtractData_mean_STD$code <- activities[ExtractData_mean_STD$code, 2]


#5_STEP 4: Appropriately labels the data set with descriptive variable names.

names(ExtractData_mean_STD)[2] = "activity"
names(ExtractData_mean_STD) <- gsub("Acc", "Accelerometer", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("Gyro", "Gyroscope", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("BodyBody", "Body", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("Mag", "Magnitude", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("^t", "Time", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("^f", "Frequency", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("tBody", "TimeBody", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("-mean()", "Mean", names(ExtractData_mean_STD), ignore.case = TRUE)
names(ExtractData_mean_STD) <- gsub("-std()", "STD", names(ExtractData_mean_STD), ignore.case = TRUE)
names(ExtractData_mean_STD) <- gsub("-freq()", "Frequency", names(ExtractData_mean_STD), ignore.case = TRUE)
names(ExtractData_mean_STD) <- gsub("angle", "Angle", names(ExtractData_mean_STD))
names(ExtractData_mean_STD) <- gsub("gravity", "Gravity", names(ExtractData_mean_STD))


#6_STEP 5: From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

Tidy_data_set <- ExtractData_mean_STD %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Tidy_data_set, "Tidy_data_set.txt", row.name=FALSE)


#7_CHECKING THE DATA

str(Tidy_data_set)

Tidy_data_set

