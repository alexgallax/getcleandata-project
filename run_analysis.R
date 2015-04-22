# Reading data from files
activityLabels <- read.table("./UCI HAR Dataset//activity_labels.txt", header = FALSE)
features <- read.table("./UCI HAR Dataset//features.txt", header = FALSE)

testSubject <- read.table("./UCI HAR Dataset//test//subject_test.txt", header = FALSE)
testX <- read.table("./UCI HAR Dataset//test//X_test.txt", header = FALSE)
testY <- read.table("./UCI HAR Dataset//test//y_test.txt", header = FALSE)

trainSubject <- read.table("./UCI HAR Dataset//train//subject_train.txt", header = FALSE)
trainX <- read.table("./UCI HAR Dataset//train//X_train.txt", header = FALSE)
trainY <- read.table("./UCI HAR Dataset//train//y_train.txt", header = FALSE)

# Bind 'test' and 'train' datasets together
xdataAll <- rbind(testX, trainX)
ydataAll <- rbind(testY, trainY)
subjectAll <- rbind(testSubject, trainSubject)

# Bind measurements, activity and subject datasets together
resAll <- cbind(xdataAll, ydataAll, subjectAll)
names(resAll) <- c(as.character(features[, 2]), "activity", "subject")

# Using descriptive activity names in dataset
resAll$activity <- factor(ydataAll[, 1], labels = activityLabels[, 2])

# Filter only mean and std measurements from dataset. 'meanFreq' not included here
meanStdData <- resAll[, !grepl("meanFreq", names(resAll)) & grepl("mean", names(resAll))
                      | grepl("std", names(resAll))
                      | grepl("activity", names(resAll))
                      | grepl("subject", names(resAll))]

# Changing dataset label to more readable ones
names(meanStdData) <- gsub("-", "", names(meanStdData))
names(meanStdData) <- gsub("()", "", names(meanStdData), fixed = TRUE)
names(meanStdData) <- gsub("^t", "time", names(meanStdData))
names(meanStdData) <- gsub("^f", "frequency", names(meanStdData))
names(meanStdData) <- gsub("Acc", "Acceleration", names(meanStdData))
names(meanStdData) <- gsub("Gyro", "Gyroscope", names(meanStdData))
names(meanStdData) <- gsub("Mag", "Magnitude", names(meanStdData))
names(meanStdData) <- gsub("BodyBody", "Body", names(meanStdData))
names(meanStdData) <- gsub("mean", "Mean", names(meanStdData))
names(meanStdData) <- gsub("std", "Std", names(meanStdData))

# Get number of columns in data frame to filter out measurements, acitvity and subject
dataWidth <- dim(meanStdData)[2]

# Group data by subject and activity, count mean for each measurement variable
averageData <- aggregate(meanStdData[, 1:(dataWidth - 2)], list(meanStdData$subject, meanStdData$activity), mean)

# Change variable names in columns, because now data have average values
names(averageData) <- c("subject", "activity", sapply(names(averageData[3:dataWidth]), paste, "Average", sep = ""))

# Uncomment next string if you want to export data in file in your working directory after script execution
# write.table(averageData, "averageData.txt", row.name = FALSE)