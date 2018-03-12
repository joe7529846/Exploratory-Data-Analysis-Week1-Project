HPC_data = read.table("C:/Users/joe/Documents/HW1/household_power_consumption.txt",
               header=T,
               sep=";",
               na.strings="?",
               stringsAsFactors=F)

#List the storage form of variables in the data frame
str(HPC_data) 

#List the first few files
head(HPC_data)     
summary(HPC_data)  

HPC_data$Date_Time=as.POSIXct(
  paste(HPC_data$Date, HPC_data$Time), 
  format = "%d/%m/%Y %H:%M:%S")


#Loading the dplyr kit
library(dplyr) 
#Convert to date/time data
beginning=as.POSIXct("2007-02-01 00:00:00")
ending=as.POSIXct("2007-02-03 00:00:00")
HPC_sub=filter(HPC_data, Date_Time >= beginning, Date_Time < ending)
head(HPC_sub)
#Check the number of data
dim(HPC_sub)



#Plot3
plot(x = HPC_sub$Date_Time , y = HPC_sub$Sub_metering_1, type = "l", xlab = "", xaxt = "n", ylab = "Energy sub metering")
lines(x = HPC_sub$Date_Time, y = HPC_sub$Sub_metering_2, col = "red")
lines(x = HPC_sub$Date_Time, y = HPC_sub$Sub_metering_3, col = "blue")
axis(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), labels = c("Thu","Fri","Sat"), cex.axis = 1)
#Add a legend
legend("topright", legend = colnames(HPC_sub)[7:9], col = c("black", "red", "blue"), lty = 1, cex=1)
#Export the figure to wd
dev.copy(png, file="plot3.png")  
dev.off() 