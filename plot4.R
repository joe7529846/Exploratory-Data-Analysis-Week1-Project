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

#Plot4
#Add canvas
par(mfrow = c(2,2))
plot(HPC_sub$Global_active_power, type = "l", xlab = "", xaxt = "n", ylab = "Global Active Power")
axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), cex.axis = 1)
plot(HPC_sub$Voltage, type = "l", xlab = "datetime", xaxt = "n", ylab = "Voltage")
axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), cex.axis = 1)
matplot(HPC_sub[,7:9], type = "l", xaxt = "n", ylab = "Energy sub metering", col = c("black", "red", "blue"), lty = 1)
axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), cex.axis = 1)
legend("topright", legend = colnames(HPC_sub)[7:9], col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.8)
plot(HPC_sub$Global_reactive_power, type = "l", xlab = "datetime", xaxt = "n", ylab = "Global_reactive_power")
axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), cex.axis = 1)
#Export the figure to wd
dev.copy(png, file="plot4.png") 
dev.off() 