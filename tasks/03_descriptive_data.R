soy <- agridat::australia.soybean

# Keep only genotype G01
#soy <- soy[soy$gen == 'G01', ]

# Make two
soyYield <- soy[, c('loc', 'year', 'gen', 'yield')]
soy$yield <- NULL
head(soy);head(soyYield)

# Add missing
soy$height[sample(nrow(soy), 10)] <- NA

# Add duplicates
soy <- rbind(soy, soy[sample(nrow(soy), 8), ])

# Shupple rows
soy <- soy[sample(nrow(soy)), ]
duplicated(soy)

# Save
write.csv(soy, '/home/jrl/rcrs/data/australia_soybean.csv', row.names = F)
write.csv(soyYield, '/home/jrl/rcrs/data/australia_soybean_yield.csv', row.names = F)
