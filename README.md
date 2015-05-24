# GettingAndClenaingData
Course project for Coursera course on Getting and Cleaning Data.

## Hint for my marker.
If you've downloaded the dataset you can read it using the following code.

`result <- read.table("f974f7a0025b11e58797373d8139a34a.txt",header=TRUE)

View(result)`

##About the program (study design)
The data for this project was downloaded from the following link:
[http://https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](http://https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

More information on the original data is available from here:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data used to develop this program was downloaded on 2015/05/22 and copied to the working directory into a directory called `data` with subdirectories `data\test` and `data\train` similar to the original structure in the downloaded zip file.

The code for this analysis resides in `run_analysis.R`

If you source `run_analysis.R` the function that will do the analysis is called **process_data()**.

###About the code
The anaylis done as requested for this project follows the following logic.

- All the files are read into objects.
- The raw data from the training and test data sets are combined using rbind
- The column names for the dataframe is added from the features file
- The subjects and activities related to the data is added as columns of the dataframe
- The labels of the activities are added by **merging** the activity labels with the dataframe.  

At this stage all the data resides in one large dataframe. Once this is done the analysis is done using the following logic.

- All the measurements containg standard devation (std) and the mean values are identified using grep on the column names. Only these columns will be **selected** for future analysis.
- Using the `melt` function from the `reshape2` library the data is converted to the long form using the subject and activity as ID values.
- Using the `dcode` function the data is written back to the wide format containing only the mean value for all the variables selected per subject per activity.
- The resulting data is written to a text file called `result.txt`.


###About the data in result.txt (code book)
The resulting data table contains 180 rows (6 activities for each of the 30 subjects). 

The first column contains the subject id and the second column the description of the activity when the measurements where taken. 

The rest other 79 columns contains the mean for each original variable that contained either the mean or standard deviation for that measurement. The column names describe the differnt values contained.







