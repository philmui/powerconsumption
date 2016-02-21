##
# powerusage.R
# ============
# Read power usage file and perform exploratory (graphical) analysis
# of the data for the date range: 2007-02-01 and 2007-02-02
# 
# @author: philmui
##
library(lubridate)

start_date <- dmy("1/2/2007")
end_date   <- dmy("2/2/2007")

setwd("/Users/philmui/Dropbox/learn/coursera/04.exploratory.analysis/week1/assignment")
inputFile <- "./data/household_power_consumption.txt"
readData <- function() {
  con  <- file(inputFile, open = "r")
  df <- data.frame()
  # skip title line
  oneLine <- readLines(con, n = 1, warn = FALSE)
  prev_month <- 0
  while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
      if (! grepl("\\?", oneLine)) {
        tokens <- unlist(strsplit(oneLine, ";"))
        date <- dmy(tokens[1], quiet=T)
        
        if (prev_month != month(date)) {
          print(date)
          prev_month <- month(date)
        }
        if ((date >= start_date) & (date <= end_date)) {
          time <- hms(tokens[2], quiet=T)
          this_row <- c(date, time, 
                        as.numeric(tokens[3]), as.numeric(tokens[4]),
                        as.numeric(tokens[5]), as.numeric(tokens[6]),
                        as.numeric(tokens[7]), as.numeric(tokens[8]),
                        as.numeric(tokens[9]))
          df <- rbind(df, this_row)
        }
      }
  }
  close(con)
  names(df) <- c("Date", "Time", "GlobalActivePower", "GlobalReactivePower",
                 "Voltage", "GlobalIntensity", "SubMeter1", "SubMeter2", "SubMeter3")
  df
}

writeData <- function(df) {
  write.table(df, file="./data/selected_household_data.txt", sep=",", col.names = T)
}

