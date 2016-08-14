install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)
install.packages("reshape2")
library(reshape2)
install.packages("stringr")
library(stringr)


##---------------------------------------------------------------------------------------------------------------------------
##                                                  PART 1
##---------------------------------------------------------------------------------------------------------------------------

##---------------------------------------------------------------------------------------------------------------------------
## READ SUBJECT ID FROM TRAINING TEXT FILE AND STORE IN A DATA TABLE CALLED 'Subject_ID_Train' WITH COLUMN NAME 'subject_id'.
##---------------------------------------------------------------------------------------------------------------------------


subject_train = read.table("subject_train.txt",sep = ",",col.names=c("subject_id"))
head(subject_train)

x <- as.data.table(subject_train)
file <- tempfile()
write.table(x, file=file, row.names=FALSE,col.names=TRUE, sep="\t", quote=FALSE)
Subject_ID_Train <- fread(file)
head(Subject_ID_Train,20)


##------------------------------------------------------------------------------------------------------------------------------
## READ ACTIVITY ID FROM TRAINING TEXT FILE AND STORE IN A DATA TABLE CALLED 'Activity_ID_Train' WITH COLUMN NAME 'activity_id'.
##------------------------------------------------------------------------------------------------------------------------------


y_train = read.table("y_train.txt",sep = ",",col.names=c("activity_id"))

y <- as.data.table(y_train)
file <- tempfile()
write.table(y, file=file, row.names=FALSE,col.names=TRUE, sep="\t", quote=FALSE)
Activity_ID_Train <- fread(file)
head(Activity_ID_Train )
dim(Activity_ID_Train)


##-------------------------------------------------------------------------------------------------------------------
## READ 561 BODY ACTIVITY MEASUREMENTS FOR EACH OF THE 30 SUBJECTS FROM TRAINING TEXT FILE AND STORE IN A DATA TABLE 
## CALLED 'Body_Activity_Train' WITH 561 COLUMNS CALLED 'tBodyAcc-mean()-X', 'tBodyAcc-mean()-Y' ETC.
##-------------------------------------------------------------------------------------------------------------------


x_train = read.table("X_train.txt", sep = ",",col.names=c("body_activity_train"))

z <- as.data.table(x_train)
file <- tempfile()
write.table(z, file=file, row.names=FALSE,col.names=TRUE, sep="\t", quote=FALSE)
Body_Activity_Train <- fread(file)
head(Body_Activity_Train)


##------------------------------------------------------------------------------------------------------------------------------
## COMBINE THE DATA TABLES CALLED 'Subject_ID_Train', 'Activity_ID_Train' AND 'Body_Activity_Train' INTO
## A SINGLE DATA TABLE CALLED "Train_data_table4".
##------------------------------------------------------------------------------------------------------------------------------


Train_data_table <- mutate(Body_Activity_Train, Activity_ID_Train$activity_id, Subject_ID_Train$subject_id)
Train_data_table2 <- arrange(Train_data_table, Activity_ID_Train$activity_id)
head(Train_data_table2)

Train_data_table3 <- cbind(Subject_ID_Train,Activity_ID_Train,Train_data_table2)
head(Train_data_table3)

Train_data_table4 <- select(Train_data_table3, subject_id:V561)
head(Train_data_table4)
dim(Train_data_table4)


##--------------------------------------------------------------------------------------------------------------------------
##                                                  PART 2
##--------------------------------------------------------------------------------------------------------------------------

##-------------------------------------------------------------------------------------------------------------------------
## READ SUBJECT ID FROM TESTING TEXT FILE AND STORE IN A DATA TABLE CALLED 'Subject_ID_Test' WITH COLUMN NAME 'subject_id'.
##-------------------------------------------------------------------------------------------------------------------------


subject_test = read.table("subject_test.txt",sep = ",",col.names=c("subject_id"))

x <- as.data.table(subject_test)
file <- tempfile()
write.table(x, file=file, row.names=FALSE,col.names=TRUE, sep="\t", quote=FALSE)
Subject_ID_Test <- fread(file)
head(Subject_ID_Test,20)


##----------------------------------------------------------------------------------------------------------------------------
## READ ACTIVITY ID FROM TESTING TEXT FILE AND STORE IN A DATA TABLE CALLED 'Activity_ID_Test' WITH COLUMN NAME 'activity_id'.
##----------------------------------------------------------------------------------------------------------------------------


y_test = read.table("y_test.txt", sep = ",",col.names=c("activity_id"))

y <- as.data.table(y_test)
file <- tempfile()
write.table(y, file=file, row.names=FALSE,col.names=TRUE, sep="\t", quote=FALSE)
Activity_ID_Test <- fread(file)
head(Activity_ID_Test)
dim(Activity_ID_Test)


##---------------------------------------------------------------------------------------------------------------------------
## READ 561 BODY ACTIVITY MEASUREMENTS FOR EACH OF THE 30 SUBJECTS FROM TESTING TEXT FILE AND STORE IN A DATA TABLE 
## CALLED 'Body_Activity_Test' WITH 561 COLUMNS CALLED 'tBodyAcc-mean()-X', 'tBodyAcc-mean()-Y' ETC.
##---------------------------------------------------------------------------------------------------------------------------


