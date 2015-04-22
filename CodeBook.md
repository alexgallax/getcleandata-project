# Input data

### Description

For input the script takes Human Activity Recognition Using Smartphones Dataset places in `UCI HAR Dataset` folder in your working directory.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

**Note:** check `README.txt` file in `UCI HAR Dataset` data set directory for more information about input data.

### Data types

Data divided in two grops: `test` and `train`, each contains in corresponding folder.

Data collected in the following files:

##### `activity_labels.txt`

List of activities, performed in experiment.

Values: 1st column of integers, 2nd column of factor character 

* 1 `WALKING`
* 2 `WALKING_UPSTAIRS`
* 3 `WALKING_DOWNSTAIRS`
* 4 `SITTING`
* 5 `STANDING`
* 6 `LAYING`

##### `features.txt` 

List of features.

Values: 561-feature vector with time and frequency domain variables. Each feature vector is a row in text file.

##### `X_test.txt`, `X_train.txt`
(for test and train data sets correspondingly)

Set of measurements values.

Values: numeric, normalized and bounded within [-1,1].

##### `y_test.txt`, `y_train.txt`
(for test and train data sets correspondingly)

Set of labels for activities. Links labels with activity name.

Values: integer numbers from 1 to 6.

##### `subject_test.txt`, `subject_train.txt`
(for test and train data sets correspondingly)

The subject who performed the activity for each window sample.

Values: integer numbers from 1 to 30.

##### `Inertial Signals`

Signals, measured during experiment for test and train groups. Not used in script processing.

# Data processing

1. Reading data from files. Data reads separately in several data frames. The results are:

 * `activity names data frame` with 2 columns: number of activity (integer from 1 to 6), activity name (character factor)
 * `features data frame` with 2 columns: number of feature (integer from 1 to 561), feature name (character factor)
 * `subject data frames` for test and train groups with 1 column: subject number (integer from 1 to 30).
 * `measurement variables data frame` for test and train groups with 561 columns: each column contain one measurement variable. Values are numeric, normalized and bounded within [-1,1].
 * `activity labels data frame` for test and train groups with 1 column: activity number (integer from 1 to 6).

2. Unite test and train data frames together by rows. The first set of rows corresponds to test data, and after them rows corresponding to train data. Value types of data frames are the same as their components. The results are:

 * `measurement values data frame`.
 * `activity labels data frame`.
 * `subject data frame`.

3. Unite data frames in one. The result is data frame with the following columns:

 * `561 measurement variables` columns, each measurement value in one column. Values are numeric, normalized and bounded within [-1,1].
 * `activity` column. Integers from 1 to 6.
 * `subject` column. Integer from 1 to 30.
 * Each row is one measurement from test or train group.

4. Name measurement variables columns. Using feature names data set name each columns with measurement variables.

5. Change numbers in activity column to corresponding text names. Activity column is a factor with 6 levels.

6. Filter out mean and standard deviation measurements. Average of the frequency components (`meanFreq` variables) not included here. Only `mean` and `std` variable. The results is data frame with the followin columns:

 * `measurement variables` columns, containing onle mean and standard deviation variables. Each measurement variable in one column. Values are numeric, normalized and bounded within [-1,1].
 * `activity` column. Character factor with 6 levels.
 * `subject` column. Integer from 1 to 30.

7. Descriptive names for measurements variables. Change names of columns with measurement variables to more readable format.

8. Group data by `subject` and `activity` and counts mean for each measurement variable. The result is data frame with the following columns:

 * `subject` - subject who performed the activity. Integer from 1 to 30.
 * `activity` - type of activity. Character factor with 6 levels.
 * `average variables` for each measurement variable, calculated for each `subject` and each `activity`, numeric.

9. Rename variable names, because now they are average values.

# Resulting data

The result of script execution is data frame. For each `subject` and each `activity` average values of each measurement variable calculated.

### Variables (each variable in one column):

##### `subject`

Subject who performed the activity.

Integer from 1 to 30.

##### `activity`

Each column have one variable.

Type of activity. Character factor with 6 levels.

* `WALKING`
* `WALKING_UPSTAIRS`
* `WALKING_DOWNSTAIRS`
* `SITTING`
* `STANDING`
* `LAYING`

##### `averages of measurement values`

Calculated from input data set by takin averages for mean and standard deviation variables.

Numeric.

Names of variables in columns written in camel case, and defined as:

* `time` - time domain signal
* `frequency` - frequency domain signal
* `BodyAcceleration` - body acceleration signal
* `GravityAcceleration` - gravity acceleration signal
* `BodyGyroscope` - body gyroscope signal
* `Magnitude` - signals magnitude
* `Jerk` - Jerk signals
* `Mean` - mean
* `Std` - standard deviation
* `X` - X-axial
* `Y` - Y-axial
* `Z` - Z-axial