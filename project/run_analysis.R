# Running source("./run_analysis.R") will run the entire script and places
# the tidy_dataset_mean_wide.txt and tidy_dataset_mean_tall.txt in ./data folder. 
# There is no need to download the zip files it will do it. If you have the data already 
# downloaded place the same as dataset.zip in the working directory. 

library(data.table)
library(reshape2)   # use melt
library(dplyr)

# 
# Data store will return a list of functions for data access. 
# 1. get_test_data         - This will only fetch the test data and cache it. 
# 2. get_train_data        - This will only fetch the training data anc cache it.
# 3. get_merged_data       - This will merge the data (test and train), 
#                            remove unnecessary columns, 
#                            add activity names
#                            smooth the measurement names (feature names)
#                            return a wide dataset. 
# 4. clear_test_train_data - This clears memory for test and train data
#                          
# 5. clear_merged_data     - This clears memory for merged_data set
# 6. get_tall_merged_dataset 
#                          - This provides a tall merged dataset 
#                            i.e. each measure on separate row
# 7. get_mean_of_each_variable_tall
#                          - This retuns a tall dataset with mean of 
#                            each measure on for a combination of subject and activity
# 8. get_mean_of_each_variable_wide
#                          - Provides the same data as in 7 in a wide format
#                            i.e. a combination of subject and activity will have one row with
#                            mean of variables on separate column
#
# Usage: 
#   data <- datastore()  # this will download the data in the workdirectory data folder
#   merged_data <- data$get_merged_data() 
#

datastore <-function() {
    
    featurenames <- NULL
    activity_labels <- NULL
    train_data <- NULL
    test_data <- NULL
    merged_data <- NULL
    
    # This function fetches the dataset zip file, extracts it in the wd and renames the root folder 
    # as data. 
    download_files <- function() {
        if (!file.exists("./dataset.zip")) {
            download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      dest="dataset.zip", method="curl")
        }
        unzip("./dataset.zip")   
        file.rename("./UCI\ HAR\ Dataset", "./data")
    }
    
    # This function reads the 3 files (subject, activity and datafile) passed and 
    # converts them into data.table (data.table's are faster than data.frame's)
    # read.table was used as fread fails for datafile read. 
    getdataset <- function(subfile, actfile, datafile) {
        data <- data.table(read.table(subfile),read.table(actfile),read.table(datafile) )
        setnames(data, c("subject", "activity", featurenames$V2))
        data
    }
    
    # fetches the train data files in to datatable and then adds column names. 
    # if train data is already in cache then returns that. 
    get_train_data <- function() {
        if(is.null(train_data)) {
            train_data <<- getdataset("./data/train/subject_train.txt", 
                                         "./data/train/y_train.txt",
                                         "./data/train/X_train.txt")  
        }
        train_data
    }

    # fetches the test data files in to datatable and then adds column names. 
    # if test data is already in cache then returns that.     
    get_test_data <- function() {
        if(is.null(test_data)) {
            test_data <<- getdataset("./data/test/subject_test.txt", 
                               "./data/test/y_test.txt",
                               "./data/test/X_test.txt")  
        }
        test_data
    }    
    
    # Applies mgsub to function (defined below) to replace column name accronyms with readable names 
    clean_column_names <- function(data) {
        textToReplace <- c("^f", "^t", "\\(\\)", "Acc", "Gyro", 
                           "Mag", "BodyBody", "X$", "Y$", "Z$", 
                           "\\bstd\\b")
        replacementText <- c("frequency", "time", "", "Acceleration", "Gyroscopic", 
                             "Magnitude", "Body", "Xaxis", "Yaxis", "Zaxix", 
                             "StandardDeviation")     
        setnames(data, mgsub(textToReplace, replacementText, x=names(data)))
        data
    }
    
    # fetches the test data files in to datatable and then adds column names. 
    # if test data is already in cache then returns that.     
    get_merged_data <- function() {
        if(is.null(merged_data)) {
            # Combine the train and test dataset
            data <- rbind(get_train_data(), get_test_data())
                        
            # Keep only necessary columns (subject, activity, ...mean and sd data...)
            columnsRequired <- c( TRUE, TRUE, grepl("(mean\\(\\)|std)", featurenames$V2))
            data <- data[,columnsRequired, with=FALSE]
                        
            # Apply the activity lables as Factors
            data$activity <- factor(data$activity, 
                                             activity_labels$V1, activity_labels$V2)
            
            # Clean the column names
            merged_data <<- clean_column_names(data)
            
            # Cleanup
            data <- NULL
        }
        merged_data
    }
    
    # Clear cached data for test and train dataset
    clear_test_train_data <- function() {
        train_data <<- NULL
        test_data <<- NULL
    }
    
    # Clear cached data for merged dataset
    clear_merged_data <- function() {
        merged_data <<- NULL
    }
    
    # This provides a tall merged dataset i.e. each measure on separate row
    get_tall_merged_dataset <- function() {
        melt(get_merged_data(), c("subject", "activity"))
    }
    
    # This retuns a tall dataset with mean of 
    # each measure on for a combination of subject and activity
    get_mean_of_each_variable_tall <- function() {
        get_tall_merged_dataset() %>%
            group_by(activity , subject, variable) %>% 
                summarize(meanvalue = mean(value))
    }
    
    # Provides the same data as in get_mean_of_each_variable_tall in a wide format
    #  i.e. a combination of subject and activity will have one row with
    #       mean of variables on separate column
    get_mean_of_each_variable_wide <- function() {
        dcast(get_mean_of_each_variable_tall(), activity+subject~variable, value.var = "meanvalue")
    }
    
    if(!file.exists("./data")) {
        download_files()
    }
    featurenames <- fread("./data/features.txt")
    activity_labels <- fread("./data/activity_labels.txt")

    list( get_test_data=get_test_data, 
          get_train_data=get_train_data, 
          get_merged_data=get_merged_data, 
          clear_test_train_data=clear_test_train_data,
          clear_merged_data=clear_merged_data,
          get_tall_merged_dataset=get_tall_merged_dataset, 
          get_mean_of_each_variable_tall=get_mean_of_each_variable_tall,
          get_mean_of_each_variable_wide=get_mean_of_each_variable_wide)
}

#
# Performs gsub with multiple patterns and replacement texts
# pattern - character vector where each element is pattern arg in gsub
# replacement - character vector where each element is used as replacementtext arg in gsub 
# x - character vector where this replacement has to be applied
#
mgsub <- function(pattern, replacement, x, ...) {
    if (length(pattern) != length(replacement)) {
        stop("pattern not of same length as replacement")
    }
    for (i in seq_along(pattern)) {
        x = gsub(pattern[i], replacement[i], x, ... )
    }
    x
}


data <- datastore()
write.table(data$get_mean_of_each_variable_wide(), 
            file = "./data/tidy_dataset_mean_wide.txt", row.name=FALSE)
write.table(data$get_mean_of_each_variable_tall(), 
            file = "./data/tidy_dataset_mean_tall.txt", row.name=FALSE)
