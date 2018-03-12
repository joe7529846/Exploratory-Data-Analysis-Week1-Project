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



#Plot2
plot(x = HPC_sub$Date_Time , 
     y = HPC_sub$Global_active_power, 
     type = "l", 
     xlab = "", 
     xaxt = "n",
     ylab = "Global Active Power (killwatts)")

axis(side=1, 
     at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), 
     labels = c("Thu","Fri","Sat"), 
     cex.axis = 1)#Adjust the scale text size
#Export the figure to wd
dev.copy(png, file="plot2.png")  
dev.off() 