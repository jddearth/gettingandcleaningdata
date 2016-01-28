Project Getting and Cleaning Data Code Book
===========================================

Data Description URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R does the following:

1. Merges the training and the test sets to create one data set. Data Frames Created: x_data[10299 obs. x 561 variables], y_data[10299 obs. x 1 variable], subject_data[10299 obs. x 1 variable]
2. Extracts only the measurements on the mean and standard deviation for each measurement. Data Frame Created: mean_std_data[10299 obs. x 66 variables]
3. Uses descriptive activity names to name the activities in the data frame y_data. Data Frame: y_data[10299 obs. x 1 variable]
4. Appropriately labels the data set with descriptive activity names. Data Frame Created: merged_data_sets[10299 obs. x 68 variables]
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. Data Frame Created: merged_data[180 obs. x 68 varibales]
6. Writes merged_data to AverageHumanActivityRecognitionUsingSmartphones.txt file to Working Directory.

