Getting-and-cleaning-data
=========================
Extract all the file in the "UCI HAR Dataset".

Read all the files into R. The files are :
features.txt
X_test.txt
X_train.txt
y_test.txt
y_train.txt
activity_labels.txt
subject_test.txt
subject_train.txt

The first step is to merge all the data frames in on one data frames.
 Label all the variables with descriptive names
 Label the activity Labels.

Second step is to keep only the variables with the mean or std in their names. These will be the second data frame.

Finaly, create a third, independent tidy data set with the average of each variable for each activity and each subject

