library(dplyr)
library(reshape2)

#Creates a folder and then downloads and unzips the project files into that folder
if(!file.exists("./Rdata")){dir.create("./Rdata")}
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, destfile = "./RData/getdata.zip", method = "curl")
unzip("./Rdata/getdata.zip", exdir = "./Rdata")

testdata <- read.table("./Rdata/UCI HAR Dataset/test/x_test.txt")
colnames <- read.table("./Rdata/UCI HAR Dataset/features.txt")
activity <- read.table("./Rdata/UCI HAR Dataset/test/y_test.txt")
testsubjects <- read.table("./Rdata/UCI HAR Dataset/test/subject_test.txt")
colnames(testdata) <- colnames[,2] #labels the column names
testsubset <- testdata[, grep("mean|std", names(testdata), ignore.case = TRUE)]#selects columns with mean or standard deviation
testsubset$activity <- activity[,1] #creates new column with the activity assignment
testsubset$subject <- testsubjects[,1] #creates new column with the subject assignment


traindata <- read.table("./Rdata/UCI HAR Dataset/train/x_train.txt")
trainactivity <- read.table("./Rdata/UCI HAR Dataset/train/y_train.txt")
trainsubjects <- read.table("./Rdata/UCI HAR Dataset/train/subject_train.txt")
colnames(traindata) <- colnames[,2] #labels the column names
trainsubset <- traindata[, grep("mean|std", names(traindata), ignore.case = TRUE)]#selects columns with mean or standard deviation
trainsubset$activity <- trainactivity[,1] #creates new column with the activity assignment
trainsubset$subject <- trainsubjects[,1] #creates new column with the subject assignment

#combines test and training data sets into one data frame
jointdf <- full_join(testsubset, trainsubset)

#renames the activities in the data set to a descriptive activity
jointdf$activity[jointdf$activity ==1] <- "WALKING"
jointdf$activity[jointdf$activity ==2] <- "WALKING_UPSTAIRS"
jointdf$activity[jointdf$activity ==3] <- "WALKING_DOWNSTAIRS"
jointdf$activity[jointdf$activity ==4] <- "SITTING"
jointdf$activity[jointdf$activity ==5] <- "STANDING"
jointdf$activity[jointdf$activity ==6] <- "LAYING"

#creates a tidy data set called tidyds with the average for each variable for each activity for each subject

melted <-  melt(jointdf, id = c("subject", "activity"))
tidyds <- dcast(melted, subject + activity ~ variable, mean)
write.table(tidyds, file ="./Rdata/tidyds.txt", row.name = FALSE)






