set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2


# set.seed(15) = initial value is 15, helping determine random values

# runif()----
# first value = n or length, second is min, third is max

#1. Take your hw2 vector and removed all the NAs then select all the numbers 
# between 14 and 38 inclusive, call this vector prob1.
prob1 <- hw2[!is.na(hw2) & hw2>14 & hw2<38]
prob1

#2. Multiply each number in the prob1 vector by 3 to create a new vector 
# called times3. Then add 10 to each number in your times3 vector to create 
# a new vector called plus10.

times3 <- prob1 * 3
plus10 <- times3 + 10

#3. Select every other number in your plus10 vector by selecting the first 
# number, not the second, the third, not the fourth, etc. If you’ve worked 
# through these three problems in order, you should now have a vector that is 
# 12 numbers long that looks exactly like this one:


plus10[c(T, F)]
