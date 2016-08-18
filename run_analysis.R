install.packages("dplyr")
install.packages("data.table")
install.packages("stringr")


library(dplyr)
library(stringr)
library(data.table)


##------------------------------------------------------------------------------------
## Read the activity labels and features labels text files from the UCI HAR data set
##------------------------------------------------------------------------------------

activity_labels <- read.table(file = "activity_labels.txt")
features <- read.table(file = "features.txt")

##------------------------------------------------------------------------------------
## Read the subject_train, x_train and y_train text files from the training data set
##------------------------------------------------------------------------------------

setwd("train")
subject_train = read.table(file = "subject_train.txt")
xtrain <- read.table(file = "X_train.txt")
ytrain <- read.table(file = "y_train.txt")

##---------------------------------------------------
## Assign descriptive names to the activity labels
##---------------------------------------------------

activity = factor(ytrain$V1,labels = c(" WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING"," STANDING"," LAYING"))

##------------------------------------
## Create a single training data set
##------------------------------------

train <- cbind(subject_train, activity, xtrain)

setwd("..")

##-----------------------------------------------------------------------------
## Read the subject_test, x_test and y_test text files from the test data set
##-----------------------------------------------------------------------------

setwd("test")
subject_test = read.table(file = "subject_test.txt")
xtest <- read.table(file = "X_test.txt")
ytest <- read.table(file = "y_test.txt")

##--------------------------------------------------
## Assign descriptive names to the activity labels
##--------------------------------------------------

activity = factor(ytest$V1,labels = c(" WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING"," STANDING"," LAYING"))

##--------------------------------
## Create a single test data set
##--------------------------------

test <- cbind(subject_test, activity, xtest)

##-------------------------------------------------------------------
## Merge the training and the test data sets to create one data set
##-------------------------------------------------------------------

train_and_test = rbind(train,test)

##-------------------------------------------------------------------
## Assign descriptive names to the columns of the merged data set
##-------------------------------------------------------------------

names(train_and_test)[1] <- "Subject_ID"
names(train_and_test)[2] <- "Activity_ID"
names(train_and_test)[-(1:2)] <- as.character(features$V2)

##-----------------------------------------------------------------------------------
## Isolate the columns that correspond to the mean and standard deviation variables
##-----------------------------------------------------------------------------------

mean_and_std <- train_and_test[grepl("mean|std",names(train_and_test))]

##--------------------------------------------------------------------------------------------------
## Create a new tidy data set with the average of each variable for each activity and each subject
##--------------------------------------------------------------------------------------------------

mean_data <- train_and_test[grepl("mean",names(train_and_test))]
avg_data <- cbind(train_and_test$Subject_ID, train_and_test$Activity_ID, mean_data)
names(avg_data)[1] <- "Subject_ID"
names(avg_data)[2] <- "Activity_ID"
head(avg_data)

##---------------------------------------------
## Write the data set in a separate text file
##---------------------------------------------

write.table(avg_data, file = "avg_data", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
