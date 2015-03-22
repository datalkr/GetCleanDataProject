## Script name: run_analysis.R
## Course 3 - Getting and Cleaning Data Course Project

## The data has been dowloaded and unzipped and placed 
## in the data directory inside the working directory

setwd ("C:/Users/lkr/Documents/CourseraClasses/GetCleanData_Project") 

## Read in the test and training data
xTrain <- read.table("./data/X_train.txt") 
yTrain <- read.table("./data/y_train.txt") 
subjectTrain <- read.table("./data/subject_train.txt") 
xTest <- read.table("./data/X_test.txt") 
yTest <- read.table("./data/y_test.txt")  
subjectTest <- read.table("./data/subject_test.txt") 
features <- read.table("./data/features.txt")
activity <- read.table("./data/activity_labels.txt")

## Merge the training and test data to create one data set.
joinData <- rbind(xTrain, xTest) 
joinLabel <- rbind(yTrain, yTest) 
joinSubject <- rbind(subjectTrain, subjectTest) 

## Extracts only the measurements on the mean and standard  
## deviation for each measurement.  
meanStdData <- grep("mean\\(\\)|std\\(\\)", features[, 2]) 
joinData <- joinData[, meanStdData] 

## Clean up some of the names
names(joinData) <- gsub("\\(\\)", "", features[meanStdData, 2]) ## remove "()" 
names(joinData) <- gsub("mean", "Mean", names(joinData)) ## capitalize M 
names(joinData) <- gsub("std", "Std", names(joinData)) ## capitalize S 
names(joinData) <- gsub("-", "", names(joinData)) ## remove "-" in column names  
names(joinData) <- gsub("BodyBody", "Body", names(joinData)) ## replace BodyBody with Body
names(joinData) <- gsub("^f","FreqDomain",names(joinData)) ## Replace f with FreqDomain
names(joinData) <- gsub("^t","TimeDomain",names(joinData)) ## Replace t with TimeDomain

## Uses descriptive activity names to name the activities   
## in the data set 
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) 
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) 
activityLabel <- activity[joinLabel[, 1], 2] 
joinLabel[, 1] <- activityLabel 
names(joinLabel) <- "activity" 


## Appropriately labels the data set with descriptive activity names.  
names(joinSubject) <- "subject" 
cleanData <- cbind(joinSubject, joinLabel, joinData) 

## Write out the clean data set
write.table(cleanData, "clean_data.txt")

## Create a tidy data set with the average of each 
## variable for each activity and each subject.  
subjectLength <- length(table(joinSubject))  
activityLength <- dim(activity)[1]  
columnLength <- dim(cleanData)[2] 
tidyData <- matrix(NA, nrow=subjectLength*activityLength, ncol=columnLength)  
tidyData <- as.data.frame(tidyData) 
colnames(tidyData) <- colnames(cleanData) 
row <- 1 
for(i in 1:subjectLength) { 
  for(j in 1:activityLength) { 
    tidyData[row, 1] <- sort(unique(joinSubject)[, 1])[i] 
    tidyData[row, 2] <- activity[j, 2] 
    cnt1 <- i == cleanData$subject 
    cnt2 <- activity[j, 2] == cleanData$activity 
    tidyData[row, 3:columnLength] <- colMeans(cleanData[cnt1&cnt2, 3:columnLength]) 
    row <- row + 1 
  } 
} 
#head(tidyData)
## Write out tidy data set
write.table(tidyData, "tidy_data.txt", row.names = FALSE) 
