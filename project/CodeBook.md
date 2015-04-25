Human Activity Recognition Using Smartphones 
============================================

The purpose of this analysis is to create a tidy dataset from the raw data obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Details of the same can be found in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

There were a 561 of measures in the raw dataset. The dataset was split into Train and Test dataset and further the measures, activity and subject information were also in separate files. The run_analysis.R script does the following:

1. Merges the 3 separate files into 1 dataset for Test and Train. Also, applies column names
2. Merges the Test and Train dataset to create a merged dataset.
3. Removes the unwanted measures (for this analysis only mean and standard-deviation measures have been selected).
4. Converts the dataset into Tall dataset (i.e. each measure per observation is on separate row)
5. Takes mean of all the measures for a subject and activity combination to create a tidy tall dataset
6. Converts the tall dataset into wide tidy dataset (i.e. mean of all measures are separate columns)

This dataset contains following variables:

**activity** - This indicates the activity performed by the human subject. The values are

          "WALKING"            - Subject is walking
          "WALKING_UPSTAIRS"   - Subject is walking up the stairs
          "WALKING_DOWNSTAIRS" - Subject is walking down the stairs
          "SITTING"            - Subject is sitting
          "STANDING"           - Subject is standing
          "LAYING"             - Subject is laying down

**subject** - This is a identifier of the human subject who performed the above activity. The values are `1-30`

And mean of following measures for a combination of activity and subject:

* timeBodyAcceleration-mean-Xaxis
* timeBodyAcceleration-mean-Yaxis
* timeBodyAcceleration-mean-Zaxix
* timeBodyAcceleration-StandardDeviation-Xaxis
* timeBodyAcceleration-StandardDeviation-Yaxis
* timeBodyAcceleration-StandardDeviation-Zaxix
* timeGravityAcceleration-mean-Xaxis
* timeGravityAcceleration-mean-Yaxis
* timeGravityAcceleration-mean-Zaxix
* timeGravityAcceleration-StandardDeviation-Xaxis
* timeGravityAcceleration-StandardDeviation-Yaxis
* timeGravityAcceleration-StandardDeviation-Zaxix
* timeBodyAccelerationJerk-mean-Xaxis
* timeBodyAccelerationJerk-mean-Yaxis
* timeBodyAccelerationJerk-mean-Zaxix
* timeBodyAccelerationJerk-StandardDeviation-Xaxis
* timeBodyAccelerationJerk-StandardDeviation-Yaxis
* timeBodyAccelerationJerk-StandardDeviation-Zaxix
* timeBodyGyroscopic-mean-Xaxis
* timeBodyGyroscopic-mean-Yaxis
* timeBodyGyroscopic-mean-Zaxix
* timeBodyGyroscopic-StandardDeviation-Xaxis
* timeBodyGyroscopic-StandardDeviation-Yaxis
* timeBodyGyroscopic-StandardDeviation-Zaxix
* timeBodyGyroscopicJerk-mean-Xaxis
* timeBodyGyroscopicJerk-mean-Yaxis
* timeBodyGyroscopicJerk-mean-Zaxix
* timeBodyGyroscopicJerk-StandardDeviation-Xaxis
* timeBodyGyroscopicJerk-StandardDeviation-Yaxis
* timeBodyGyroscopicJerk-StandardDeviation-Zaxix
* timeBodyAccelerationMagnitude-mean
* timeBodyAccelerationMagnitude-StandardDeviation
* timeGravityAccelerationMagnitude-mean
* timeGravityAccelerationMagnitude-StandardDeviation
* timeBodyAccelerationJerkMagnitude-mean
* timeBodyAccelerationJerkMagnitude-StandardDeviation
* timeBodyGyroscopicMagnitude-mean
* timeBodyGyroscopicMagnitude-StandardDeviation
* timeBodyGyroscopicJerkMagnitude-mean
* timeBodyGyroscopicJerkMagnitude-StandardDeviation
* frequencyBodyAcceleration-mean-Xaxis
* frequencyBodyAcceleration-mean-Yaxis
* frequencyBodyAcceleration-mean-Zaxix
* frequencyBodyAcceleration-StandardDeviation-Xaxis
* frequencyBodyAcceleration-StandardDeviation-Yaxis
* frequencyBodyAcceleration-StandardDeviation-Zaxix
* frequencyBodyAccelerationJerk-mean-Xaxis
* frequencyBodyAccelerationJerk-mean-Yaxis
* frequencyBodyAccelerationJerk-mean-Zaxix
* frequencyBodyAccelerationJerk-StandardDeviation-Xaxis
* frequencyBodyAccelerationJerk-StandardDeviation-Yaxis
* frequencyBodyAccelerationJerk-StandardDeviation-Zaxix
* frequencyBodyGyroscopic-mean-Xaxis
* frequencyBodyGyroscopic-mean-Yaxis
* frequencyBodyGyroscopic-mean-Zaxix
* frequencyBodyGyroscopic-StandardDeviation-Xaxis
* frequencyBodyGyroscopic-StandardDeviation-Yaxis
* frequencyBodyGyroscopic-StandardDeviation-Zaxix
* frequencyBodyAccelerationMagnitude-mean
* frequencyBodyAccelerationMagnitude-StandardDeviation
* frequencyBodyAccelerationJerkMagnitude-mean
* frequencyBodyAccelerationJerkMagnitude-StandardDeviation
* frequencyBodyGyroscopicMagnitude-mean
* frequencyBodyGyroscopicMagnitude-StandardDeviation
* frequencyBodyGyroscopicJerkMagnitude-mean
* frequencyBodyGyroscopicJerkMagnitude-StandardDeviation