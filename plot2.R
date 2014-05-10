require(data.table)
DT<- fread(input="household_power_consumption.txt",sep= ";",header= TRUE,na.strings="?",select=c(1,2,3),colClasses = "?")
DT$Date<- as.Date(DT$Date,"%d/%m/%Y")

Q<- subset(DT,  DT$Date =="2007-02-01" | DT$Date =="2007-02-02")
Q$DateTime<-as.POSIXct(paste(Q$Date,Q$Time), format="%Y-%m-%d %H:%M:%S")

Q$Global_active_power <- sapply(Q$Global_active_power,as.numeric)
plot(y = Q$Global_active_power,x=Q$DateTime, type= "l" ,ylab="Global Active Power (kilowatts)",xlab ="")
dev.print(png,file="plot2.png",width=480,height=480)
dev.off()