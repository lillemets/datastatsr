#? ...

# Get ----------

Oie <- read.csv('/home/jrl/rcrs/results/results.csv')
Oie <- Oie[!is.na(Oie$pts), ]

# Tidy ----------

Oie <- merge(Oie, 
             data.frame(last = unique(Oie$last), 
                        id = sample(LETTERS, length(unique(Oie$last)))), 
             all = T)

Oie$type <- ifelse(grepl('\\?', Oie$name), 'Comment', 'Action')

# Antsule ----------

antsule <- aggregate(cbind(pts, pts.max) ~ last + first, Oie, sum)
antsule$pts.prc <- antsule$pts / antsule$pts.max

com <- aggregate(cbind(pts, pts.max) ~ last, Oie[Oie$type == 'Comment', ], sum)
com <- data.frame(last = com$last, pts.prc.com = com$pts / com$pts.max)

antsule <- merge(antsule, com, all = T)
antsule <- antsule[order(antsule$pts.prc, decreasing = T), ]
antsule <- antsule[, c('first', 'last', 'pts.prc', 'pts.prc.com')]
names(antsule) <- c('Eesnimi', 'Perekonnanimi', 'Punktid (0..1)', 'Punktid vabavastustest (0...1)')

write.csv2(antsule, '/home/jrl/rcrs/results/tulemused.csv', row.names = F)

# Feedback ----------

pts <- antsule
pts[, 3] <- round(pts[, 3] * 100)

Oie$id <- NULL

for (i in unique(Oie$last)) {
  temp <- Oie[Oie$last == i, ]
  write.csv(temp, paste0('/home/jrl/rcrs/results/feedback/', i, '.csv'), row.names = F)
}
