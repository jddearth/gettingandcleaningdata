# Download the data

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
if (!file.exists("data")) {
        dir.create("data")
}
download.file(url, "./data/UCI_HAR_Dataset.zip")
datedownloaded <- date()
unzip( "./data/UCI_HAR_Dataset.zip", exdir = "./data")

# 1. Merges the training and the test sets to create one data set.

x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
x_data <- rbind(x_train, x_test)

y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
y_data <- rbind(y_train, y_test)

subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
subject_data <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("data/UCI HAR Dataset/features.txt")
good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x_data <- x_data[, good_features]
names(x_data) <- features[good_features, 2]
names(x_data) <- gsub("\\(|\\)", "", names(x_data))
names(x_data) <- tolower(names(x_data))

# 3. Uses descriptive activity names to name the activities in the data set.

activity_label <- read.table("data/UCI HAR Dataset/activity_labels.txt")
activity_label[, 2] <- gsub("_", "", tolower(as.character(activity_label[, 2])))
y_data[,1] <- activity_label[y_data[,1], 2]
names(y_data) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(subject_data) <- "subject"
merged_data_sets <- cbind(subject_data, y_data, x_data)
write.table(merged_data_sets, "merged_data_sets.txt")

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

unique_subjects <- unique(subject_data)[,1]
count_subjects <- length(unique(subject_data)[,1])
count_activity_label <- length(activity_label[,1])
count_columns <- dim(merged_data_sets)[2]
merged_data <- merged_data_sets[1:(count_subjects*count_activity_label), ]

count <- 1
for (s in 1:count_subjects) {
        for (a in 1:count_activity_label) {
                merged_data[count, 1] <- unique_subjects[s]
                merged_data[count, 2] <- activity_label[a, 2]
                updated_data_sets <- merged_data_sets[merged_data_sets$subject==subject_data & merged_data_sets$activity==activity_label[a, 2], ]
                merged_data[row, 3:count_columns] <- colMeans(updated_data_sets[, 3:count_columns])
                count <- count+1
        }
}
write.table(merged_data, "AverageHumanActivityRecognitionUsingSmartphones.txt")
