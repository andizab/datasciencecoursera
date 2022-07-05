
library(dplyr)

## get and load the data set
fileName <- "zipData.zip"

if (!file.exists(fileName)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = fileName)
}
if (!file.exists("UCI HAR Dataset")){ 
  dataSets <- unzip(fileName)
}

## set up the features and activities
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
training_set <- read.table("UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
training_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

## merge the training and the test sets
x_sets <- rbind(training_set, test_set)
y_labels <- rbind(training_labels, test_labels)
subjects <- rbind(training_subject, test_subject)
mergedData <- cbind(subjects, y_labels, x_sets)
descriFeatures <- as.character(features[, 2]) #to "transpose" the variable names
colnames(mergedData) <- c("Subject", "activity_code", descriFeatures)

## extract the mean and std measurements
selectedData <- select(mergedData, Subject, activity_code, contains("mean"), contains("std"))

## label the activities with descriptive activity names
selectedData$activity_code <- activities[selectedData$activity_code, 2]

## label the data set with descriptive variable names
names(selectedData)[2] <- "Activity"
names(selectedData) <- gsub("-mean()", "Mean", names(selectedData))
names(selectedData) <- gsub("-std()", "Std", names(selectedData))
names(selectedData) <- gsub("Acc", "Accelerometer", names(selectedData))
names(selectedData) <- gsub("Gyro", "Gyroscope", names(selectedData))
names(selectedData) <- gsub("Mag", "Magnitude", names(selectedData))
names(selectedData) <- gsub("^t", "Time-", names(selectedData))
names(selectedData) <- gsub("^f", "Frequency-", names(selectedData))
names(selectedData) <- gsub("-meanFreq()", "MeanFrequency", names(selectedData), ignore.case = TRUE)
names(selectedData) <- gsub("angle", "Angle", names(selectedData))
names(selectedData) <- gsub("tBody", "TimeBody", names(selectedData))
names(selectedData) <- gsub("gravity", "Gravity", names(selectedData))

## calculate the mean of each variable grouped by activity and subject
aggregatedData <- group_by(selectedData, Subject, Activity) %>%
  summarise_all(funs(mean))

write.table(aggregatedData, "OutputData.txt", row.names = FALSE, quote = FALSE)


