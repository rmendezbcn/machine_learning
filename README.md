# machine_learning
Briefly,
I load the data into R and selected the variables containing raw data, which at the same excluded all those variables containing calculated data like for example kurtosis, skewness, averages or standard deviations. In total 48 out of the 160 variables were selected for the project.

Following I created a partition of the training set to build test set and build the model. I chose a random forest model with a cross validation applying the k-fold method: 10 times and 5 repetitions.

After that I tested the model predicting the cases in the sub-partition of the initial training set. The accuracy of the model was really low, smaller than 0.5, which is lower than a random selection, for which the model should be rejected. 

The problem most probably was in the selection of the variables that must be repeated taking selecting a larger number of variables.

Thanks,
Raul 

----------------
