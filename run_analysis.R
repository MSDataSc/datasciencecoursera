# First of all load all the dependent packages
library(data.table)
library(plyr)

# Set parent direcotry where data file sreside as the working directory
  setwd("UCIHARDataset")
  
  
# Section 1: Read the parameter files 

  # Read activity_tabels.txt file into actLabels. 
  # This will be used later for making the data more descriptive
  actLabel <- fread("activity_labels.txt")
      
  # Read the features.txt file into feats
  # This will be used to make the column names descriptive
  feats <- fread("features.txt")

#Section 2: Read the test data set
  setwd("test")

  #fread subject_text into Stest
  Stest <- fread("subject_test.txt")
               
  # Rename the column to be descriptive
  Stest <- rename(Stest,c("V1" = "SubjectID"))

  #fread Y_test into a temp data table
  YtestTmp <- fread("Y_test.txt")
  # Add the descriptive data by merging with the activity labels loaded in section 1
  Ytest <- merge(actLabel,YtestTmp,by="V1")
  
  # Rename the columns to be descriptive
  Ytest <- rename(Ytest,c("V1" = "ActivityID", "V2" = "ActivityLabel"))

  #read X_test into Xtest
  Xtest <- fread("X_test.txt")
               
  #Rename the columns in the data set to the descriptive column names read from features.txt in section 1
  names(Xtest) <- feats$V2
               
  #Limit the data set to only columns related to mean and std into XtestTrim
  XtestTrim <- Xtest[,grep(c("mean|std"),names(Xtest)),with=FALSE]
               
  #Merge the subject ids, acticity id,label and the test data set via cbind
  testDT <- cbind(Stest, Ytest, XtestTrim)
               
  # Add the "Test." prefix to columns names to differentiate test data from train data
  testCols <- names(testDT)
  testCols <- sub("^t","Test.t",testCols)
  testCols <- sub("^f","Test.f",testCols)
  names(testDT) <- testCols
               
               #———————————————
  #Section 3: Read the train data set
  
  setwd("../train")
               
  #fread subject_train into Strain
  Strain <- fread("subject_train.txt")
               
  #Name Col “subjID” = V1
  Strain <- rename(Strain,c("V1" = "SubjectID"))
               
  #fread Y_train into Ytrain
  YtrainTmp <- fread("Y_train.txt")
               
  Ytrain <- merge(actLabel,YtrainTmp,by="V1")
  Ytrain <- rename(Ytrain,c("V1" = "ActivityID", "V2" = "ActivityLabel"))
               
  #read X_test into Xtest
  Xtrain <- fread("X_train.txt")
  names(Xtrain) <- feats$V2
               
  #extract mean and std columns into XtestTrim
  XtrainTrim <- Xtrain[,grep(c("mean|std"),names(Xtrain)),with=FALSE]
               
  #rename columns in XTestTrim
  trainDT <- cbind(Strain, Ytrain, XtrainTrim)
               
  # Descriptive Names with for Test Columns 
  trainCols <- names(trainDT)
  trainCols <- sub("^t","Train.t",trainCols)
  trainCols <- sub("^f","Train.f",trainCols)
  names(trainDT) <- trainCols

  #Section 4 - now merge the data frames
  #first set wd to starting point
  setwd("../..")
  
  #Merge the train data set and the test data set to form the tidy data set               
  tidyDT <- merge(trainDT,testDT,all=TRUE, by = c("SubjectID","ActivityID","ActivityLabel"))
  
  #Write the tidy data set into a file
  write.csv(tidyDT,"TidyDataSet.csv")
  
  #Get the average of all cols by subject id, activity id and activity label
  aggTidyDT <- tidyDT[,lapply(.SD,mean,na.rm=TRUE),by=c("SubjectID","ActivityID","ActivityLabel")]
  
  #Make the column names descriptive to reflect this data set is average of all columns
  cols <- colnames(aggTidyDT)
  names(aggTidyDT) <- sub("^T","Average.T",cols)
  
  #Write the summarized tidy data set into a file
  write.csv(aggTidyDT,"TidyDataSetSummary.csv")