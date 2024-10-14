## Notes

# can press esc to get out of an incomplete line of code
# can type sci notation as, e.g. 4e3 (no need for ^)
# exp(1) means e^ (1)

# log(4) = log base e(?) of 4 (?)
# log(base=2, x=4)
# rm(x) can remove individual variable

# six comparison functions
mynumber <- 6
mynumber == 5
mynumber >4
mynumber <4
mynumber>= 4
mynumber<= 4

# "==" means it is a question
# tab completion-- if you begin typing, it will auto complete
# != is NOT equal

#ls() shows all the lists in your environment
# rm(list = ls()) removes everything from environment
# NaN means "Not a Number"


#challenge
elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg*2.2  

myelephants <- c(elephant1_lb, elephant2_lb)  
myelephants

which(myelephants== max(myelephants))
