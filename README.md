# Common information and Requirements

Project contains `run_analysis.R` script, which performs reading data from files and all data transformations and analisys. First script reads the data from files, places in working directory. Separate data unites in one data set. Then script filters out mean and standard deviations measurements. The result of script execution is data set which contains average of mean and standard vediation values for each activity and each subject.

### Important Preconditions

To have this script working you should have data file in your working directory. To achieve this make the following:

* Download data by [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Unzip the downloaded archive
* Place received `UCI HAR Dataset` directory in your working directory where `run_analysis.R` script are situated

**Note:** if you don't have data files in your working directory, or data is partial or corrupted, the script can't work and process it properly.

### Versions and Packages

The script was developed on R version 3.1.3

# Input information

For input the script takes Human Activity Recognition Using Smartphones Dataset places in `UCI HAR Dataset` folder in your working directory.

Input data contains:

* `test` folder with test data
* `train` folder with train data
* `activity_labels.txt` - list of activities
* `features.txt` -list of features
* `features_info.txt` - features description
* `README.txt` - data set description

Each `test` and `train` sets contains data about measurements during experiment, their descriptions are equivalent:

* `X_test.txt` and `X_train.txt` - set of measurements values
* `y_test.txt` and `y_train.txt` - set of labels for activities
* `subject_test.txt` and `subject_train.txt` - the subject who performed the activity
* `Inertial Signals` - signals, measured during experiment, not used in script processing

**Note:** for more information about input data you may check `README.txt` file in `UCI HAR Dataset` directory.

# Processing steps

1. The `run_analysis.R` script reads the data from files in `UCI HAR Dataset` to data frames in R. The results of this step are data frames:

 * `activityLabels` - list of activities, reads `activity_labels.txt` file
 * `features` - list of all features, reads `features.txt` file
 * `testSubject` - list of subjects who performed activities in test group, reads `subject_test.txt` file
 * `testX` - measurements variables in test group, reads `X_test.txt` file
 * `testY` - activity labels in test group, reads `y_test.txt` file
 * `trainSubject` - list of subjects who performed activities in train group, reads `subject_train.txt` file
 * `trainX` - measurements variables in train group, reads `X_train.txt` file
 * `trainY` - activity labels in train group, reads `y_train.txt` file

2. Unite together `test` and `train` data frames, binding them by rows. The results of this step are data frames:

 * `xdataAll` - measurements variables from both groups
 * `ydataAll` - activity labels from both groups
 * `subjectAll` - subjects from both groups

3. Unite all in one data frame by columns. The result is `resAll` data frame with the following columns:

 * Measurements variables (first 561 columns, each measurement in its own column)
 * Activity (in numeric here)
 * Subject

4. Name each column. Script takes measurement variables names for `features` data frame and assign them to `resAll` data frame names.

5. Change activity numbers to text names. Factorize activity column if data set with `activityLabels` data frame.

6. Filter out mean and standard deviation measurements from data frame. Script take only `mean` and `std` variables, not `meanFreq`. The result is `meanStdData` data frame with mean and standard deviation measurements in first columns and activity and subject columns.    

7. Descriptive names for measurements variables. Names of measurement variables columns change to more readable format.

8. Group `meanStdData` by `subject` and `activity` and counts mean for each measurement variable. The result is `averageData` data frame.

9. Change variable names in `averageData` columns, marking that now it's average values. 

# Resulting data

The result of script execution is data frame `averageData`. It contains:

* `subject` column - subject who performed the activity
* `activity` column - type of activity
* columns of averages for each variable

Each row of resulting data frame contains values of measurement variables averages for particular subject and activity.

### Data output

If you want to create text file with resukting data set, uncomment the last string in the script: `write.table(averageData, "averageData.txt", row.name = FALSE)`. Otherwise data set will be created in operating memory only. It was done to not create any file on your computer without your permission.