#
# plot3.R
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

plotSubMetering <- function(selected) {
  if (is.na(selected)) selected <- getSelected()
  
  with(selected, plot(DateTime, Sub_metering_1, col="black",
                      type="l",
                      ylab="Energy sub metering",
                      xlab="")
  )
  with(selected, lines(DateTime, Sub_metering_2, col="red"))
  with(selected, lines(DateTime, Sub_metering_3, col="blue"))
  legend("topright", DateTime, col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}

png(filename="plot3.png", width=480, height=480)
plotSubMetering(selected)
dev.off()
