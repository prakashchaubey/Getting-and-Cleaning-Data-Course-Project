

##Reading required files

trainx <- read.table("./course3_final_assign/UCI HAR Dataset/train/X_train.txt")
trainy <- read.table("./course3_final_assign/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("./course3_final_assign/UCI HAR Dataset/train/subject_train.txt")
testx <- read.table("./course3_final_assign/UCI HAR Dataset/test/X_test.txt")
testy <- read.table("./course3_final_assign/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("./course3_final_assign/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./course3_final_assign/UCI HAR Dataset/features.txt")
act_labels <- read.table("./course3_final_assign/UCI HAR Dataset/activity_labels.txt")

colnames(trainx) <- features[,2]
colnames(trainy) <- "activityID"
colnames(sub_train) <- "subjectID"
colnames(testx) <- features[,2]
colnames(testy) <- "activityID"
colnames(sub_test) <- "subjectID"
colnames(act_labels) <- c('activityID', 'activityType')

##combining files

comb_train <- cbind(trainy, sub_train, trainx)
comb_test <- cbind(testy, sub_test,testx)
master_com <- rbind(comb_train, comb_test)
colNames <- colnames(master_com)

standev_mean <- (grepl("activityID", colNames) |
  grepl("subjectID", colNames) |
  grepl("mean..", colNames) |
  grepl("std..", colNames))

standev_mean_set <- master_com[, standev_mean == TRUE]
Act_names_set <- merge(standev_mean_set, act_labels, by = 'activityID', all.x = TRUE)

tidy_set <- aggregate(.~subjectID + activityID, Act_names_set, mean)
tidy_set <- tidy_set[order(tidy_set$subjectID, tidy_set$activityID),]

write.table(tidy_set, "tidy_set.txt", row.names = FALSE)



