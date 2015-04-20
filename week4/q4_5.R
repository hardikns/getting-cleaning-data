library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
sampleTimes
df <- data.frame(sapply(sampleTimes, format, "%Y"), sapply(sampleTimes, format, "%a"))
names(df) <- c("year", "dayofweek")
print(table(df$year))
print(table(df))