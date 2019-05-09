# reading needed libraries:
library(dplyr)
library(lubridate)


# downloading the zip file from the web:
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile = "data.zip")

# unzip/extracting the downloaded file
unzip("data.zip")

# read the relevant file to a data frame
full_table<-read.table("household_power_consumption.txt",sep=";",header=T,na.strings = "?")

# transfering Date and Time column to date format - in a new col called "Date_and_Time:
full_table<-mutate(full_table,Date_and_Time=paste(Date,Time))
full_table<-mutate(full_table,DnT=dmy_hms(Date_and_Time))

#filtering from table - a new table consisting only the desired dates (1-2-Feb-2007):
start_date<-dmy_hms("1/2/2007 00:00:00")
end_date<-dmy_hms("3/Feb/2007 00:00:00")
two_days_set<-filter(full_table,DnT>=start_date & DnT<end_date)

#open a png graphic device:
png("plot3.png", width=480, height=480)

# The plot:
with(two_days_set,plot(DnT,Sub_metering_1,type="l",ylab = "Energy sub metering",xlab=""))
with(two_days_set,lines(DnT,Sub_metering_2,col="red"))
with(two_days_set,lines(DnT,Sub_metering_3,col="blue"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#closing the graphic device:
dev.off()

