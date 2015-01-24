#Programming Assignment 3

# Importing the test data
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
testY <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names ="Class")
testX <- read.table("./UCI HAR Dataset/test/X_test.txt")

#Importing the training data

trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Class")
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")

library(plyr)

# Importing the variable names and keeping only the 2nd column
feature <- read.table("./UCI HAR Dataset/features.txt",col.names = c("Column", "Description"), stringsAsFactors=FALSE )[,2]

# clean the variable names
feature <- gsub ( "\\()", "", gsub( "^t", "Time-", gsub ( "^f", "Frequency-", gsub ( "\\(t", "(Time-", gsub("\\),", ",", gsub("(?<=\\d),(?=\\d)", ":",features, perl = TRUE) ) ) ) ) )


# funnel the variable names to the column names of each data frame
colnames(testX) <- feature
colnames(trainX) <- feature

# bind the columns together for test and training data
test <- cbind(testsubject, testY, testX)
train <- cbind (trainsubject, trainY, trainX)

# bind all the rows together
data <- rbind(test,train)


# activity: class numbers and labels 
labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("Class","Label"))
data$Activity <- labels$Label[match(data$Class,labels$Class)]
#realign columns to have activity at top
data <- data[c(1:2,564,3:564)] 

# get the columns with mean and stdev values 
measure.mean.index <- grep("mean",colnames(data), ignore.case=TRUE)
measure.std.index <- grep("std", colnames(data), ignore.case=TRUE)
meanstddata <- data[c(1:3, measure.mean.index,measure.std.index)]


# call reshape2 package
library(reshape2)

# melt data set
meanstddatamelt <- melt(meanstddata, id = c("Subject","Class","Activity"),measure.vars=c(4:89),variable.name="Features",value.name="Signals")

#apply dcast formula to the problem
data.sub.tidy <- dcast(meanstddatamelt, Subject + Activity ~ Features,mean,value.var="Signals")
features.tidy <- c("Subject", "Activity", paste ( "Mean of", colnames(data.sub.tidy[,3:88])))
colnames(data.sub.tidy) <- features.tidy