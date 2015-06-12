# Readme
Course_Project_Getting_and_Cleaning_Data

Timothy Wilson
Submitted in fulfilment of the Course Project for the Getting and Cleanning Data course

THE DATASET

This repository contains three files:
(1) 'Readme.txt': this readme file
(2) 'run_analysis.R': an R script that will process the original data and produce a tidy dataset. This tidy dataset
contains an average of each variable for each activity and each subject from the original data.
(3) a codebook explaining the variables in the dataset that the codebook creates.

THE ORIGINAL DATA 

The original data was downloaded is the Human Activity Recognition Using Smartphones Dataset, Version 1.0.
It was downloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Whhen you download the original data from that link you will recieve a Readme file that explains the original data in depth.

WHAT THE ANALYSIS FILE ("run_analysis.R") DOES

The cleaning script ("run_analyais.R") will load the datasets into your working directory. 

It will then merge the training and test datasets and add the subject identifiers and the activity identifiers. 

The analysis file then selects only those variables that relate to the mean of a measurement or a standard deviation. It identifies those variables by searching for mean() and std().  This is based on the description in "features.txt".

The analysis file then labels each of the variables, seeking to preserve as much of the original notation as possible from the original dataset. 

For a description of this notation see the Codebookhttps://github.com/Econ4ahappyworld/Course_Project_Getting_and_Cleaning_Data/blob/master/CodeBook.md.  

For a complete decscription of this notation, load the "features.txt" from the original dataset.

The analysis file then averages each of the mean and standard deviations so that the final data set produces the average of each variable for each activity and each subject. 

The analysis file then saves this tidy dataset into your working directory.  It names the dataset "data.txt."

If you wish to open this dataset again in R, you can type "data <- read.table("data.txt", header = TRUE)
