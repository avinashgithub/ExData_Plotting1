# Given the number of rows in the table is too large, let us divide it into
# two, process first half, clear the raw data from memory, and then
# repeat for the seond half. Had to do this due to memory shortage on my device.

power <- read.table(
    './exdata-data-household_power_consumption//household_power_consumption.txt', 
    header=T, sep=';', na.strings="?", nrow = 1000000)
power[,1] <- as.Date(power[,1], '%d/%m/%Y')

# Keep only the data we are interested in, and remove the rest
febSet <-  subset(power, power$Date == '2007-02-01'| power$Date == '2007-02-02')
rm(power)

# Now do the same for the second half of the file
power2 <- read.table(
    './exdata-data-household_power_consumption//household_power_consumption.txt', 
    header=T, sep=';', na.strings="?", skip = 1000000)
power2[,1] <- as.Date(power2[,1], '%d/%m/%Y')

febSet2 <- subset(power2, power2$Date == '2007-02-01'| power2$Date == '2007-02-02')
rm(power2)
febSet <- rbind(febSet, febSet2)

# Initialize appropriately
par(mfrow=c(1,1))
datetime<- as.POSIXct(paste(febSet$Date, febSet$Time))
febSet <- cbind(febSet, datetime)

# Plot 2
png('./ExData_Plotting1/plot2.png', width = 480, height=480, units='px')
plot(febSet$datetime, febSet$'Global_active_power', 
     ylab='Global Active Power (kilowatts)',
     type='l', xlab='')
dev.off()
