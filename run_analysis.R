
# Getting and Cleaning Data Course Project
# Creating a tidy dataset with data collected from a Samsung Galaxy S smartphone
# and then output the clean data set to a text file

library(dplyr)

# Downloading the file if it does not already exist in the directory

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zfile <- "UCI HAR Dataset.zip"
filename <- "UCI HAR Dataset"

if(!file.exists(zfile)){
  download.file(URL,zfile,mode='wb')
}

if(!file.exists(filename)){
  unzip(zFile)
}

# Reading the downloaded data

trainingsubjects <- read.table(file.path(filename,'train','subject_train.txt'))
trainingvalues <- read.table(file.path(filename,'train','X_train.txt'))
trainingactivity <- read.table(file.path(filename,'train','y_train.txt'))

testsubjects <- read.table(file.path(filename,'test','subject_test.txt'))
testvalues <- read.table(file.path(filename,'test','X_test.txt'))
testactivity <- read.table(file.path(filename,'test','y_test.txt'))

features <- read.table(file.path(filename,'features.txt'),as.is = TRUE)


activities <- read.table(file.path(filename,'activity_labels.txt'))
colnames(activities) <- c('activityId','activityLabel')

# Merging the training and test sets to create one data set

humanactivity <- rbind(cbind(trainingsubjects,trainingvalues,trainingactivity),
                       cbind(testsubjects,testvalues,testactivity))

rm(trainingsubjects,trainingvalues,trainingactivity,testsubjects,testvalues,testactivity)

colnames(humanactivity) <- c('subject',features[,2],'activity')

# Extract only the mean and standard deviation for each measurement 

keepcolumns <- grepl('subject|activity|mean|std',colnames(humanactivity))
humanactivity <- humanactivity[,keepcolumns]

# Use descriptive activity names to names the activities

humanactivity$activity <- factor(humanactivity$activity,levels=activities[,1],labels=activities[,2])

# Appropriately label the data set

humanactivity_col <- colnames(humanactivity)
humanactivity_col <-gsub('[\\(\\)-]',"",humanactivity_col)

humanactivity_col <- gsub('^f',"frequencyDomain",humanactivity_col)
humanactivity_col <- gsub('^t','timeDomain',humanactivity_col)
humanactivity_col <- gsub('Acc',"Accelerometer",humanactivity_col)
humanactivity_col <- gsub('Gyro','Gyroscope',humanactivity_col)
humanactivity_col <- gsub('Mag','Magnitude',humanactivity_col)
humanactivity_col <- gsub('Freq',"Frequency",humanactivity_col)
humanactivity_col <- gsub('std','StandardDeviation',humanactivity_col)

humanactivity_col <- gsub('BodyBody','Body',humanactivity_col)

colnames(humanactivity) <- humanactivity_col

# Create an independent tidy data set in a text file

humanactivity_mean <- humanactivity %>%
  group_by(subject,activity) %>%
  summarise_each(funs(mean))

write.table(humanactivity_mean,"tidy_data.txt",row.names=FALSE,quote=FALSE)



