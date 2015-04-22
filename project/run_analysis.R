library(utils)
library(data.table)
library(reshape)   # use melt

#
# Data store will return a list of functions for data access. 
# 1. get_test_data  - This 
# 2. get_train_data
# 3. get_merged_data

datastore <-function() {
    
    featurenames <- NULL
    activity_labels <- NULL
    train_data <- NULL
    test_data <- NULL
    merged_data <- NULL
    
    
    download_files <- function() {
        print("download")        
        if (!file.exists("./dataset.zip")) {
            download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      dest="dataset.zip", method="curl")
        }
        unzip("./dataset.zip")   
        file.rename("./UCI\ HAR\ Dataset", "./data")
    }
    
    getdataset <- function(subfile, actfile, datafile) {
        data.table(read.table(subfile),read.table(actfile),read.table(datafile) )
        
        subject_test <<- fread("./data/test/subject_test.txt")
        activity_test <<- fread("./data/test/y_test.txt")
        data_test <<- fread("./data/test/X_test.txt")
    }
    
    get_train_data <- function() {
        if(is.null(train_data)) {
            data <- getdataset("./data/train/subject_train.txt", 
                                         "./data/train/y_train.txt",
                                         "./data/train/X_train.txt")  
            setnames(data, c("subjectid", "activityid", featurenames$V2))
            train_data <<- data
        }
        train_data
    }
    
    get_test_data <- function() {
        if(is.null(test_data)) {
            data <- getdataset("./data/test/subject_test.txt", 
                               "./data/test/y_test.txt",
                               "./data/test/X_test.txt")  
            setnames(data, c("subjectid", "activityid", featurenames$V2))
            test_data <<- data
        }
        test_data
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
            # Apply the activity lables
            data <- merge( data , activity_labels, by="activityid", sort = FALSE)
            # Subset the data (subjectid, activityid, ...mean and sd data..., activityname)
            columnsRequired <- c( TRUE, TRUE, grepl("(mean\\(\\)|std)", featurenames$V2), TRUE)
            merged_data <<- data[,columnsRequired] 
            data <- NULL
        }
        merged_data
    }
    clear_test_train_data <- function() {
        train_data <- NULL
        test_data <- NULL
    }
    
    if(!file.exists("./data")) {
        download_files()
    }
    featurenames <- fread("./data/features.txt")
    activity_labels <- fread("./data/activity_labels.txt")
    setnames(activity_labels, c("activityid", "activityname"))
    list( get_test_data=get_test_data, 
          get_train_data=get_train_data, 
          get_merged_data=get_merged_data, 
          clear_test_train_data=clear_test_train_data)
}
