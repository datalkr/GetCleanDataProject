CodeBook for the tidy dataset
=============================

Data source
-----------
This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

About the raw data set:
-----------------------

The features (561 of them) are unlabeled and can be found in the x_test.txt. 
The activity labels are in the y_test.txt file.
The test subjects are in the subject_test.txt file.

The same holds for the training set.

The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Attribute information:
----------------------
For each record in the dataset the following are provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 

run_analysis.R code
-------------------

The purpose of the run_analysis.R script is to process the raw data sets and create a tidy data set. The script assumes the raw data has been downloaded and is in  ./data directory within the working directory.

The script does the following:
 
 1. Read in the training data, X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in xTrain, yTrain, and subjectTrain variables respectively.       
 2. Read in the test data, X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in xTest, yTest, and subjectTest variables respectively. 
 3. Read in the  and activity labels from features.txt and activity_labels.txt in the ".data/" directory and store them in features and activity variables, respectively. 
 4. Merge the training and test data to create one data set. Join xTrain with xTest to give joinData. Concatenate yTrain with yTest to get *joinLabel*; concatenate *testLabel* to *trainLabel* to generate *joinLabel*; concatenate *testSubject* to *trainSubject* to generate  *joinSubject*.  
 4. Extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of *joinData* with the 66 corresponding columns.  
 5. Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively. Replace "f" with FreqDomain and "t" with TimeDomain and.  
 6. Clean the activity names in the second column of *activity*. Make the names lower case and remove underscores.  
 7. Transform the values of *joinLabel* according to the *activity* data frame.  
 8. Combine the *joinSubject*, *joinLabel* and *joinData* by column to get a new cleaned data frame, *cleanedData*.   
 9. Write the *cleanedData* out to "clean_data.txt" file in current working directory.  
 10. Finally, generate an independent tidy data set with the average of each measurement for each activity and each subject. There are 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. For each combination, calculate the mean of each measurement with the corresponding combination. So, after initializing the *result* data frame and performing the two for-loops, we get a 180x68 data frame.
 11. Write the results out to "tidy_data.txt" file in current working directory. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. "t" denotes Time Domainand "f" denotes Frequen

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated (and kept for this assignment) from these signals are: 

* mean(): Mean value
* std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

References
----------

1.  <a name="uci-har"/>Human Activity Recognition Using Smartphones Data Set.
    URL: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. Accessed 03/20/2015
2.  <a name="har-smart"/>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine*.
   International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

© Lisa Robinson 2015 All Rights reserved.