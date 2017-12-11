
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
intrain0 <- fread('pml-training.csv')

# selecting only the variables containing raw data
var_names <- names(intrain)
selected_vars <- var_names[grep('^accel|^gyros|^magnet|^roll|^pitch|^yaw|^classe', var_names)]
intrain <- subset(intrain0, select = selected_vars)

intrain_set <- createDataPartition(y = intrain$classe, p = 0.7, list = FALSE) 

train_set <- intrain[ intrain_set, ]
test_set <- intrain[-intrain_set, ]

# Cross validation applying k-fold method 
control = trainControl(method = "repeatedcv", repeats = 5)
## boocontrol = trainControl(method = "boo", number = 10)

# training two models: 1) random forest and 2) boosting 
rfmodfit = train(classe ~., data = train_set, method = "rpart", trControl = control)
pred1 <- predict(rfmodfit, test_set)
table(pred1, test_set$classe)
confusionMatrix(pred1, test_set$classe)


# printing the classification tree
rpart.plot(rfmodfit$finalModel)

# reading in the test data set
test_set <- fread('pml-testing.csv')

# predicting using the models built above
pred2 <- predict(rfmodfit, test_set)











