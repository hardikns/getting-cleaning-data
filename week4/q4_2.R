library(stringr)
q4_2 <- function() {
  if(!file.exists("./q4_2.data.csv")) {
    download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                  dest="q4_2.data.csv", method="curl")
  }
  gdp <- read.csv("q4_2.data.csv", header=FALSE, skip=5, nrows=190, stringsAsFactors=TRUE) 
  print(mean(as.integer(gsub("," , "", x=str_trim(as.character(gdp$V5))))))
  print(length(grep("^United", gdp$V4)))
}
q4_2()