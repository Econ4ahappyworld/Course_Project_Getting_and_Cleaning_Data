############# CLEANING SCRIPT for HUMAN ACTIVITY RECOGNITION USING SMARTPHONES DATASET

#If you have saved the downloaded data into a location that is different from your R working directory - 
# then set your working directory using the following code:
#setwd("[insert full address of working directory")
#remeber that if you are using Windows, you will need to change the direction of the slash [/]

## Loads the required packages to run this code
library(dplyr)
library(tidyr)

# Load the datasets

x_test <- tbl_df(read.table("test/X_test.txt"))
y_test <- tbl_df(read.table("test/Y_test.txt"))
subject_test <- tbl_df(read.table("test/subject_test.txt"))

x_train <- tbl_df(read.table("train/X_train.txt"))
y_train <- tbl_df(read.table("train/Y_train.txt"))
subject_train <- tbl_df(read.table("train/subject_train.txt"))

features <- read.table("features.txt")

activity_labels <- read.table("activity_labels.txt")

#### STEP ONE - MERGING

#add the subjects and the activities
x_test <- cbind(x_test, subject_test, y_test)
x_train <- cbind(x_train, subject_train, y_train)

#bind the test and the train datasets
data <- rbind(x_test, x_train)

#### STEP TWO - KEEP ONLY MEAN AND STD MEASUREMENTS

meankeep <- grep("mean", features[,2], ignore.case = TRUE)
stdkeep <- grep("std", features[,2], ignore.case = TRUE)

data <- data[, c(meankeep, stdkeep, 562:563)]

### STEP THREE - Explains the activities

colnames(activity_labels)[1:2] <- c("activity", "description")
colnames(data)[88] <- "activity"
data <- merge(data, activity_labels, by = "activity")

### STEP FOUR - Appropriate labels the data set with descriptive names

#this gets rid of the brackets in the variable names which cause
#complications when it comes to using dplyr
#we also omit the reference to mean to make things clearer
features[,2] <- gsub("\\(|\\)", "", features[,2])
features[,2] <- gsub("mean", "", features[,2])
features[,2] <- gsub("Mean", "", features[,2])
features[,2] <- gsub("\\-", "", features[,2])
features[,2] <- gsub("\\,", "", features[,2])
names <- features[c(meankeep, stdkeep),2]

colnames(data)[2:87] <- as.character(names)
colnames(data)[88] <- "subject"

#clear the global environment to keep things tidy
rm(subject_test, y_test, subject_train, y_train,x_test, x_train,
   activity_labels, names, features, stdkeep, meankeep)
   

### STEP FIVE - New data set with avg of each variable for each activity 
#and each subject

tidydata <- group_by(data, subject, description)

