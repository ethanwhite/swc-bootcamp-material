# Count the number of individuals of each species in a data file
#
# Input file format:
#
# 2013-03-22 bluejay 5
# 2013-03-22 mallard 9
# 2013-03-21 robin 1
# 2013-03-20 robin 30
#
# columns are separated by spaces.


### Read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
### Read in data from file set in the command line
data <- read.table(args[1],sep=" ")
### give column names to the data, don't have have to do this, but makes it more meaningful in the code
colnames(data) <- c("date","species","count")
### Sume the counts for each species with tapply()
### invisible() removes a NULL that will otherwise be printed in the console.
### as.matrix() just creates a matrix where row names are species names to mimic the python output
results <- as.matrix(invisible(tapply(data$count,data$species,sum)))
### Strip out the default column headers for easy console output, otherwise you get "[1]" as the first line
results <-write.table(results,col.names=F, quote=F)
### Print results to the console.
cat(results)
