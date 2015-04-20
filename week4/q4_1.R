q4_1 <- function() {
  if(!file.exists("./q4_1.data.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                  dest="q4_1.data.csv", method="curl")
  }
  df <- read.csv("q4_1.data.csv", header=TRUE, stringsAsFactors=TRUE, nrows=10) 
  print(names(df)[123])
  splitstr <- strsplit(names(df), "wgtp")
  print(splitstr[[123]])
}
q4_1()