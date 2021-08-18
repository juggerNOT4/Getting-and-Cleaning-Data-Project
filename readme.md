This readme file will try to explain "run_analysis.R" file.
1. Correct libraries of dplyr and readr are loaded
2. For the ease, the files are kept in the working directory. 
3. The files are txt files, so the read.table() function is used to read each file separately 
4. We can identify the dimensions of each of the datasets loaded using dim() function and identify which datasets can be merged together
5. Using rbind(), the datasets for X, Y and Subjects are merged
6. In the features.txt file, the appropriate names of features are present. We shall make them more distinct later. For now, we set these names to the combined data set of X, using names() function.
7 Now using cbind, we merge the combined datasets of subject, X, and Y and store into mergedata.
8. We are only concerned about mean() and std(). So we use grep() to extract the names consisting either of them, and store it in another variable.
9. Select the required columns (having mean and std), subject and activity columns from mergedata
10. change the numbers in activity column to appropriate activity names (refer activity_labels.txt file)
11. Give appropriate names to the columns of mergedata, by subsituting the abbreviations (t is for Time, f is for Frequency, Acc is Accelerometer, Gyro is Gyroscope, Mag is Magnitude, BodyBody is Body) using gsub() function
12. Create a final, tidy data frame by grouping according to the activity and subject. Summarise all with the mean and view the final data.