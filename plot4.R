require(data.table)
DT<- fread(input="household_power_consumption.txt",sep= ";",header= TRUE,na.strings="?",select=c(1,2,3,4,5,7,8,9),colClasses = "?")
DT$Date<- as.Date(DT$Date,"%d/%m/%Y")

par(mfrow=c(2,2))

Q<- subset(DT,  DT$Date =="2007-02-01" | DT$Date =="2007-02-02") 
Q$DateTime<-as.POSIXct(paste(Q$Date,Q$Time), format="%Y-%m-%d %H:%M:%S")

# Row 1 graph 1
Q$Global_active_power <- sapply(Q$Global_active_power,as.numeric)
plot(y = Q$Global_active_power,x=Q$DateTime, type= "l" ,ylab="Global Active Power",xlab ="")

# Row 1 graph 2 
Q$Voltage <- sapply(Q$Voltage,as.numeric)
plot(y = Q$Voltage,x=Q$DateTime, type= "l" ,ylab="Voltage",xlab ="")


#Row2  graph1

Q$Sub_metering_1 <- sapply(Q$Sub_metering_1,as.numeric)
Q$Sub_metering_2 <- sapply(Q$Sub_metering_2,as.numeric)
Q$Sub_metering_3 <- sapply(Q$Sub_metering_3,as.numeric)
plot_colors <- c("black","red","blue")


plot(y = Q$Sub_metering_1,x=Q$DateTime, col = plot_colors[1], type= "l" ,ylab="Energy sub metering",xlab ="")
lines(y = Q$Sub_metering_2,x=Q$DateTime, col = plot_colors[2])
lines(y = Q$Sub_metering_3,x=Q$DateTime, col = plot_colors[3])
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.4, col=plot_colors,lty=1)


#row2 graph2
Q$Global_reactive_power<- sapply(Q$Global_reactive_power,as.numeric)
plot(y = Q$Global_reactive_power,x=Q$DateTime, type= "l" ,ylab="Global_reactive_power",xlab ="")


dev.print(png,file="plot4.png",width=480,height=480)
dev.off()