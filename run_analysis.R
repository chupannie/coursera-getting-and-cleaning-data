#############################################################################################
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 
# You will be required to submit: 
#   1) a tidy data set as described below, 
#   2) a link to a Github repository with your script for performing the analysis, and 
#   3) a code book that describes the variables, the data, and any transformations or work that 
# you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  
#############################################################################################

############################################################################################## 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
#
# 
#############################################################################################

setwd("~/My Projects/data science/3 - getting and cleaning data/course project")

## install all the necessary packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

library(data.table)
library(dplyr)

## 0. read the activity and feature data
activity_labels = read.table("data/activity_labels.txt", header=FALSE,col.names=c("activity_id","activity_label"))
features <- read.table("data/features.txt", header=FALSE, col.names=c("feature_id","feature_label"))

## 1. read the training data 
x_train <- read.table("data/train/X_train.txt", header=FALSE)
y_train <- read.table("data/train/y_train.txt", header=FALSE,col.names=c("activity_id"))
subject_train <- read.table("data/train/subject_train.txt", header=FALSE, col.names=c("subject_id"))

## 1.1. Extracts only the measurements on the mean and standard deviation for each measurement. 
selected_features <- grep("mean()|std()", features[,2])
x_train <- x_train[,selected_features]
names(x_train) = features[selected_features,2]
training <- cbind(subject_train,y_train,x_train)

## 2. read the testing data 
x_test <- read.table("data/test/X_test.txt", header=FALSE)
y_test <- read.table("data/test/y_test.txt", header=FALSE, col.names=c("activity_id"))
subject_test <- read.table("data/test/subject_test.txt", header=FALSE, col.names=c("subject_id"))
## 1.1. Extracts only the measurements on the mean and standard deviation for each measurement. 
x_test <- x_test[,selected_features]
names(x_test) = features[selected_features,2]
testing <- cbind(subject_test,y_test,x_test)

## 3. merge training and testing data
all_data <- rbind(training,testing)


## 5. average of each variable for each activity and each subject
## uses the dplyr package and chained syntax for speed

all_data %>%
  inner_join(activity_labels,by="activity_id") %>%
  group_by(subject_id,activity_id,activity_label) %>%
  summarise_each(funs(mean)) %>%
  write.table(file ="./tidy_data.txt", row.names=FALSE)
#############################################################################################