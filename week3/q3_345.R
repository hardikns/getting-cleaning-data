#library(dplyr)
q3_3_4_5 <- function() {
  if(!file.exists("./q3_3.data1.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                  dest="q3_3.data1.csv", method="curl")
  }
  if(!file.exists("./q3_3.data2.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                  dest="q3_3.data2.csv", method="curl")
  }  
  gdp <- read.csv("q3_3.data1.csv", header=FALSE, skip=5, nrows=190, stringsAsFactors=TRUE) 
  edu <- read.csv("q3_3.data2.csv", header=TRUE, stringsAsFactors=TRUE)   
  gdp <- gdp[,1:5]
  
  merged_data <- merge(gdp, edu,all=FALSE, by.x = "V1", by.y="CountryCode" ) 
  merged_data <- arrange(merged_data, desc(V2))
  print("Question3:")
  print(dim(merged_data)[1])
  print(merged_data[13,"Long.Name"][1])
  
  print("Question4:")
  print(tapply(merged_data$V2, merged_data$Income.Group, mean))
  
  library(Hmisc)
  merged_data$gdpQuantileGroups <- cut2(merged_data$V2, g=5)
  print("Question5:")
  print(table(merged_data$gdpQuantileGroups, merged_data$Income.Group))
}

q3_3_4_5()