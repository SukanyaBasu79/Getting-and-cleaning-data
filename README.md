# Getting-and-cleaning-data
## Final Course Project:
## This repo explains how all of the scripts work and how they are connected.


The R script is broken down into five broad parts based on the five tasks assigned in the course project. Each part is further broken down into smaller sub-parts each of which accomplishes a specific task as detailed below.

   ==========================================================================================
                                             PART 1
   ==========================================================================================

 i. Reads the subject ID from the training data text file and store it in a data table called 
   'Subject_ID_Train' with column name 'subject_id’.

ii. Reads the activity ID from the training data text file and store it in a data table called 
    ‘Activity_ID_Train' with column name ‘activity_id’.

iii. Reads the 561 body activity measurements for each of the 30 subjects from the training text
     file and store it in a data tablecalled  'Body_Activity_Train' with 561 columns called 
     'tBodyAcc-mean()-X', 'tBodyAcc-mean()-Y' etc.

iv. Combines the data tables called ‘Subject_ID_Train’, ‘Activity_ID_Train’ and  ‘Body_Activity_Train’ 
    into a single data table called ‘Train_data_table4’.

   ==========================================================================================
                                             PART 2
   ==========================================================================================

                      (Repeats the steps of part 1 for the testing data set.)

i.    Reads the subject ID from the testing data text file and store it in a data table called
     'Subject_ID_Test’ with column name 'subject_id’.

ii.   Reads the activity ID from the testing data text file and store it in a data table called
      ‘Activity_ID_Test’ with column name ‘activity_id’.

iii.  Reads the 561 body activity measurements for each of the 30 subjects from the testing
      text file and store it in a data table called 'Body_Activity_Test’ with 561 columns 
      called 'tBodyAcc-mean()-X', 'tBodyAcc-mean()-Y' etc.

iv.   Combines the data tables called ‘Subject_ID_Test’, ‘Activity_ID_Test’ and  ‘Body_Activity_Test’ 
      into a single data table called ‘Test_data_table4’.

  ==========================================================================================
                                             PART 3
  ==========================================================================================

i.     Merges the two data tables called ‘Train_data_table4’ and 'Test_data_table4' from 
       parts 1 and 2  vertically  to give a single data table called 'Merged_Data’.

  ==========================================================================================
                                             PART 4
  ==========================================================================================

i.     Extracts only the measurements on the mean and standard deviation for each body activity 
       by subject ID and activity ID by using the ‘grep’ command in R to search for column
       numbers for which the column names correspond to the long variable names having ‘mean’ 
       and ‘std’ in them.

       These column numbers are then matched to their respective column names which are then 
       matched to their long variable names from the text file containing the latter.

  ==========================================================================================
                                              PART 5
  ==========================================================================================

i.      Creates an independent tidy data set with the average of each variable for each activity 
        and each subject by selecting the appropriate columns from the ‘Merged_Data’ data table 
        and using the strategy of part 4.


                                      ————————————————————————————————


