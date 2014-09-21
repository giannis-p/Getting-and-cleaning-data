# SetmWorking Directory to UCI HAR Dataset

if(getwd()!="C:/Users/NIKOS/Documents/learnr/UCI HAR Dataset"){
    setwd("C:/Users/NIKOS/Documents/learnr/UCI HAR Dataset")
}
# Clead the workspace

rm(list=ls())

## Read all the files into R. 


 features<-read.table("features.txt")

 x_test<-read.table("X_test.txt")

 x_train<-read.table("X_train.txt")

 activity_labels<-read.table("activity_labels.txt")

 test_labels<-read.table("y_train.txt")

 train_labels<-read.table("y_test.txt")

 subject_test<- read.table("subject_test.txt")

 subject_train<- read.table("subject_train.txt")

# Merge "train_x" with "test_x"

 train_test_set<- rbind(x_train,x_test)

# Label the variables of "train_test_set" from the "feature"

names(train_test_set)<-as.character(features[,2])

# Merge  "subject_train" kai "subject_test"


subject_train_test<-rbind(subject_train,subject_test)

# Name the variable "V1" as "Subject"

names(subject_train_test)<-"Subject"
# Now let's wprk with the train and test label
# Merge "train_labels" and "test_labels"
#  Replace the variables "1,2,3,4,5,6" with the "activity labels"
# Rename the variable "V1" in "activity_labels"
library(plyr)
labels_train_test<-rbind(train_labels,test_labels)
Lables_train_test<-join(labels_train_test,activity_labels)

#Keep only the variable"V2" from the set
# Rename variable "V1" to "activity_labels"

Labels_train_test<-Lables_train_test["V2"]
names(Labels_train_test)<-"activity_labels"

#Merge  "subject_train_test" and "Labels_train_test"

subject_Labels<-cbind(subject_train_test,Labels_train_test)

#Merge subject_Labels and "train_test_set" This is the
#first tidy data set with 10299 obs and 563 variables

allof<-cbind(subject_Labels,train_test_set)

#Find the position of mean and  std

varmean<-grep("mean",names(allof),ignore.case=TRUE)
varmstd<-grep("std",names(allof),ignore.case=TRUE)
varmeanstd<-sort(c(varmean,varmstd))

#create a temporary dataframe
# This is the data frame with 10299 obs and 88 variables(those with mean() and std() )

temporary<-allof[,names(allof)[varmeanstd]]
finale<-cbind(allof[,1:2],temporary)

## Step 5  
library(reshape2)
# Melt the "finale" data set with the id="Subject" and "activity_labels"

temp<-melt(finale, id=c("Subject", "activity_labels"))

# Create the tidy data set with the mean 

tidy <- dcast(temp, Subject + activity_labels ~ variable, mean, na.rm=TRUE)

## Create the "tidy.txt" file

write.table(tidy,file="tidy.txt",row.name=FALSE)