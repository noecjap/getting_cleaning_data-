The run_analysis.R script shows the needed steps to reprossesing the dataset "Human Activity Recognition Using 
Smartphones"

1. Download the dataset
Dataset downloaded in local directory and unzip.

2. loading the dataset

calling
library(dplyr)
library(data.table)

Assign each data to variables

sjtrain <- subject_train.txt
contains train data of 21/30 volunteer subjects being observed
sjtest  <- subject_test.txt
contains test data of 9/30 volunteer test subjects being observed

ytrain <- y_train.txt
ytest  <- y_test.txt
contains the lables for 6 activities 

x_train <- x_train.txt: 7352 rows, 1 column
X_test  <- x_test.txt: 2947 rows, 1 column

feat <- features.txt:561 rows, 2 columns
activity <- activity_labels.txt: 6 rows, 2 columns
List of activities performed when the corresponding measurements 
were taken and its codes (labels)


3.Merges the training and the test sets to create one data set

As a result of merging train and test sets, it was obtained a data table (dataHa) with 10299 obs and 563 variables. for merging the data it was used rbind and cbind functions.


4.Extracts only the measurements on the mean and standard deviation for each measurement


TidyData (10299 rows, 88 columns) is created by subsetting dataHA, selecting only columns: subject, activity  and the measurements on the mean and standard deviation (std) for each measurement

5.Uses descriptive activity names to name the activities in the data set.

6. Appropriately labels the data set with descriptive variable names. 

Acc --> Accelerometer
Gyro --> Gyroscope
BodyBody --> Body"
Mag  --> Magnitude
^t --> Time
^f  --> Frequency
tBody --> TimeBody
-mean() --> Mean
-std() --> STD
-freq() --> Frequency
angle --> Angle
gravity --> Gravity


6. Creating a second, independent tidy data set with the average of each variable for each activity and each subject

FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.

Export FinalData into FinalData.txt file.
