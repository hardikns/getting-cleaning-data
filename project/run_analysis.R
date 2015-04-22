library(data.table)
library(reshape2)   # use melt
library(dplyr)

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

# 
# Data store will return a list of functions for data access. 
# 1. get_test_data   - This will only fetch the test data and cache it. 
# 2. get_train_data  - This will only fetch the training data anc cache it.
# 3. get_merged_data - This will merge the data (test and train), 
#                      remove unnecessary columns, 
#                      add activity names
#                      smooth the measurement names (feature names)
#                      return a wide dataset. 
# 4. clear_test_train_data
#                    - This clears memory for test and train data
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
        print("download")        
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

    clean_column_names <- function(data) {
        textToReplace <- c("^f", "^t", "\\(\\)", "Acc", "Gyro", 
                           "Mag", "BodyBody", "X$", "Y$", "Z$", 
                           "\\bstd\\b")
        replacementText <- c("frequency", "time", "", "Accelerometer", "Gyroscope", 
                             "Magnitude", "Body", "Xaxis", "Yaxis", "Zaxix", 
                             "StandardDeviation")     
        setnames(data, mgsub(textToReplace, replacementText, x=names(data)))
        data
    }
    
    get_merged_data <- function() {
        if(is.null(merged_data)) {
            if(is.null(test_data)) {
                get_test_data()
            }
            if(is.null(train_data)) {
                get_train_data()
            }
            data <- rbind(train_data, test_data)
                        
            # Subset the data (subject, activity, ...mean and sd data...)
            columnsRequired <- c( TRUE, TRUE, grepl("(mean\\(\\)|std)", featurenames$V2))
            data <- data[,columnsRequired, with=FALSE]
                        
            # Apply the activity lables
            data$activity <- factor(data$activity, 
                                             activity_labels$V1, activity_labels$V2)
            
            # Clean the column names
            merged_data <<- clean_column_names(data)
            
            # Cleanup
            data <- NULL
        }
        merged_data
    }
    
    clear_test_train_data <- function() {
        train_data <- NULL
        test_data <- NULL
    }
    
    clear_merged_data <- function() {
        merged_data <- NULL
    }
    
    get_tall_merged_dataset <- function() {
        melt(get_merged_data(), c("subject", "activity"))
    }
    
    get_mean_of_each_variable_tall <- function() {
        get_tall_merged_dataset() %>%
            group_by(activity , subject, variable) %>% 
                summarize(meanvalue = mean(value))
    }
    
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

data <- datastore()
write.table(data$get_mean_of_each_variable_wide(), 
            file = "./data/tidy_dataset_mean_wide.txt", row.name=FALSE)
write.table(data$get_mean_of_each_variable_tall(), 
            file = "./data/tidy_dataset_mean_tall.txt", row.name=FALSE)
