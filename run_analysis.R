#librarys used
library(dplyr)

# Step 1 Merge the training and the test sets to create one data set.

# get the data from off the internet
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./data")) {
  dir.create("./data")
}
zipFile <- download.file(url, "./data/data.zip")
unzip("./data/data.zip", exdir="./data")
file.remove("./data/data.zip")

#get the test data
dataPath <-"./data/UCI HAR Dataset/test/"
feature_test <-read.table(paste(dataPath,"X_test.txt",sep=""))
activity_test <-read.table(paste(dataPath,"Y_test.txt",sep=""))
subject_test <-read.table(paste(dataPath,"subject_test.txt",sep=""))                    

#get the train data
dataPath <-"./data/UCI HAR Dataset/train/"
feature_train <-read.table(paste(dataPath,"X_train.txt",sep=""))
activity_train <-read.table(paste(dataPath,"Y_train.txt",sep=""))
subject_train <-read.table(paste(dataPath,"subject_train.txt",sep=""))                    

#get the column labels for the data
dataPath <-"./data/UCI HAR Dataset/"
feature_labels <-read.table(paste(dataPath,"features.txt",sep=""))
feature_labels <-tolower(feature_labels[,2])


#merge the training and test tables for X, Y, and subject
activity_data<-rbind(activity_train,activity_test)
colnames(activity_data)<-("activity")
rm("activity_train","activity_test")

feature_data<-rbind(feature_train,feature_test)
colnames(feature_data)<-feature_labels
rm("feature_train","feature_test")

subject_data<-rbind(subject_train,subject_test)
colnames(subject_data)<-("subject")
rm("subject_train","subject_test")

#merge all the subject, activity, and feature tables
merged_data <- cbind(subject_data,activity_data,feature_data)
rm("subject_data","activity_data","feature_data")


# step 2 Extract the measurements on the mean and standard deviation for each measurement
# look for feature labels with mean and std in them
meanAndStdFeatures <- grep("-mean\\(\\)|-std\\(\\)", feature_labels)
# move over 2 places to make room for the subject and activity column
meanAndStdFeatures <- meanAndStdFeatures + 2
# add in the subject and activity column
meanAndStdFeatures <- c(1,2,meanAndStdFeatures) 
# make a data frame with the desired columns
meanAndStd_data <- merged_data[meanAndStdFeatures]
rm("merged_data","feature_labels","meanAndStdFeatures")

# step 3 Uses descriptive activity names to name the activities in the data set
dataPath <-"./data/UCI HAR Dataset/"
activity_labels <-read.table(paste(dataPath,"activity_labels.txt",sep=""))
activity_labels <-c(tolower(activity_labels[,2]))
meanAndStd_data$activity<-factor(meanAndStd_data$activity,labels =activity_labels)
rm("dataPath","activity_labels")


# step 4 Appropriately labels the data set with descriptive variable names. 
names(meanAndStd_data)<- sub("\\(\\)","",names(meanAndStd_data))


# step5 creates a second, independent tidy data set with the average of each variable for each activity and each subject
means_data <- meanAndStd_data %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
View(means_data)
write.table(means_data, "./data/tidydata.txt", row.names = FALSE, quote = FALSE)

