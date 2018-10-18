dice <- read.table("100DiceRolls.txt", sep = ",", header = T)
attach(dice)

# Plot a histogram and change the bins
hist(d4)
hist(d4, breaks = c(1,2,3,4))
hist(d4, breaks = c(0,1,2,3,4))
hist(d6, breaks = c(0,1,2,3,4,5,6))

# by default, R is right hand inclusive and left hand exclusive
# we need to change the bins if we want to include the left hand and exclude the right hand
hist(d6, breaks = c(0,1,2,3,4,5,6), right = F)
hist(d6, breaks = c(1,2,3,4,5,6,7), right = F)

# If we want to center our bars over the data value, we need to be clever with our bins
# We also need to adjust the xlimit for better visuals
hist(d8, breaks = c(0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5))
hist(d8, breaks = c(0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5), xlim = c(0,9))

# Lastly, let's give the graph some good names and labels
hist(d8, breaks = c(0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5), xlim = c(0,9), ylim = c(0,.2),
     freq = F,
     xlab = "Outcome of a d8 Roll", ylab = "Relative Frequency", main = "Histogram of d8 Rolls")
lines(density(d8), lty = 2)

m = mean(d8)
std = sd(d8)
curve(dnorm(x, mean=m, sd=std), 
      col="darkblue", lwd=2, add=TRUE, yaxt="n")
