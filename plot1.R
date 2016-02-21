#
# plot1.R
#
library(dplyr)
selected <- NA

getSelected <- function() {
  inputFile <- "./data/household_power_consumption.txt"
  df <- read.table(inputFile, sep=";", na.strings = "?", header=TRUE)
  df <- df[df[,1] == "1/2/2007" | df[,1] == "2/2/2007",]
  selected <- tbl_df(df)
  selected <- mutate(selected, "DateTime"= paste(as.character(Date), as.character(Time)))
  selected$DateTime <- strptime(selected$DateTime, format="%d/%m/%Y %H:%M:%S")
  selected
}

plot1 <- function(selected) {
  if (is.na(selected)) selected <- getSelected()
  
  png(filename="plot1.png", width=480, height=480)
  with(selected, hist(Global_active_power, 
                      main="Global Active Power", 
                      xlab="Global Active Power (kilowatts)", 
                      col="red"))
  dev.off()
}

plot1(selected)