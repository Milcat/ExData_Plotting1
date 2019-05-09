# reading needed libraries:
library(dplyr)

# downloading the zip file from the web:
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile = "data.zip")

# unzip/extracting the downloaded file
unzip("data.zip")

# read the relevant file to a data frame
full_table<-read.table("household_power_consumption.txt",sep=";",header=T,na.strings = "?")

# transfering Date column to date format:
full_table$Date<-as.Date(full_table$Date,format="%d/%m/%Y")

#filtering from table - a new table consisting only the desired dates (1-2-Feb-2007):
two_days_set<-filter(full_table,Date=="2007-02-01" | Date=="2007-02-02")


#open a png graphic device:
png("plot1.png", width=480, height=480)

#preparing the histogram:
with(two_days_set,hist(Global_active_power,col="red",main="Globa Active Power",xlab="Globa Active Power (kilowatts)"))

#closing the graphic device:
dev.off()

