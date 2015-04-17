library(dplyr)
q3_1 <- function() {
  if(!file.exists("./q3_1.data.csv")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                dest="q3_1.data.csv", method="curl")
  }
  df <- read.csv("q3_1.data.csv", header=TRUE, stringsAsFactors=TRUE) 
  df <- mutate(df, agricultureLogical=(ACR=="3" & AGS=="6")) 
  which(df$agricultureLogical)
}