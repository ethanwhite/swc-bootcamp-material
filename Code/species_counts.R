
args <- commandArgs(trailingOnly = TRUE)
data <- read.table(args[1],sep=" ")
colnames(data) <- c("date","species","count")
results <- as.matrix(invisible(tapply(data$count,data$species,sum)))
results <-write.table(results,col.names=F, quote=F)
cat(results)
