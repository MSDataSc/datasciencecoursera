# README.md for Tidy Data Set
## Detailed Instructions on how to run the script

Objective is to create two files:

1. Tidy data set of activity tracker measures (only mean and standard deviation measures) for each
participant and activity being tracked.

2. A summarized version of #1 above with average values for each measure grouped by participant and
activity.

#Instructions:
* Make sure the Samsung data resides in a direcotry called "UCIHARDataset".
* Log on R and start in the parent directory where UCIHARDataset is located. 
* UCIHARDataset directory should have the following files: "activity_labels.txt" and "features.txt"
* It should also have direcotries called "test" and "train" which have the X*, Y* and Subject* files
* Run the "run_analysis.R" script by typing -> source("run_analysis.R")
* Output will be TidyDataSetSummary.txt and TidyDataSet.txt files

# Detailed explanation of the script below
Steps to follow to process the raw data set and get to tidy data sets

* Initialize Section:
1. Step #1 First of all load all the dependent packages
2. Step #2 Set parent directory where data files reside as the working directory

* Section 1: Read the parameter files first
3. Step #3 Read activity_tabels.txt file into actLabels. This will be used later for making the data more descriptive
4. Step #4 Read the features.txt file into feats. This will be used to make the column names descriptive

* Section 2: Read the test data set (raw data)
5. Step #5 Set working directory to “test” folder where test data set resides 
6. Step #6 Read participant ids via file subject_test.txt into Stest
7. Step #7 Rename the column to be descriptive
8. Step #8 Read the activity ids from Y_test into a temp data table
9. Step #9 Add the descriptive data by merging with the activity labels loaded from activity_labels.txt in section 1
10. Step #10 Rename the columns to be descriptive
11. Step #11 Read the test measures from file X_test.txt into Xtest
12. Step #12 Rename the columns in the data set to the descriptive column names read from features.txt in section 1 
13. Step #13 Limit the data set to only columns related to mean and std measures
14. Step #14 Merge the subject ids, acticity id,label and the test data set via cbind
15. Step #15 Add the "Test." prefix to columns names to differentiate test data from train data

* Section 3: Read the train data set (raw data)
16. Step #16: Set working directory to the “train” folder where train data set resides Step #16: Read participant ids via file subject_train.txt file into Strain
17. Step #17 Rename the column to be descriptive
18. Step #18 Read the activity ids from train into a temp data table
19. Step #19 Add the descriptive data by merging with the activity labels loaded from activity_labels.txt in section 1
20. Step #20 Rename the columns to be descriptive
21. Step #21 Read the training measures from file X_train.txt into Xtrain
22. Step #22 Rename the columns in the data set to the descriptive column names read from features.txt in
section 1
23. Step #23 Limit the data set to only columns related to mean and std measures
24. Step #24 Merge the subject ids, activity id,label and the train data set via cbind
25. Step #25 Add the "Train." prefix to columns names to differentiate test data from train data

* Section 4 - Merge the test and train data sets
26. Step #26 Revert the current working directory to the starting point.
27. Step #27 Merge the train data set and the test data set to form the tidy data set 
28. Step #28 Write the tidy data set into a text file “TidyDataSet.txt"

* Section 5 - Create a summarized data set use the previous tidy data set to show average for all measures by participant and activity.
29. Step #29 Get the average of all cols by subject id, activity id and activity label
30. Step #30 Make the column names descriptive to reflect this data set is average of all columns 
31. Step #31 Write the summarized tidy data set into a file TidyDataSetSummary.txt
