# Build a logistic regression model to predict the survival probability of Titanic passengers.
## Test By posit.clound

# Load Library & Dataset
library(tidyverse)
library(titanic)

# Preview the Dataset
head(titanic_train)

# Clean Dataset
## DROP NA (MISSING VALUES)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train) * 0.7

# Split Data for train, test
## Count All, Split to train and test
set.seed(18)
n <- nrow(titanic_train)
id <- sample(1:n, size = 500)
train_data <- titanic_train[id,]
test_data <- titanic_train[-id,]

## Preview Data
glimpse(train_data)

## transform sex to factor
train_data$Sex <- ifelse(train_data$Sex == "male",1,0)
test_data$Sex <- ifelse(test_data$Sex == "male",1,0)
train_data$Pclass <- factor(train_data$Pclass,
                            levels = c(1,2,3),
                            ordered = TRUE)
test_data$Pclass <- factor(test_data$Pclass,
                           levels = c(1,2,3),
                           ordered = TRUE)


## Formula is Y = f(x1, x2, x3)
glm(Survived ~ Pclass + Sex + Age, 
    data = train_data,
    family = "binomial"
)

## Create Model
survival_pre <- glm(Survived ~ Pclass + Sex + Age, 
                    data = train_data,
                    family = "binomial")

## Use Model that just create to predict (y = survival)
predict(survival_pre, 
        type = "response")

## threshold set up @ 0.5
train_data$pre_sur <- ifelse(predict(survival_pre, 
                                     type = "response")>= 0.5 ,1,0)

train_data$Survived == train_data$pre_sur

mean(train_data$Survived == train_data$pre_sur)

acc_train <- mean(train_data$Survived == train_data$pre_sur)

## Accuracy is 80% 
# [1] 0.796

## Use model by using test data

predict(survival_pre, 
        newdata = test_data,
        type = "response")

test_data$pre_sur <- ifelse(predict(survival_pre, 
                                    newdata = test_data,
                                    type = "response") >= 0.5,
                            1,0)

test_data$pre_sur == test_data$Survived

mean(test_data$pre_sur == test_data$Survived)

acc_test <- mean(test_data$pre_sur == test_data$Survived)

## Accuracy is 80%
# [1] 0.7943925

## Summary
cat("Train Data's accuracy is",acc_train,
    "\nTest Data's accuracy is",acc_test)

# Train Data's accuracy is 0.796 
# Test Data's accuracy is 0.7943925
