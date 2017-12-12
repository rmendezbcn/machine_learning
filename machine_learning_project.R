
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
var_names <- names(intrain0)
selected_vars <- var_names[grep('^accel|^gyros|^magnet|^roll|^pitch|^yaw|^classe', var_names)]

intrain <- subset(intrain0, select = selected_vars)

# Explore whether we still have near zero variance 
near_zero_vars <- nearZeroVar(intrain, saveMetrics = TRUE)
near_zero_vars[near_zero_vars$nzv == "TRUE",]


# cross validation by splitting the training data set into two different sets
intrain_set <- createDataPartition(y = intrain$classe, p = 0.6, list = FALSE) 

train_set0 <- intrain[intrain_set, ]
test_set0 <- intrain[-intrain_set, ]

# Detect and remove collinear variables
#cor_matrix <- cor(train_set0[,-49]) # Make a corelation matrix without the "classes" variable
#cor_vars <- findCorrelation(cor_matrix, cutoff = .90) # Find correlation above 90% in the correlation matrix
#
#train_set <- train_set0[1:10, names(train_set0) %in% names(train_set0)[cor_vars]] # Take out correlated variables from the training and testing data sets
#test_set <- test_set0[,-cor_vars]


# Preprocessing the predictors
rf_control <- preProcess(train_set0[, -49], method = c("center", "scale"), na.action = na.omit)

# training the model: random forest 
boost_modfit <- train(classe ~., method = 'gbm', data = train_set0, verbose = FALSE)

# Random forest not performed because it requiered took too long to compute
rf_modfit <- randomForest(classe ~., data = train_set)
varImpPlot(rf_modfit)

boost_pred <- predict(boost_modfit, newdata = test_set)


table(boost_pred, test_set$classe)
confusionMatrix(boost_pred, test_set$classe)$overall[1]


# printing the classification tree
#???rpart.plot(rfmodfit$finalModel)

# reading in the test data set
test_set <- fread('pml-testing.csv')

# predicting using the models built above
final <- predict(boost_modfit, test_set)











