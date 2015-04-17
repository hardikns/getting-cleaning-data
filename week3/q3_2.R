library(jpeg)
q3_2 <- function() {
  if(!file.exists("./q3_2.data.jpg")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
                  dest="q3_2.data.jpg", method="curl")
  }
  data <- readJPEG("q3_2.data.jpg", TRUE)
  quantile(data, probs = c(0.3,0.8))
}