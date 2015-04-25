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

Field Name    |	Unit
-----------------------------------------------------------------------------------	|	----------------------------------
timeBodyAcceleration-mean-Xaxis	|	'g'
timeBodyAcceleration-mean-Yaxis	|	'g'
timeBodyAcceleration-mean-Zaxix	|	'g'
timeBodyAcceleration-StandardDeviation-Xaxis	|	'g'
timeBodyAcceleration-StandardDeviation-Yaxis	|	'g'
timeBodyAcceleration-StandardDeviation-Zaxix	|	'g'
timeGravityAcceleration-mean-Xaxis	|	'g'
timeGravityAcceleration-mean-Yaxis	|	'g'
timeGravityAcceleration-mean-Zaxix	|	'g'
timeGravityAcceleration-StandardDeviation-Xaxis	|	'g'
timeGravityAcceleration-StandardDeviation-Yaxis	|	'g'
timeGravityAcceleration-StandardDeviation-Zaxix	|	'g'
timeBodyAccelerationJerk-mean-Xaxis	|	'g'
timeBodyAccelerationJerk-mean-Yaxis	|	'g'
timeBodyAccelerationJerk-mean-Zaxix	|	'g'
timeBodyAccelerationJerk-StandardDeviation-Xaxis	|	'g'
timeBodyAccelerationJerk-StandardDeviation-Yaxis	|	'g'
timeBodyAccelerationJerk-StandardDeviation-Zaxix	|	'g'
timeBodyGyroscopic-mean-Xaxis	|	radians/second
timeBodyGyroscopic-mean-Yaxis	|	radians/second
timeBodyGyroscopic-mean-Zaxix	|	radians/second
timeBodyGyroscopic-StandardDeviation-Xaxis	|	radians/second
timeBodyGyroscopic-StandardDeviation-Yaxis	|	radians/second
timeBodyGyroscopic-StandardDeviation-Zaxix	|	radians/second
timeBodyGyroscopicJerk-mean-Xaxis	|	radians/second
timeBodyGyroscopicJerk-mean-Yaxis	|	radians/second
timeBodyGyroscopicJerk-mean-Zaxix	|	radians/second
timeBodyGyroscopicJerk-StandardDeviation-Xaxis	|	radians/second
timeBodyGyroscopicJerk-StandardDeviation-Yaxis	|	radians/second
timeBodyGyroscopicJerk-StandardDeviation-Zaxix	|	radians/second
timeBodyAccelerationMagnitude-mean	|	'g'
timeBodyAccelerationMagnitude-StandardDeviation	|	'g'
timeGravityAccelerationMagnitude-mean	|	'g'
timeGravityAccelerationMagnitude-StandardDeviation	|	'g'
timeBodyAccelerationJerkMagnitude-mean	|	'g'
timeBodyAccelerationJerkMagnitude-StandardDeviation	|	'g'
timeBodyGyroscopicMagnitude-mean	|	radians/second
timeBodyGyroscopicMagnitude-StandardDeviation	|	radians/second
timeBodyGyroscopicJerkMagnitude-mean	|	radians/second
timeBodyGyroscopicJerkMagnitude-StandardDeviation	|	radians/second
frequencyBodyAcceleration-mean-Xaxis	|	hz
frequencyBodyAcceleration-mean-Yaxis	|	hz
frequencyBodyAcceleration-mean-Zaxix	|	hz
frequencyBodyAcceleration-StandardDeviation-Xaxis	|	hz
frequencyBodyAcceleration-StandardDeviation-Yaxis	|	hz
frequencyBodyAcceleration-StandardDeviation-Zaxix	|	hz
frequencyBodyAccelerationJerk-mean-Xaxis	|	hz
frequencyBodyAccelerationJerk-mean-Yaxis	|	hz
frequencyBodyAccelerationJerk-mean-Zaxix	|	hz
frequencyBodyAccelerationJerk-StandardDeviation-Xaxis	|	hz
frequencyBodyAccelerationJerk-StandardDeviation-Yaxis	|	hz
frequencyBodyAccelerationJerk-StandardDeviation-Zaxix	|	hz
frequencyBodyGyroscopic-mean-Xaxis	|	hz
frequencyBodyGyroscopic-mean-Yaxis	|	hz
frequencyBodyGyroscopic-mean-Zaxix	|	hz
frequencyBodyGyroscopic-StandardDeviation-Xaxis	|	hz
frequencyBodyGyroscopic-StandardDeviation-Yaxis	|	hz
frequencyBodyGyroscopic-StandardDeviation-Zaxix	|	hz
frequencyBodyAccelerationMagnitude-mean	|	hz
frequencyBodyAccelerationMagnitude-StandardDeviation	|	hz
frequencyBodyAccelerationJerkMagnitude-mean	|	hz
frequencyBodyAccelerationJerkMagnitude-StandardDeviation	|	hz
frequencyBodyGyroscopicMagnitude-mean	|	hz
frequencyBodyGyroscopicMagnitude-StandardDeviation	|	hz
frequencyBodyGyroscopicJerkMagnitude-mean	|	hz
frequencyBodyGyroscopicJerkMagnitude-StandardDeviation	|	hz
