
##############################################################
## SECTION A - PREPARE DATA


###########
## STEP 1 - Calculate memory required

    2075259*9*8 # 2075259 rows x 9 columns x 8bytes/numeric


## Does your computer has enough memory?
## ANSWER: Per the calculation above, the memory required is 149418648 bytes or 149.418 MB.      
##         I am using a computer with 6GB memory, which is enough for this dataset.
     


###########
## STEP 2 - Manually download and view the dataset 
##        - Download link: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##        - Extract the file to your working directory. The name of the file is household_power_consumption.txt
##        - View the dataset to see its structure and properties (will need this info in read.table)



###########
## STEP 3 - Read the data from 2007-02-01 and 2007-02-02
##        - Per manual review of the dataset:
##        - - the rows containing 2007-02-01 data starts at row 66638 (skip 66637)
##        - - there are 2880 rows containing 2007-02-01 and 2007-02-02 data.


    ## Create a vector of colum names. Read first row, then "unlist" to convert from data frame to vector.
    ## This will be used as col.names when reading the real data

    pcDataColNames <- unlist(read.table("household_power_consumption.txt", sep=";", nrows=1))

    ## Read data for 2007-02-01 and 2007-02-02. 

    pcData <- read.table("household_power_consumption.txt", header=FALSE, col.names=pcDataColNames, sep=";", skip=66637, nrows=2880)



###########
## STEP 4 - Address missing values being recorded as ?

   ## Change all "?" in pcData to NA

   pcData[pcData == "?"] <- NA

   ## See if there's any NA in pcData. There's none. This matches my findings when I manually reviewed the dataset.  There are no "?" in Feb/1/2007 and Feb/2/2007 data.

   sum(is.na(pcData))


###########
## STEP 5 - Convert Date and Time variable to Date/Time class

   ## Convert Date to date format. 

   pcData$Date <- strptime(pcData$Date,"%e/%m/%Y")

   ## Convert time to time format. Combined time with date first, as without combining, it will use the current date.

   pcData$Time <- strptime(paste(pcData$Date," ",pcData$Time),"%F %H:%M:%S")




##############################################################
## SECTION B - CREATE THE PLOT


   png("plot3.png", bg="transparent") # open png graphic device. Set background to transparent.


## Plot Sub metering 1 (black)

   plot(pcData$Time,pcData$Sub_metering_1,
        pch=".",  # set character to a dot so that it would blend in with the line
        ylab="Energy sub metering", # set y label
        xlab="", # remove "Index" in x axis,
        bg="transparent" # set background colour to transparent
        )

   points(pcData$Sub_metering_1,col=rgb(1, 1, 1, 1), pch=".") # set colour and transparency to "1" so that the "." would not show in the plot

   lines(pcData$Time, pcData$Sub_metering_1, col="black") # add lines to the scatter plot so it would look like what's provided in the assignment


## Plot Sub metering 2 (red)

   points(pcData$Sub_metering_2,col=rgb(0, 1, 1, 1), pch=".") # set colour and transparency to "1" so that the "." would not show in the plot

   lines(pcData$Time, pcData$Sub_metering_2, col="red") # add lines to the scatter plot so it would look like what's provided in the assignment

## Plot Sub metering 3 (blue)

   points(pcData$Sub_metering_3,col=rgb(0, 1, 1, 1), pch=".") # set colour and transparency to "1" so that the "." would not show in the plot

   lines(pcData$Time, pcData$Sub_metering_3, col="blue") # add lines to the scatter plot so it would look like what's provided in the assignment


## Add legend
   legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lty=c(1,1,1))


   dev.off() # turn off graphic device




