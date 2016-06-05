# Goal is to merge two data sets, extract necessary variables, provide descriptive names to the extracted variables, and create a tidy data set

1. Download the source data from the link provided below and unzip to the working directory.
2. Perform the operations to meet the goal.

# Source data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# R script
1. Downloading and unzipping dataset
2. Merging the training and test sets to create one data set
    + Reading training files
    + Reading testing files
    + Reading feature file
    + Reading activity label file
    + Assigning column names
    + Merging training and test data sets
3. Extracting only the measurements on the mean and standard deviation for each measurement.
    + Extracting variable names that contain the words 'mean' and 'std'
    + Extracting variables identified in the previous step
4. Using descriptive activity names to name the activities in the data set
    + Adding a column 'activityType' which names the activity according to the 'activityId'
    + Removing the 'activityId' column and moving the last column 'activityType' to the first column
5. Appropriately labeling the data set with descriptive variable names
6. From the data set in the previous step, creating a second, independent tidy data set with the average of each variable for each activity and each subject.
    + Finding average of each variable for each acitivityType and each subject
    + Interchanging 'subjectId' and 'activityType' columns so that 'subjectId' and 'activityType' columns are the first and second columns in the data set, and ordering the data set based on 'subjectId' and 'activityType'
    + Writing the tidy data set to a text file 'tidyData.txt'
    
#### Note: The R script assumes that the unzipped folder is in the same folder as the R script.

# About variables
1. Features variable
    + feature varible is created using the data from the file features.txt.
    + This variable contains names of the 561 measurements measured by various sensors.
    + The names of this variables are the names of the columnn variables of xTrain and xTest
  discussed below
2. Training variables
    + xTrain, yTrain, and subjectTrain variables are created, respectively, using the data from the files train/X_train.txt, train/y_train.txt, and train/subject_train.txt.
    + xTrain contained 561 measurements of subjects in subjectTrain variable based on the activities described in yTrain variable.
2. Testing variables
    + xTest, yTest, and subjectTest variables are created, respectively, using the data in the files test/X_test.txt, test/y_test.txt, and test/subject_test.txt
    + xTest contained 561 measurements of subjects in subjectTest variable based on the activities described in yTest variable.
3. Merged data set
    + myData contains the merged train and test data sets with activityId variable replaced by 'activityType' varible which contains description of each and every activity.
    + Column (variable) names of myData have been renamed to contain the full measurement names instead of their acronyms.
4. Tidy data set
    + myData2 contains the average of each variable for each activity and each subject ordered according to 'subjectId' and 'activityType.'
4. Tidy data set file
    + tidyData.txt contains myData2 in simple text file format.