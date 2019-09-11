cotton <- read.csv('https://raw.githubusercontent.com/kwstat/agridat/master/data-done/silva.cotton.csv')

str(cotton)

# How many observations (rows) are there in the data?
nrow(cotton)

# How many of the variables are categorical?
# How many unique values does the variable stage have?
unique(cotton$stage)

# What is the mean value of variable height?
mean(cotton$height)

# What is the total weight of all observations? You need to sum the values of variable weight. 
sum(cotton$weight, na.rm = T)

# How many of the values of variable weight are missing?
sum(is.na(cotton$weight))

# How high is the highest cotton plant in the data set?
max(cotton$height)

# How many cotton plants in the data have more than 5 bolls?
# You need to write this condition as a logical expression and then sum it.
sum(cotton$bolls > 5)

# What is the mean height of a vegetative cotton plant?
# You can get only the vegetative plants and then calculate mean height.
# OR
# You can get mean heights by stage by aggregating data and then see the value for vegetative stage.
mean(cotton[cotton$stage == 'vegetative', 'height'])
aggregate(height ~ stage, cotton, mean)
