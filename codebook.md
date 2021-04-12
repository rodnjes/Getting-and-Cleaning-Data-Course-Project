# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project

## project goal
Combine datasets and clean them using skills taught in the Getting and Cleaning data Course given by John Hopkins University on Coursera

## Data description
Determines if a Samsung Galaxy S II worn by a group of 30 users can accurately determine when they are doing the activities of walking, walking upstairs, walking downstairs, sitting, standing, or laying using its accelerometer and gyroscope.

The datasets include:

  * triaxial acceleration from the accelerometer
  
  * estimated body acceleration
  
  * triaxial angual velocity from the gyroscope
  
  * a feature vector
  
  * the activity being performed
  
  * an id for each subject



The zip files that this is based on can be obtained [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Information about the dataset is found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Description of data variables
|variable  |Description
:-----------|:--------------------------------------------
|subject    | ID of participant
|activity   | The activity being performed
|tbodyacc-mean-x  | Mean acceleration time in the Y Direction
|tbodyacc-mean-y  | Mean acceleration time in the Y Direction
|tbodyacc-mean-z | Mean acceleration time in the Z Direction
|tbodyacc-std-x | Standard deviation of acceleration time in the X Direction
|tbodyacc-std-y | Standard deviation of acceleration time in the Y Direction
|tbodyacc-std-z | Standard deviation of acceleration time in the Z Direction
|tgravityacc-mean-x |Mean time of gravity acceleration in the X direction
|tgravityacc-mean-y |Mean time of gravity acceleration in the Y direction
|tgravityacc-mean-z |Mean time of gravity acceleration in the Z direction
|tgravityacc-std-x |Standard deviation of time of gravity acceleration in the X direction
|tgravityacc-std-y|Standard deviation of time of gravity acceleration in the Y direction
|tgravityacc-std-z |Standard deviation of time of gravity acceleration in the Z direction
|tbodyaccjerk-mean-x|Mean time of body acceleration jerk in the X direction
|tbodyaccjerk-mean-y|Mean time of body acceleration jerk in the y direction
|tbodyaccjerk-mean-z|Mean time of body acceleration jerk in the Z direction
|tbodyaccjerk-std-x|Standard deviation time of body acceleration jerk in the X direction
|tbodyaccjerk-std-y|Standard deviation time of body acceleration jerk in the y direction
|tbodyaccjerk-std-z|Standard deviation time of body acceleration jerk in the Z direction
|tbodygyro-mean-x|Mean time of body gyroscope in X direction
|tbodygyro-mean-y|Mean time of body gyroscope in Y direction
|tbodygyro-mean-z|Mean time of body gyroscope in Z direction
|tbodygyro-std-x|Standard deviation of time of body gyroscope movement in X direction
|tbodygyro-std-y|Standard deviation of time of body gyroscope movement in Y direction
|tbodygyro-std-z|Standard deviation of time of body gyroscope movement in Z direction
|tbodygyrojerk-mean-x|Mean time of gyroscope jerk in X direction
|tbodygyrojerk-mean-y|Mean time of gyroscope jerk in Y direction
|tbodygyrojerk-mean-z|Mean time of gyroscope jerk in Z direction
|tbodygyrojerk-std-x|Standard deviation of time of gyroscope jerk in X direction
|tbodygyrojerk-std-y|Standard deviation of time of gyroscope jerk in Y direction
|tbodygyrojerk-std-z|Standard deviation of time of gyroscope jerk in Z direction
|tbodyaccmag-mean| Mean magnitude of time for body acceleration
|tbodyaccmag-std| Standard Deviation of magnitude of time for body acceleration
|tgravityaccmag-mean|Mean magnitude of time for gravity acceleration
|tgravityaccmag-std|Standard Deviation of magnitude of time for gravity acceleration
|tbodyaccjerkmag-mean|Mean magnitude of time for jerk acceleration
|tbodyaccjerkmag-mean|Standard deviation of time for magnitude of jerk acceleration
|tbodygyromag-mean|Mean magnitude of time for body gyroscope movement
|tbodygyromag-std|Standard Deviation of magnitude of time for body gyroscope movement
|tbodygyrojerkmag-mean|Mean magnitude of time for gyroscope jerk
|tbodygyrojerkmag-std|Standard Deviation of magnitude of time for gyroscope jerk
|fbodyacc-mean-x|Mean frequency of body acceleration in X direction
|fbodyacc-mean-y|Mean frequency of body acceleration in Y direction
|fbodyacc-mean-z|Mean frequency of body acceleration in Z direction
|fbodyacc-mean-x|Standard deviation of frequency of body acceleration in X direction
|fbodyacc-mean-y|Standard deviation of frequency of body acceleration in Y direction
|fbodyacc-mean-z|Standard deviation of frequency of body acceleration in Z direction
|fbodyaccjerk-mean-x|Mean of frequency body jerk in X direction
|fbodyaccjerk-mean-y|Mean of frequency body jerk in Y direction
|fbodyaccjerk-mean-z|Mean of frequency body jerk in Z direction
|fbodyaccjerk-std-x|Standard deviation of frequency body jerk in X direction
|fbodyaccjerk-std-y|Standard deviation of frequency body jerk in Y direction
|fbodyaccjerk-std-z|Standard deviation of frequency body jerk in Z direction
|fbodygyro-mean-x|mean frequency of body gyroscope move in X direction
|fbodygyro-mean-y|mean frequency of body gyroscope move in Y direction
|fbodygyro-mean-z|mean frequency of body gyroscope move in Z direction
|fbodygyro-std-x|Standard deviation frequency of body gyroscope move in X direction
|fbodygyro-std-y|Standard deviation frequency of body gyroscope move in Y direction
|fbodygyro-std-z|Standard deviation frequency of body gyroscope move in Z direction
|fbodyaccmag-mean| Mean magnitude of frequency of body acceleration
|fbodyaccmag-std| Standard deviation of magnitude of frequency of body acceleration
|fbodybodyaccjerkmag-mean|  Mean magnitude of frequnecy of body acceleration jerk
|fbodybodyaccjerkmag-Std| Standard deviation of frequency of magnitude of body acceleration jerk
|fbodybodygyromag-mean| Mean magnitude of gyroscope frequency for body 
|fbodybodygyromag-std| Standard Deviation magnitude of gyroscope frequency for body 
|fbodybodygyrojerkmag-Mean| Mean of magnitude of gyroscope jerk frequency
|fbodybodygyrojerkmag-std| Standard Deviation of magnitude of gyroscope jerk frequency

## Steps taken to merge and clean data

All steps are included in the file run_analysis.R

#### libraries used

```{r}
library(dplyr)
```

### Step 1 Merge the training and the test sets to create one data set.
#### get the data from off the internet
```{r}
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./data")) {
  dir.create("./data")
}
zipFile <- download.file(url, "./data/data.zip")
unzip("./data/data.zip", exdir="./data")
file.remove("./data/data.zip")
```
#### get the test data
```{r}
dataPath <-"./data/UCI HAR Dataset/test/"
feature_test <-read.table(paste(dataPath,"X_test.txt",sep=""))
activity_test <-read.table(paste(dataPath,"Y_test.txt",sep=""))
subject_test <-read.table(paste(dataPath,"subject_test.txt",sep=""))                    
```
#### get the train data
```{r}
dataPath <-"./data/UCI HAR Dataset/train/"
feature_train <-read.table(paste(dataPath,"X_train.txt",sep=""))
activity_train <-read.table(paste(dataPath,"Y_train.txt",sep=""))
subject_train <-read.table(paste(dataPath,"subject_train.txt",sep=""))                    
```
#### get the column labels for the data
```{r}
dataPath <-"./data/UCI HAR Dataset/"
feature_labels <-read.table(paste(dataPath,"features.txt",sep=""))
feature_labels <-tolower(feature_labels[,2])
```

#### merge the training and test tables for X, Y, and subject
```{r}
activity_data<-rbind(activity_train,activity_test)
colnames(activity_data)<-("activity")
rm("activity_train","activity_test")

feature_data<-rbind(feature_train,feature_test)
colnames(feature_data)<-feature_labels
rm("feature_labels","feature_train","feature_test")

subject_data<-rbind(subject_train,subject_test)
colnames(subject_data)<-("subject")
rm("subject_train","subject_test")
```
#### merge all the subject, activity, and feature tables
```{r}
merged_data <- cbind(subject_data,activity_data,feature_data)
rm("subject_data","activity_data","feature_data")
```


### step 2 Extract the measurements on the mean and standard deviation for each measurement
#### look for feature labels with mean and std in them
```{r}
meanAndStdFeatures <- grep("-mean\\(\\)|-std\\(\\)", feature_labels)
```
#### move over 2 places to make room for the subject and activity column
```{r}
meanAndStdFeatures <- meanAndStdFeatures + 2
```
#### add in the subject and activity column
```{r}
meanAndStdFeatures <- c(1,2,meanAndStdFeatures) 
```
#### make a data frame with the desired columns

meanAndStd_data <- merged_data[meanAndStdFeatures]
rm("merged_data"","feature_labels")


### step 3 Uses descriptive activity names to name the activities in the data set
#### get the labels
```{r}
dataPath <-"./data/UCI HAR Dataset/"
activity_labels <-read.table(paste(dataPath,"activity_labels.txt",sep=""))
activity_labels <-c(tolower(activity_labels[,2]))
```
#### turn the activity column into a factor based on the labels
```{r}
meanAndStd_data$activity<-factor(meanAndStd_data$activity,labels =activity_labels)
rm("dataPath","activity_labels")

```
### step 4 Appropriately labels the data set with descriptive variable names. 
#### mostly done in part 1 where I got the column names from the features.txt file
#### get rid of "()" from the column names
```{r}
names(meanAndStd_data)<- sub("\\(\\)","",names(meanAndStd_data))
```
### step 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject
```{r}
means_data <- meanAndStd_data %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
View(means_data)
write.table(means_data, "./data/tidydata.txt", row.names = FALSE, quote = FALSE)
```
### summary mean data is in file tidydata.txt

