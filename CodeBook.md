---
title: "CodeBook"
author: "Annie Cheng"
date: "Friday, January 23, 2015"
output: html_document
---

This code book describes the variables, the data, and any transformations or work that 
was performed to clean up the data for the course project, and in particular, the 
run_analysis.R script.

To read and merge the raw data:
- downloaded data were unzipped into the /data subdirectory
- read activity_labels.txt into data table with columns activity_id and activity_label (variable activity_labels)
- read features.txt into data table with columns feature_id and feature_label
(variable features)
- read x_test.txt and x_train.txt into data table with all the fields initially
(variable x_test and x_train)
- then extract only fields in x_test and x_train with "std()" and "mean()", which includes MeanFreq() and std/mean for vector columns, based on the column names in the features vector
(variable selected_features)
- read y_test.txt and y_train.txt into data table with column activity_id
(variable y_test and y_train)
- read subject_test.txt and subject_train.txt into data table with column subject_id
(variable subject_test and subject_train)
- combine the training data set (where the measurements are already filtered for only fields we want)
(variable training)
- combine the testing data set (where the measurements are already filtered for only fields we want)
(variable testing)
- merge the training and testing set 
(variable all_data)

To calculate the average of each variable for each activity and each subject:
- after the merge, all_data has columns subject_id, activity_id, and selected features
- join all_data with activity_labels on activity_id
- group the joined data by subject_id and activity_id 
- then calculate the average for each joined row
- write output to tiny_data.txt


