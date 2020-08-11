###Run_analisys


Durl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(Durl,destfile="C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/Getting-and-Cleaning-Data-C3/Dataset.zip",method="curl")

library(dplyr)
library(data.table)

unzip(zipfile = "C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI_HAR_Dataset.zip")

###loading data
###continen los sujetos selecionados para los conjuntos de train (21 sujetos)
###y para el conjunto de test (9 sujetos)
sjtrain <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/train/subject_train.txt",header = FALSE)
sjtest  <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/test/subject_test.txt",header = FALSE)


sjtrain_n<-sjtrain[, .N, by = V1]
#me devuelve las frecuencias de la tabla SubTrain para la variable V1


###cargando los lables "y" para los conjuntos test y training
ytrain <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/train/y_train.txt",header = FALSE)
ytest  <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/test/y_test.txt",header = FALSE)

ytrain_n<-ytrain[, .N, by = V1]
#me devuelve las frecuencias de la tabla ytrain para la variable V1


####cargando la data para x_train e x-test
x_train <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/train/x_train.txt",header = FALSE)
X_test  <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/test/x_test.txt",header = FALSE)

####cargando los labels y las actividades para las variables V1 hasta V561 de features
feat <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/features.txt", col.names = c("index", "feature"))

activity <- read.table("C:/Users/angel/OneDrive/Desktop/Coursera_9/ProjectC3/UCI HAR Dataset/activity_labels.txt", col.names = c("index", "activity"))
)


#####-1- Merges the training and the test sets to create one data set.

sjt1<-rbind(sjtrain, sjtest)
#crea una nueva tabla de una variable V1, con 10299 obs (7352 come from sjtrain + 2947 come from sjtest)

yt1<- rbind(ytrain, ytest)  
#crea una nueva tabla de una variable V1, con 10299 obs (7352 come from ytrain + 2947 come from ytest)

xt1<- rbind(x_train, X_test)  
#crea una nueva tabla de una variable V1, con 10299 obs (7352 come from x_train + 2947 come from X_test)

colnames(sjt1) <- "subject"
colnames(yt1) <- "activity"
colnames(xt1) <- t(feat[2])
#asigna a las variables V1...V561 los nombres de feat table.

dataHa<-cbind(sjt1, yt1, xt1)
#crea una base que merge train and test data base


#### -2- Extracts only the measurements on the mean and standard deviation for each measurement. 
selecDataH<-select(dataHa,subject, activity, contains("mean"), contains("std"))


#### -3-	Uses descriptive activity names to name the activities in the data set
selecDataH$activity<-activity[selecDataH$activity,2]

#### -4- Appropriately labels the data set with descriptive variable names. 

names(selecDataH)<-gsub("Acc", "Accelerometer", names(selecDataH))
names(selecDataH)<-gsub("Gyro", "Gyroscope", names(selecDataH))
names(selecDataH)<-gsub("BodyBody", "Body", names(selecDataH))
names(selecDataH)<-gsub("Mag", "Magnitude", names(selecDataH))
names(selecDataH)<-gsub("^t", "Time", names(selecDataH))
names(selecDataH)<-gsub("^f", "Frequency", names(selecDataH))
names(selecDataH)<-gsub("tBody", "TimeBody", names(selecDataH))
names(selecDataH)<-gsub("-mean()", "Mean", names(selecDataH), ignore.case = TRUE)
names(selecDataH)<-gsub("-std()", "STD", names(selecDataH), ignore.case = TRUE)
names(selecDataH)<-gsub("-freq()", "Frequency", names(selecDataH), ignore.case = TRUE)
names(selecDataH)<-gsub("angle", "Angle", names(selecDataH))
names(selecDataH)<-gsub("gravity", "Gravity", names(selecDataH))

####-5-	From the data set in step 4, creates a second, independent tidy data set
####    with the average of each variable for each activity and each subject.

tidyDataHa <- selecDataH

FinalData <- tidyDataHa %>% group_by(subject, activity) %>% summarise_all(funs(mean))

write.table(FinalData, "FinalData.txt", row.name=FALSE)

