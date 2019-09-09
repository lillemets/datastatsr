#? Task 3

# Import data and store it in an object with a name of your own choosing
### Use function read.csv().

soy <- read.csv('/home/jrl/rcrs/data/australia_soybean.csv')

# Get an overview of the data set.
# How many rows and columns are in the data? What type of variables are there?
### Use functions str() and head().

str(soy)
head(soy)

# Order data by variables "env" and "gen". 
### Use function order() to get the ordering by "env" and "gen".
### Then use it to get rows in that order.

order(soy$env, soy$gen)
soy <- soy[order(soy$env, soy$gen), ]
head(soy)

# See summary statistics on all variables.
# What are the differen values of "gen"?
# Are there any missing values?
### Use function summary() on the data frame.

summary(soy)

# Find mean of height
### Use function mean(). Use "?mean" if you run into problems.

mean(soy$height)
?mean
mean(soy$height, na.rm = T)

# See which unique genotype ("gen") are in the data.frame
### Use function unique() on the values of "gen".

unique(soy$gen)

# Remove rows where "height" is missing. 
### Use function is.na() on "height" to get a logical vector indicating missing rows.
### Then use the opposite of that to subset rows where it is not missing.
### Finally, use sum(is.na()) to count missing values of "height" to make sure it worked.

sum(is.na(soy$height))
is.na(soy$height)
!is.na(soy$height)
soy <- soy[!is.na(soy$height), ]
sum(is.na(soy$height))

# Remove duplicate rows
### Use function duplicated() on the data frame to find duplicated rows

sum(duplicated(soy))
duplicated(soy)
!duplicated(soy)
soy <- soy[!duplicated(soy), ]
sum(duplicated(soy))

# Keep only data where seed size ("size") is greater than 5 
# and height is less than or equal to 1.5

soy$size > 8 & soy$height < 1
soy <- soy[soy$size > 5 & soy$height <= 1.5, ]

# Add a new variable "new.height" that has values of "height" + 0.1 
# if loc is "Lawes" and otherwise has the values of "height".
### Use function ifelse()

soy$loc == "Lawes"
soy$new.height <- ifelse(soy$loc == "Lawes", soy$height + .1, soy$height)
head(soy)

# Merge the data frame with another data frame containing yields.
# Download data set to use for merging from the address below.
# https://raw.githubusercontent.com/lillemets/datastatsr/master/data/australia_soybean_yield.csv
### Use read.csv() to get data from url and the function merge() to join datasets.

soyYi <- read.csv('https://raw.githubusercontent.com/lillemets/datastatsr/master/data/australia_soybean_yield.csv')

soy <- merge(soy, soyYi, by = c('loc', 'year', 'gen'), all.x = T, all.y = F)
head(soy)

# Find the mean yield for all genotypes ("gen").
# Then find total height by location ("loc") and year.
### Use function aggregate() and specify formula, e.g. "yield ~ gen".

aggregate(yield ~ gen, soy, mean)
aggregate(height  ~ loc + year, soy, sum)

# Save

getwd()
write.csv(soy, 'soy.csv', row.names = F)
