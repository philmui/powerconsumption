#
# plot4.R
#
library(dplyr)

getSelected <- function() {
  inputFile <- "./data/household_power_consumption.txt"
  df <- read.table(inputFile, sep=";", na.strings = "?", header=TRUE)
  df <- df[df[,1] == "1/2/2007" | df[,1] == "2/2/2007",]
  selected <- tbl_df(df)
  selected <- mutate(selected, "DateTime"= paste(as.character(Date), as.character(Time)))
  selected$DateTime <- strptime(selected$DateTime, format="%d/%m/%Y %H:%M:%S")
  selected
}

plotVoltage <- function(selected) {
  with(selected, plot(DateTime, 
                      Voltage, 
                      col="black",
                      type="l",
                      ylab="Voltage", 
                      xlab="datetime"))
}

plotGlobalReactivePower <- function(selected) {
  with(selected, plot(DateTime, 
                      Global_reactive_power, 
                      col="black",
                      type="l",
                      ylab="Global_reactive_power", 
                      xlab="datetime"))
}

plot4 <- function(selected) {
  if (is.na(selected)) selected <- getSelected()
  par(mfcol=c(2,2))
  plotGlobalActivePower(selected)
  plotSubMetering(selected)
  plotVoltage(selected)
  plotGlobalReactivePower(selected)
}

png(filename="plot4.png", width=480, height=480)
suppressWarnings(plot4(selected))
dev.off()
