## Add libraries
library(plyr)
library(reshape)
library(reshape2)
require(devtools)
source_gist(4676064)

## Unzip data files to the working directory
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

## Read in the training unzipped files from the working directory (default unzip path)
train_data <- read.table("UCI HAR Dataset/train/x_train.txt")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Append the label numbers for activity and subject to the training data
train_data$activity <- train_labels
train_data$subject <- train_subj

## Read in the testing unzipped files from the active directory (default unzip path)
test_data <- read.table("UCI HAR Dataset/test/x_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt")

## Append the label numbers for activity and subject to the training data
test_data$activity <- test_labels
test_data$subject <- test_subj

## Read in the activity number to human readable activity label conversion table
active_label <- read.table("UCI HAR Dataset/activity_labels.txt")

## Read in the feature number to human readable feature labels for column names
feature_cols <- read.table("UCI HAR Dataset/features.txt")

## Make sure all the data is in the correct format
train_data$activity <- unlist(train_data$activity)
train_data$subject <- unlist(train_data$subject)
test_data$activity <- unlist(test_data$activity)
test_data$subject <- unlist(test_data$subject)
active_label$V1 <- unlist(active_label$V1)
active_label$V2 <- unlist(active_label$V2)
feature_cols$V1 <- unlist(feature_cols$V1)
feature_cols$V2 <- unlist(feature_cols$V2)

## Combine the test and training data into a single dataset
all_data <- rbind(test_data, train_data)

## Rename columns to human readable descriptions
colnames(all_data)[1:(length(colnames(all_data))-2)] <- as.character(feature_cols$V2) 

## Append the human readable labels to the all_data dataset
all_data <- merge(all_data, active_label, by.x="activity", by.y="V1")

## Rename the appended column to be more human readable
colnames(all_data)[ncol(all_data)] <- "activity.description"

## Make sure all the data is in the correct format
all_data$activity.description <- unlist(all_data$activity.description)

## Subset the data to only include the mean and standard deviation factors
subset_all_data <- all_data[, c(grep("Mean",colnames(all_data)), grep("mean", colnames(all_data)), grep("std", colnames(all_data)))]
subset_all_data <- cbind(subset_all_data, subset(all_data, select=c("subject", "activity", "activity.description")))

## Switch data into 1 row per observation
subset_dataMelt <- melt(subset_all_data, id=c("activity.description", "subject", "activity"))

## Get the mean and standard deviation for each variable summarized by activity and subject
subset_dataMelt$activity_subject <- paste(as.character(subset_dataMelt$activity.description), ".", as.character(subset_dataMelt$subject))
summary_all <- dcast(subset_dataMelt, activity_subject ~ variable, mean)

## Convert to tidy data
output <- melt(summary_all, id="activity_subject")

## Write melted, tidy data to a file
write.table(output, file = "tidy_accel_data_courseproject.txt", sep = "\t", row.names = FALSE)

