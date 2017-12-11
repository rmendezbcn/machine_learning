
library(data.table)
library(ggplot2)
library(caret)
library(pgmm)
library(rpart)
library(rpart.plot)
library(ISLR)
set.seed(123456)
# setting wd 
setwd(path = '~/Google Drive/COURSERA/machine_learning')

# Reading in the training data set 
intrain <- fread('pml-training.csv')

# selecting only the variables containing raw data
var_names <- names(intrain)
selected_vars <- var_names[grep('^accel|^gyros|^magnet|^roll|^pitch|^yaw|^classe', var_names)]
train_set <- subset(intrain, select = selected_vars)

 
# Cross validation applying k-fold method 
control = trainControl(method = "repeatedcv", repeats = 5)
## boocontrol = trainControl(method = "boo", number = 10)

# training two models: 1) random forest and 2) boosting 
rfmodfit = train(classe ~., data = train_set, method = "rpart", trControl = control)
## boostmodfit <- train(classe ~., data = train_set, method = 'gbm', verbose = FALSE)

# printing the classification tree
rpart.plot(rfmodfit$finalModel)

# reading in the test data set
test_set <- fread('pml-testing.csv')

# predicting using the models built above
pred1 <- predict(rfmodfit, test_set)











