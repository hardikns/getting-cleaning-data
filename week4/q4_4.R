q4_4 <- function() {
  if(!file.exists("./q4_4.data1.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                  dest="q4_4.data1.csv", method="curl")
  }
  if(!file.exists("./q4_4.data2.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                  dest="q4_4.data2.csv", method="curl")
  }  
  gdp <- read.csv("q4_4.data1.csv", header=FALSE, skip=5, nrows=190, stringsAsFactors=TRUE) 
  edu <- read.csv("q4_4.data2.csv", header=TRUE, stringsAsFactors=TRUE)   
  gdp <- gdp[,1:5]
  
  merged_data <- merge(gdp, edu,all=FALSE, by.x = "V1", by.y="CountryCode" ) 
  print(length(grep("June", grep("Fiscal year end", as.character(merged_data$Special.Notes), value = TRUE))))
  
}
q4_4()