x_test = read.table("X_test.txt",sep = ",",col.names=c("body_activity_test"))

z <- as.data.table(x_test)
file <- tempfile()
write.table(z, file=file, row.names=FALSE,col.names=TRUE, sep="\t", quote=FALSE)
Body_Activity_Test <- fread(file)
head(Body_Activity_Test)


##------------------------------------------------------------------------------------------------------------------------------
## COMBINE THE DATA TABLES CALLED 'Subject_ID_Test', 'Activity_ID_Test' AND 'Body_Activity_Test' INTO
## A SINGLE DATA TABLE CALLED "Test_data_table4".
##------------------------------------------------------------------------------------------------------------------------------


Test_data_table <- mutate(Body_Activity_Test, Activity_ID_Test$activity_id, Subject_ID_Test$subject_id)
Test_data_table2 <- arrange(Test_data_table, Activity_ID_Test$activity_id)
head(Test_data_table2)

Test_data_table3 <- cbind(Subject_ID_Test,Activity_ID_Test,Test_data_table2)
head(Test_data_table3)

Test_data_table4 <- select(Test_data_table3, subject_id:V561)
head(Test_data_table4)
dim(Test_data_table4)


##--------------------------------------------------------------------------------------------------------------------------
##                                                  PART 3
##--------------------------------------------------------------------------------------------------------------------------

##--------------------------------------------------------------------------------------------------------------------------
## MERGE THE TWO DATA TABLES 'Train_data_table4' and 'Test_data_table4' VERTICALLY TO GET A SINGLE DATA TABLE 
## CALLED 'Merged_Data'.
##--------------------------------------------------------------------------------------------------------------------------

dim(Train_data_table4)
dim(Test_data_table4)
Merged_Data <- rbind(Train_data_table4,Test_data_table4) 
head(Merged_Data)
dim(Merged_Data)

##--------------------------------------------------------------------------------------------------------------------------
##                                                  PART 4
##--------------------------------------------------------------------------------------------------------------------------

##--------------------------------------------------------------------------------------------------------------------------
## EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH BODY ACTIVITY BY SUBJECT ID AND ACTIVITY ID
## BY USING THE 'GREP' COMMAND IN R TO SEARCH FOR COLUMN NUMBERS FOR WHICH THE COLUMN NAMES CORRESPOND TO THE LONG VARIABLE 
## NAMES HAVING 'MEAN' AND 'STD' IN THEM. 
## 
## THESE COLUMN NUMBERS ARE THEN MATCHED TO THEIR RESPECTIVE COLUMN NAMES WHICH ARE THEN MATCHED TO THEIR LONG VARIABLE NAMES
## FROM THE TEXT FILE CONTAINING THE LATTER.
##--------------------------------------------------------------------------------------------------------------------------


col_names = read.table("features.txt", sep = "\t")
head(col_names$V1)

v1 <- grep("mean", col_names$V1)
v2 <- grep("std", col_names$V1)
v3 <- c(v1,v2)
v4 <- sort(v3, decreasing = FALSE)

 means_and_std_devs <- select(Merged_Data,subject_id, activity_id, c(V1, V2, V3,V4, V5,V6, V41, V42, V43, V44,V45, V46,V81, V82, V83, V84, V85, V86,
                                            V121, V122, V123, V124, V125, V126, V161, V162, V163, V164, V165, V166,
                                            V201, V202, V214, V215, V227, V228, V240, V241, V253, V254, V266, V267, V268, V269, V270, V271, V294, V295, V296,
                                            V345, V346, V347, V348, V349, V350, V373, V374, V375,
                                            V424, V425, V426, V427, V428, V429, V452, V453, V454,
                                            V503, V504, V513, V516, V517, V526, V529, V530, V539, V542, V543, V552
                                            ))
head(means_and_std_devs)

 
##--------------------------------------------------------------------------------------------------------------------------
##                                                  PART 5
##--------------------------------------------------------------------------------------------------------------------------

##-------------------------------------------------------------------------------------------------------------------------
## CREATE AN INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT BY SELECTING
## THE APPROPRIATE COLUMNS FROM THE 'Merged_Data' DATA TABLE AND USING THE STRATEGY OF PART 4.  
##-------------------------------------------------------------------------------------------------------------------------
 
 
 avg_data <- select(Merged_Data,subject_id, activity_id,c(V1, V2, V3, V41, V42, V43, V81, V82, V83, 
                                                          V121, V122, V123, V161, V162, V163,
                                                          V201, V214, V227, V240, V253, V266, V267, V268, V294, V295, V296,
                                                          V345, V346, V347, V373, V374, V375,
                                                          V424, V425, V426, V452, V453, V454,
                                                          V503, V513, V516, V526, V529, V539, V542, V552))
 head(avg_data)
