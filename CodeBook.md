# CodeBook
This code book tells about output dataset `tidy_set.txt` and its data feilds

## Introduction
* First we read files `x_train.txt`, `y_train.txt`, `subject_train.txt`, `x_test.txt`, `y_test.txt`, `subject_test.txt`, `features.txt` and `activity_labels.txt` and store them in variables `trainx`, `trainy`, `sub_train`, `testx`, `testy`, `sub_test`, `features`, `act_labels` respectively.
* Next we assign column names from variable `features`
* Then we merge data stored in variables `trainy`, `trainx`, `sub_train` using `cbind()` and store them in `comb_train`. Also, data stored in variables `testx`, `testy`, `sub_test` using `cbind()` and store them in `comb_test`. Next we merge variables `comb_train` and `comb_test` using `rbind()` and store them in `master_com`.
* Next we create a variable `standev_mean` to define ID, standard deviation and mean. we also make required subset from `master_com` and store it in `standev_mean_set`.
* Then we merge `standev_mean_set` and `act_labels` by `activityID`and store it in `Act_names_set`.
* Last we create a tidy set of data and write it in a text file with name `tidy_set.txt`

## Variables
* `trainx`, `trainy`, `sub_train`, `testx`, `testy`, `sub_test` contains data from files `x_train.txt`, `y_train.txt`, `subject_train.txt`, `x_test.txt`, `y_test.txt`, `subject_test.txt`.
* `features` contains data from file `features.txt`.
* `act_labels` contains data from `activity_labels.txt`.
* `comb_train`, `comb_test` and `master_com` merges files for analysis.
* `standev_mean` is a vector defining ID, Standard deviation and mean.
* `standev_mean_set` is the new dataset that only have mean and standard deviation
* `Act_names_set` merges all data.
* `tidy_set` is new tidy data set. 
