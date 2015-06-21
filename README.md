## README.md

run_analysis.R should be run in your working directory along with the unzip data, i.e. the UCI HAR Dataset folder should be in your working directory. Nothing inside UCI HAR Dataset folder should be changed.

The output is tidyData2.txt and you can read it with read.table(header=TRUE) and view with View().

Belows are the details on my script implementatin:

### 1. Merges the training and the test sets to create one data set.

Read X_train.txt and X_test.txt and merge into one data set.

Add variable(column) names to the data set from features.txt.

Merge the subject to each measurement with data from subject_train.txt and subject_test.txt.

Merge the activity to each measurement with data from y_train.txt and y_test.txt.


### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

Only keep columns that have mean() and std() in the columns' names. I did not keep the meanFreq() columns, as meanFreq() is only the mean frequency in sampling the measurements. I also removed the xxxMean columns as those are obtained by averaging the signals in a signal window sample and used on the angle() variable which is not required by this step. 

However, I need to keep Subject and Activity columns for the following steps.


### 3. Uses descriptive activity names to name the activities in the data set

Merge activity number to the activity labels in activity_labels.txt.


### 4. Appropriately labels the data set with descriptive variable names

Descriptive variable names are already added in step 1 by merging the features and I don't see any advantage to change the name in any cosmetic way, so I just keep the same names. However, the descriptions of all the variables are specified in CodeBook.md.


### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To get the average of each variable for each activity and subject, I use aggregate function to calcuate the mean of all the the variables grouped by Activity and Subject variables. Then I write the data to tidyData2.txt as output. 

You can read and check the data with the following codes:

data = read.table("tidyData2.txt", header=TRUE)

View(data)