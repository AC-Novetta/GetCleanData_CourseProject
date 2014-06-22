# Code Book explaining the data and code

## Data:

A full explanation of the data used for this project is found:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data was downloaded, unzipped, and then the R code found in this repository at:
https://github.com/AC-Novetta/GetCleanData_CourseProject/blob/master/run_analysis.R
was run to transform the data into a tidy dataset with an average (mean) calculated for each factor of interest per activity / subject combination.

## Code:

The following steps are performed in the code:
* Add libraries
* Unzip data files to the working directory
* Read in the training unzipped files from the working directory 
* Append the label numbers for activity and subject to the training data
* Read in the testing unzipped files from the active directory
* Append the label numbers for activity and subject to the testing data
* Read in the activity number to human readable activity label conversion table
* Read in the feature number to human readable feature labels for column names
* Make sure all the data is in the correct format
* Combine the test and training data into a single dataset
* Rename columns to human readable descriptions
* Append the human readable labels to the all_data dataset
* Rename the appended column to be more human readable
* Make sure all the data is in the correct format
* Subset the data to only include the mean and standard deviation factors
* Switch data into 1 row per observation
* Get the mean and standard deviation for each variable summarized by activity and subject
* Convert to tidy data
* Write melted, tidy data to a file called "tidy_accel_data_courseproject.txt"
