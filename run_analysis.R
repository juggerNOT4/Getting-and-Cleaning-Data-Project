library(dplyr)
library(readr)

#Read the necessary files
X_test <-  read.table("./test/X_test")
y_test <-  read.table("./test/y_test")
subject_test <-  read.table("./test/subject_test")
X_train <-  read.table("./train/X_train")
y_train <-  read.table("./train/y_train")
subject_train <-  read.table("./train/subject_train")
features <- read.table("features.txt")

#merge the appropriate files using rbind
x_data_combined <- rbind(X_train , X_test)
y_data_combined <-  rbind(y_train, y_test)
subject_data_combined <- rbind(subject_train, subject_test)

#change names of subject_data_combined and y_data_combined
names(subject_data_combined) <- "subject"
names(y_data_combined) <-  "activity"

#change names of x_data_combined to the names provided in features
names(x_data_combined) <- features$V2

#add these two to x_data_combined using cbind
subject_y_combined <- cbind(subject_data_combined, y_data_combined)
mergedata <-  cbind(x_data_combined, subject_y_combined)

#we need names having mean() and std() only, so use grep to extract the names from features column 2 (V2)
features_mean_std <- features$V2[grep("mean\\(\\)|std\\(\\)",features$V2)]

#select mean, std, activity and subject related columns from mergedata

mergedata <- mergedata%>% select(as.character(features_mean_std), "subject", "activity")

#change the numbers in activity column to appropriate activity names (refer activity_labels.txt file)
mergedata$activity <- gsub("1", "Walking", mergedata$activity)
mergedata$activity <- gsub("2", "Walking_upstairs", mergedata$activity)
mergedata$activity <- gsub("3", "Walking_downstairs", mergedata$activity)
mergedata$activity <- gsub("4", "Sitting", mergedata$activity)
mergedata$activity <- gsub("5", "Standing", mergedata$activity)
mergedata$activity <- gsub("6", "Laying", mergedata$activity)


#Give appropriate names to the columns of mergedata, by subsituting the abbreviations (eg t is for Time, f is for Frequency)
names(mergedata) <-  gsub("^t", "Time", names(mergedata))
names(mergedata) <-  gsub("^f", "Frequency", names(mergedata))
names(mergedata) <-  gsub("Acc", "Accelerometer", names(mergedata))
names(mergedata) <-  gsub("Gyro", "Gyroscope", names(mergedata))
names(mergedata) <-  gsub("Mag", "Magnitude", names(mergedata))
names(mergedata) <-  gsub("BodyBody", "Body", names(mergedata))

#create a final, tidy data frame
finaldata <- mergedata %>% group_by(activity, subject)
finaldata <- finaldata%>% summarize_all(mean)

#view the final tidy data
View(finaldata)