
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


