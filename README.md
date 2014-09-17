GettingandCleaningDataCourseProject
===================================

The Course Project of Getting and Cleaning Data

*Use the read.table function to read all the data of training and test sets

*Step.1 Merges the training and the test sets to create one data set

  Use cbind and rbind to merge the data sets.
  Set the names() of the data using features.txt.
  
*Step.2 Extracts only the measurements on the mean and standard deviation for each measurement.

  Use select() in "dplyr" package, select all the columns with "mean" or "std" in labels

*Step.3 Uses descriptive activity names to name the activities in the data set

  Form a matrix with activity_labels.txt, column 1 is 1 to 6, column 2 is the activities
  Replace 1 to 6 in the activity column with descriptive activity names, such as "1" is replaced by "WALKING"

*Step.4 Appropriately labels the data set with descriptive variable names

  Delete the "()"s and "-"s in labels to form descriptive variable names

*Step.5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  Source to "tidyr" package, use the gather() and dcast() functions
  First shape the data as 4 columns: Subject, Activity, feature, measurement, it can be done easily with gather()
  Second get the average of each variable for each activity and each subject with dcast().
  The output is a matrix, each columns refer to a variable, each row refer to a subject and a activity
  Finally, use gather() again to get the tidydata, which has 4 columns: Subject, Activity, Feature, Average
