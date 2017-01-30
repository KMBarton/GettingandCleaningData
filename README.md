the script run_analysis.R was created to analyse the data from the accelerometer of 
Samsung Galaxy S smartphones. The data is imported as a zip file which is downloaded and unzipped.
Then, the data from the test and the train data sets (see CodeBook.md for more info)
are loaded into R separately. The identifying information for each of the data sets including
measurement names, subject IDs., and the activity for which each measurement was recorded for 
are labeled. Once the data sets are labeled appropriately, they are combined into one large data 
set. Then, the rows that include information regarding means (including frequency means) or standard 
deviations are extracted to a separate data frame. In the last few commands, the data is melted using the 
subject ID and activity as ID variables. These variables are then used to create a summary 
table that includes the average for each variable for each activity for each subject. This table
can be found under the R object "tidyds" or in the exported tidyds.csv file.# GettingandCleaningData
