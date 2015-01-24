#Code book for reproducibility

First the data needed for the assignment came from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This was a zip file and all the files from the zip were extracted as the "UCI HAR Dataset" in the "documents" section, which is the default working directory for the computer.


The following files were used for the following and were coded as the following variables:



feature <- 'features.txt': List of all features.

labels <- 'activity_labels.txt': Links the class labels with their activity name.

trainX <- 'train/X_train.txt': Training set.

trainY <- 'train/y_train.txt': Training labels.

trainsubject <- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

testX <- 'test/X_test.txt': Test set.

testY <- 'test/y_test.txt': Test labels.

testsubject <- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


All the files above are then importing using the read.table. The col.names are set to "Class" for (trainY and testY). The col.names are set to "Subject" for testsubject and trainsubject variables

After importing "feature", the variables of the file need to be cleaned up. The "gsub" function is used to perform substitions for all the variables in the "feature" file. This essentially cleans up all the crap off the names of the columns. 

Then the variable names are funneled into the testX and trainX by using the colnames() function and calling the feature file

Now, the columns can be bound together using the cbind() function. This is used to bind all the training data (trainingsubject, trainX, trainY) and test data (testsubject, trainX, trainY)
into their own data sets of "train" and "test".

After the columns are bound together, the both sets can be merged together using the rbind() function into a data set called "data".

Now the labels need to be added. So the "label" data is created calling on the "UCI HAR Dataset"

"data$Activity" is subset from data and is the last column of the "data" columns

"data" is then rearranged via the following vectors "data[c(1:2,564,3:564)]"

Now, the data is tidy enough to access the mean and standard deviation of each column. Therefore the "grep" function (this function searches for matches for each element in a character vector, in this case the vector is "data") is used to create the "measure.means.index" and "measure.std.index".

"meanstddata" is created and is a data set containing both the means and stds of the "data" data set.

The reshape2 package is then loaded into the script to help "reshape" the data

The "melt" function is then used to convert "meansstddata" into molten data frame to set up the data for "casting" which puts the data into a new data frame

"tidy.sub.data" is then created by using the dcast function.

Hopefully this explains everything that you need to reproduce this project and explains any gaps









 


