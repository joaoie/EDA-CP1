
filename<-"household_power_consumption.txt"
x<-read.table(filename,sep=";",na.strings = "?",colClasses=c(rep("character",2),rep("numeric",7))skip=1)

##Extract column names from first line of file
ColNames<-read.table(filename,sep=";",nrows=1)

## assign names to table
names(x)<-as.vector(as.matrix(ColNames))
rm(ColNames)

## Subset only data from specific dates
mydata<-subset(x,Date=="1/2/2007" | Date=="2/2/2007")

## add column with date and time merged in POSIX
mydata<-cbind(mydata,paste(mydata$Date, mydata$Time,sep=" "))
names(mydata)[10]<-"DateTime"
mydata$DateTime<-as.POSIXct(mydata$DateTime,"%d/%m/%Y %H:%M:%S",tz = "GMT")


##Open PNG device for plot1 with specified dimensions
png(file="plot1.png",width=480,height=480)

## Create histogram of plot 1
hist(mydata$Global_active_power,col="RED",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()


##Open PNG device for plot2 with specified dimensions
png(file="plot2.png",width=480,height=480)
## Creates plot 2
plot(mydata$DateTime,mydata$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

##Open PNG device for plot3 with specified dimensions
png(file="plot3.png",width=480,height=480)

plot(mydata$DateTime,mydata$Sub_metering_1,type="l",col="BLACK",xlab="",ylab="Energy sub metering")
lines(mydata$DateTime,mydata$Sub_metering_2,type="l",col="RED")
lines(mydata$DateTime,mydata$Sub_metering_3,type="l",col="BLUE")
legend("topright",names(mydata)[7:9],lty=c(1,1,1),lwd=c(1,1,1),col=c("BLACK","RED","BLUE"),seg.len=2)
dev.off()

png(file="plot4.png",width=480,height=480)
par(mfrow = c(2, 2)) 
with(mydata, {
  plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power")
  plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage")
  plot(DateTime,Sub_metering_1,type="l",col="BLACK",xlab="",ylab="Energy sub metering")
  lines(DateTime,Sub_metering_2,type="l",col="RED")
  lines(DateTime,Sub_metering_3,type="l",col="BLUE")
  legend("topright",box.lty=0,names(mydata)[7:9],lty=c(1,1,1),lwd=c(1,1,1),col=c("BLACK","RED","BLUE"),seg.len=2)
  plot(DateTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})  
dev.off()
