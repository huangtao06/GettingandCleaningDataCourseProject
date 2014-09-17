##read all the data of training and test sets
Xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
subjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
Xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

##read the features
features<-read.table("./UCI HAR Dataset/features.txt")

##Step.1 Merges the training and the test sets to create one data set
Data<-cbind(rbind(subjecttrain,subjecttest),rbind(ytrain,ytest),rbind(Xtrain,Xtest))

##set the names of Data
names(Data)<-c("Subject","Activity",as.character(features[,2]))

##Step.2 Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)

##select columns which with "mean" or "std" in labels
extractdata<-select(Data,Subject,Activity,contains("mean"),contains("std"))

##Step.3 Uses descriptive activity names to name the activities in the data set
activity<-read.table("./UCI HAR Dataset/activity_labels.txt",colClasses=c("integer","character"))
for(i in 1:dim(extractdata)[1]){
  if(extractdata[i,2] %in% activity[,1]){
    extractdata[i,2]<-activity[which(activity[,1]==extractdata[i,2]),2]
  }   
}

##Step.4 Appropriately labels the data set with descriptive variable names
labels<-names(extractdata)

##delete the "()"s and "-"s in labels
labels<-gsub("()","",gsub("-","",labels),fixed=TRUE)
names(extractdata)<-labels

##Step.5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(tidyr)
##shape the data as 4 columns: Subject, Activity, feature, measurement
tidydata<-gather(extractdata,feature,measurement,-Subject,-Activity)

##get the average of each variable for each activity and each subject 
tidydata<-dcast(tidydata,Subject+Activity ~ feature , mean)

##get the tidydata with 4 columns: Subject, Activity, feature, Average
tidydata<-gather(tidydata, Feature, Average,-Subject,-Activity)

##Output tidydata as a csv
write.csv(tidydata,"tidydata.csv")
