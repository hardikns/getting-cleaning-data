Human Activity Recognition Using Smartphones 
============================================

The raw dataset was collected from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Details of the same can be found in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### What is the content in the Raw dataset?
There are 561 of measures in the raw dataset. The dataset is split into Train and Test dataset. Further the measures, 
activity and subject information are also in separate files. It also contains the raw signals in "Inertial Signals" folder 
inside the Test and Train dataset folders.

### What does the script do?
The run_analysis.R script does the following:

1. Merges the 3 separate files into 1 dataset for Test and Train. Also, applies column names
2. Merges the Test and Train dataset to create a merged dataset.
3. Removes the unwanted measures (for this analysis only mean and standard-deviation measures have been selected).
4. Converts the dataset into Tall dataset (i.e. each measure per observation is on separate row)
5. Takes mean of all the measures for a subject and activity combination to create a tidy tall dataset
6. Converts the tall dataset into wide tidy dataset (i.e. mean of all measures are separate columns)

### How to run the script?
Running `source("./run_analysis.R")` will run the entire script and places 
the `tidy_dataset_mean_wide.txt` and `tidy_dataset_mean_tall.txt` in `./data` folder. 
There is no need to download the zip files it will do it. If you have the data already 
downloaded place the same as dataset.zip in the working directory. 

### How to read the data back into R?

`tidy2 <- read.table("./data/tidy_dataset_mean_wide.txt", stringsAsFactors = TRUE, header = TRUE)`

### What else can you do with the script?

The script creates a variable call `data` in your global environment. Which has a list of functions. These functions can be used
for further fetch the data in different formats:

1. get_test_data         - This will only fetch the test data and cache it. 
2. get_train_data        - This will only fetch the training data anc cache it.
3. get_merged_data       - This will merge the data (test and train), 
                            remove unnecessary columns, 
                            add activity names
                            smooth the measurement names (feature names)
                            return a wide dataset. 
4. clear_test_train_data - This clears memory for test and train data
5. clear_merged_data     - This clears memory for merged_data set
6. get_tall_merged_dataset 
                          - This provides a tall merged dataset 
                            i.e. each measure on separate row
7. get_mean_of_each_variable_tall
                          - This retuns a tall dataset with mean of 
                            each measure on for a combination of subject and activity
8. get_mean_of_each_variable_wide
                          - Provides the same data as in 7 in a wide format
                            i.e. a combination of subject and activity will have one row with
                            mean of variables on separate column
