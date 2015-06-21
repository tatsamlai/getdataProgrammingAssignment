# 1. Merges the training and the test sets to create one data set.

## Read and merge training and test data
trainData = read.table("UCI HAR Dataset/train/X_train.txt")
testData = read.table("UCI HAR Dataset/test/X_test.txt")
tidyData = rbind(trainData, testData)

## Add variable(column) names to the data from features
features = read.table("UCI HAR Dataset/features.txt")
names(tidyData) = features$V2

## Merge the subject to each measurement
trainSubject = read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject = read.table("UCI HAR Dataset/test/subject_test.txt")
mergedSubject = rbind(trainSubject, testSubject)
tidyData$Subject = as.factor(mergedSubject$V1)

## Merge the activity to each measurement 
trainAct = read.table("UCI HAR Dataset/train/y_train.txt")
testAct = read.table("UCI HAR Dataset/test/y_test.txt")
mergedAct = rbind(trainAct, testAct)
tidyData$Activity = as.factor(mergedAct$V1)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

## Grep the columns that we are interested
## Only keep mean() columns but not the meanFreq() columns
## As meanFreq() is only the mean frequency in taking the measurements
## Keep Subject and Activity columns beside the mean and SD columns
col = grep("mean[^F]|std|Subject|Activity",names(tidyData))

## Only get the columns that we want
tidyData = tidyData[,col]

# 3. Uses descriptive activity names to name the activities in the data set

## Merge the activity labels according to the activities
actNames = read.table("UCI HAR Dataset/activity_labels.txt")
tidyData$Activity = actNames[tidyData$Activity,2]

# 4. Appropriately labels the data set with descriptive variable names

## Descriptive variable names are already added in step 1 by merging features

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Get the average of each variable for each activity and subject
tidyData2 = aggregate(.~Activity+Subject, data = tidyData, mean)
write.table(tidyData2, file = "tidyData2.txt", row.name = FALSE)