tidydata <- summarise(tidydata,
  tBodyAccX = mean(tBodyAccX), tBodyAccY = mean(tBodyAccY), 
  tBodyAccZ = mean(tBodyAccZ), tGravityAccX = mean(tGravityAccX),
  tGravityAccY= mean( tGravityAccY), tGravityAccZ = mean(tGravityAccZ), 
  tBodyAccJerkX= mean(tBodyAccJerkX),tBodyAccJerkY= mean(tBodyAccJerkY), 
  tBodyAccJerkZ= mean(tBodyAccJerkZ), tBodyGyroX = mean(tBodyGyroX), 
  tBodyGyroY = mean(tBodyGyroY), tBodyGyroZ = mean(tBodyGyroZ), 
  tBodyGyroJerkX = mean(tBodyGyroJerkX), tBodyGyroJerkY = mean(tBodyGyroJerkY),
  tBodyGyroJerkZ = mean(tBodyGyroJerkZ), tBodyAccMag = mean(tBodyAccMag), 
  tGravityAccMag = mean(tGravityAccMag), 
  tBodyAccJerkMag = mean(tBodyAccJerkMag), 
  tBodyGyroMag = mean(tBodyGyroMag), tBodyGyroJerkMag = mean(tBodyGyroJerkMag), 
  fBodyAccX = mean( fBodyAccX), fBodyAccY = mean( fBodyAccY), 
  fBodyAccZ = mean( fBodyAccZ), fBodyAccFreqX = mean(fBodyAccFreqX), 
  fBodyAccFreqY = mean(fBodyAccFreqY), fBodyAccFreqZ = mean(fBodyAccFreqZ), 
  fBodyAccJerkX  = mean(fBodyAccJerkX), fBodyAccJerkY   = mean(fBodyAccJerkY), 
  fBodyAccJerkZ   = mean(fBodyAccJerkZ), 
  fBodyAccJerkFreqX= mean(fBodyAccJerkFreqX),  
  fBodyAccJerkFreqY  = mean(fBodyAccJerkFreqY), 
  fBodyAccJerkFreqZ  = mean(fBodyAccJerkFreqZ), fBodyGyroX = mean(fBodyGyroX), 
  fBodyGyroY = mean(fBodyGyroY), fBodyGyroZ = mean(fBodyGyroZ ), 
  fBodyGyroFreqX  = mean(fBodyGyroFreqX ), 
  fBodyGyroFreqY  = mean(fBodyGyroFreqY),  
  fBodyGyroFreqZ = mean(fBodyGyroFreqZ), fBodyAccMag   = mean(fBodyAccMag),  
  fBodyAccMagFreq = mean(fBodyAccMagFreq),  
  fBodyBodyAccJerkMag = mean(fBodyBodyAccJerkMag),  
fBodyBodyAccJerkMagFreq = mean(fBodyBodyAccJerkMagFreq), 
fBodyBodyGyroMag = mean(fBodyBodyGyroMag),  
fBodyBodyGyroMagFreq = mean(fBodyBodyGyroMagFreq),  
fBodyBodyGyroJerkMag  = mean(fBodyBodyGyroJerkMag ),  
fBodyBodyGyroJerkMagFreq = mean(fBodyBodyGyroJerkMagFreq  ),
angletBodyAccgravity = mean( angletBodyAccgravity ), 
angletBodyAccJerkgravity = mean( angletBodyAccJerkgravity), 
angletBodyGyrogravity  = mean(   angletBodyGyrogravity), 
angletBodyGyroJerkgravity = mean( angletBodyGyroJerkgravity), 
angleXgravity  = mean(angleXgravity ), angleYgravity = mean(angleYgravity), 
angleZgravity  = mean(angleZgravity),  tBodyAccstdX = mean(tBodyAccstdX ),
tBodyAccstdY = mean(tBodyAccstdY ), tBodyAccstdZ= mean(tBodyAccstdZ ), 
tGravityAccstdX   = mean(tGravityAccstdX   ), 
tGravityAccstdY = mean(tGravityAccstdY   ), 
tGravityAccstdZ= mean(tGravityAccstdZ   ), 
tBodyAccJerkstdX  = mean(tBodyAccJerkstdX  ),  
tBodyAccJerkstdY  = mean( tBodyAccJerkstdY  ),  
tBodyAccJerkstdZ = mean(tBodyAccJerkstdZ  ),  
tBodyGyrostdX   = mean(tBodyGyrostdX),  tBodyGyrostdY  = mean(tBodyGyrostdY),  
tBodyGyrostdZ   = mean(tBodyGyrostdZ), 
tBodyGyroJerkstdX  = mean(tBodyGyroJerkstdX ), 
tBodyGyroJerkstdY   = mean(tBodyGyroJerkstdY ),  
tBodyGyroJerkstdZ  = mean(tBodyGyroJerkstdZ ),  
tBodyAccMagstd= mean(tBodyAccMagstd),  
tGravityAccMagstd = mean(tGravityAccMagstd ), 
tBodyAccJerkMagstd  = mean(tBodyAccJerkMagstd),  
tBodyGyroMagstd = mean(tBodyGyroMagstd   ),  
tBodyGyroJerkMagstd  = mean(tBodyGyroJerkMagstd   ),  
fBodyAccstdX   = mean(fBodyAccstdX ),  
fBodyAccstdY  = mean(fBodyAccstdY ),  
fBodyAccstdZ  = mean(fBodyAccstdZ ),  
fBodyAccJerkstdX  = mean(fBodyAccJerkstdX  ),  
fBodyAccJerkstdY = mean(fBodyAccJerkstdY  ),  
fBodyAccJerkstdZ   = mean(fBodyAccJerkstdZ  ),  
fBodyGyrostdX  = mean(fBodyGyrostdX),  fBodyGyrostdY= mean(fBodyGyrostdY),  
fBodyGyrostdZ   = mean(fBodyGyrostdZ),  fBodyAccMagstd  = mean(fBodyAccMagstd),
fBodyBodyAccJerkMagstd = mean(fBodyBodyAccJerkMagstd), 
fBodyBodyGyroMagstd = mean(fBodyBodyGyroMagstd),   
fBodyBodyGyroJerkMagstd = mean( fBodyBodyGyroJerkMagstd)
)

#Saves the tidy data into a data file

write.table(tidydata, "data.txt", row.name = FALSE)

