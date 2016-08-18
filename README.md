#   Getting-and-cleaning-data: Final Course Project
##  This repo explains how all of the scripts in my R code work and how they are connected.

##  My R code does the following in chronological order:

1.  Reads the activity labels and features labels text files from the UCI HAR data set.

2.  Reads the subject_train, x_train and y_train text files from the training data set.

3.  Assigns descriptive names to the activity labels.

4.  Creates a single training data set.

5.  Reads the subject_test, x_test and y_test text files from the test data set.

6.  Assigns descriptive names to the activity labels.

7.  Creates a single test data set.

8.  Merges the training and the test data sets to create one data set.

9.  Assigns descriptive names to the columns of the merged data set.

10. Isolates the columns that correspond to the mean and standard deviation variables.

11. Create a new tidy data set with the average of each variable for each activity and each subject.

12. Writes the data set in a separate text file.

