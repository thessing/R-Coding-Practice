# You should create one R script called run_analysis.R that does the following.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.
#
#
#
# ddDirs   <- list.dirs(dataDir, full.names = FALSE, recursive = FALSE)
# ddFiles  <- list.files(dataDir)[!(list.files(dataDir) %in% ddDirs)]
library("dplyr", lib.loc="~/R/win-library/3.4")
#
# Set Top-Level Directory
#
dataDir  <- "C:/Users/hessit1/Desktop/Data Science/R Code/getdata_projectfiles_UCI HAR Dataset"
#
# Read Activity Labels
#
fileName <- paste(dataDir, "/activity_labels.txt", sep="")
activityLabels <- read.table(fileName, col.names = c("Label", "Activity"))
#
# Read Features
#
fileName <- paste(dataDir, "/features.txt", sep="")
features <- read.table(fileName, col.names = c("FeatID", "Feature"))

#
# Set  Test & Train Data Directories & Files
#
X_test   <- paste(dataDir, "/test/X_test.txt",     sep="")
y_test   <- paste(dataDir, "/test/y_test.txt",     sep="")
X_train  <- paste(dataDir, "/train/X_train.txt",   sep="")
y_train  <- paste(dataDir, "/train/y_train.txt",   sep="")
mergeDir <- paste(dataDir, "/merged",              sep="")
X_merged <- paste(dataDir, "/merged/X_merged.txt", sep="")
y_merged <- paste(dataDir, "/merged/y_merged.txt", sep="")

#
# Create Merged Directory
#
dir.create(mergeDir)

tt<-read.table(fileName, col.names = features$Feature) %>%
  names()[grep("mean|std", names() )]

full_join(tt2, activityLabels, by = c("Activity" = "Label"))
match(tt2$Activity, activityLabels$Label)



