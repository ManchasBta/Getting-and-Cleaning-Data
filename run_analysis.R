##Getting and Cleaning Data
##Getting and Cleaning Data Course Project
##by MAVC 25/07/2014

## reading data from the working directory
setwd("~/My Documents/2014 Coursera/Data Science - Johns Hopkins Uni/Getting and Cleaning Data/Getting and Cleaning Data Project")

### test data
subject_test <- read.table("~/My Documents/2014 Coursera/Data Science - Johns Hopkins Uni/Getting and Cleaning Data/Getting and Cleaning Data Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"")
X_test <- read.table("~/My Documents/2014 Coursera/Data Science - Johns Hopkins Uni/Getting and Cleaning Data/Getting and Cleaning Data Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("~/My Documents/2014 Coursera/Data Science - Johns Hopkins Uni/Getting and Cleaning Data/Getting and Cleaning Data Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"")

### train data
subject_train <- read.table("~/My Documents/2014 Coursera/Data Science - Johns Hopkins Uni/Getting and Cleaning Data/Getting and Cleaning Data Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"")
X_train <- read.table("~/My Documents/2014 Coursera/Data Science - Johns Hopkins Uni/Getting and Cleaning Data/Getting and Cleaning Data Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("~/My Documents/2014 Coursera/Data Science - Johns Hopkins Uni/Getting and Cleaning Data/Getting and Cleaning Data Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"")

### rename subject_test, subject_train columns name to Subject
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"

### merge all data set in one
total_data <- rbind(cbind(subject_test, y_test, X_test), cbind(subject_train, y_train, X_train))
write.table(total_data, "Merged_RawData.csv", col.names=TRUE, sep=",")

### Changing Activity and Subject to descreptive factors
total_data[total_data$Activity == 1,"Activity"]<- "Walking"
total_data[total_data$Activity == 2,"Activity"]<- "Walking_Upstairs"
total_data[total_data$Activity == 3,"Activity"]<- "Walking_Downstairs"
total_data[total_data$Activity == 4,"Activity"]<- "Sitting"
total_data[total_data$Activity == 5,"Activity"]<- "Standing"
total_data[total_data$Activity == 6,"Activity"]<- "Laying"
total_data$Activity <- as.factor(total_data$Activity)
total_data$Subject <- as.factor(total_data$Subject)

### Calculating mean and standard deviation for each measurement
meansAndstdev <- cbind(colMeans(total_data[,3:563], na.rm = TRUE), sapply(total_data[,3:563], sd, na.rm = TRUE))
mAsd <- as.data.frame(meansAndstdev)
names(mAsd) <- c("Mean","StDev")
write.table(mAsd, "MeansAndStadev_RawData.csv", col.names=TRUE, sep=",")

### Split Data set by Activity and by Subject
split_activity <- split(total_data, total_data$Activity)
split_subject <- split(total_data, total_data$Subject)

meansByActivity <- lapply(split_activity, function(x) colMeans(x[,3:563], na.rm = TRUE))
meansBySubject <- lapply(split_subject, function(x) colMeans(x[,3:563], na.rm = TRUE))

stdevByActivity <- lapply(as.numeric(unlist(split_activity)), function(x) sd(x, na.rm = TRUE))
stdevBySubject <- lapply(as.numeric(unlist(split_subject)), function(x) sd(x, na.rm = TRUE))