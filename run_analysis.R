rm(list = ls())

### Download the compressed dataset file
if(!file.exists("./data")) {
  dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")

### Unzip the dataset file
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

##### 1. Merges the training and the test sets to create one data set. #####
## (a) Reading training files
xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## (b) Reading testing files
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## (c) Reading feature file
features <- read.table("./data/UCI HAR Dataset/features.txt")

## (d) Reading activity label file
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

## (e) Assigning column names
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"
colnames(subjectTrain) <- "subjectId"

colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"
colnames(subjectTest) <- "subjectId"

colnames(activityLabels) <- c("activityId", "activityType")

## (f) Merging training and test data sets
train <- cbind(yTrain, subjectTrain, xTrain)
test <- cbind(yTest, subjectTest, xTest)
myData <- rbind(train, test)

##### 2. Extracts only the measurements on the mean and standard deviation for each measurement. #####
subFeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
extractFeatures <- c("activityId", "subjectId", as.character(subFeatures))
myData <- subset(myData, select = extractFeatures)

##### 3. Uses descriptive activity names to name the activities in the data set #####
myData <- merge(myData, activityLabels, by = "activityId", all.x = TRUE)
## (a) Removing the 'activityId' column
myData <- myData[,2:ncol(myData)]
## (b) Moving the last column 'activityType' to the first column
colId <- grep("activityType", names(myData))
myData <- myData[, c(colId, (1:ncol(myData))[-colId])]

##### 4. Appropriately labels the data set with descriptive variable names. #####
names(myData)<-gsub("^t", "time", names(myData))
names(myData)<-gsub("^f", "frequency", names(myData))
names(myData)<-gsub("Acc", "Accelerometer", names(myData))
names(myData)<-gsub("Gyro", "Gyroscope", names(myData))
names(myData)<-gsub("Mag", "Magnitude", names(myData))
names(myData)<-gsub("BodyBody", "Body", names(myData))

#####
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
#####
myData2 <- aggregate(. ~activityType + subjectId, myData, mean)
## (a) Moving 'subjectId' column to the first one
colId <- grep("subjectId", names(myData2))
myData2 <- myData2[, c(colId, (1:ncol(myData2))[-colId])]
myData2 <- myData2[order(myData2$subjectId, myData2$activityType), ]

## (b) Writing tidy data set to a file 'tidyData.txt'
write.table(myData2, file = "tidyData.txt", row.name = FALSE)
