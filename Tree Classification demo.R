## Decision Trees in R
library(rpart) # The Library



fit <- rpart(Species~., data = iris, method = 'class') # The fitting



plot(fit) #plotting and labeling
text(fit)























#New Data
View(mtcars)

library(randomForest) #The library

fitRF <- randomForest(mpg~., data = mtcars, na.action = na.omit, ntree = 10)

print(fitRF) #Lets see the Structure

plot(fitRF) # Lets see the errors
importance(fitRF) # What is important?





















