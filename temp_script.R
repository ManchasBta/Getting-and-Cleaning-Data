### Split Data set by Activity and by Subject

meanAndstdev <- function(x=list){
  y <- c(mean(x, na.rm = TRUE), sd(x, na.rm = TRUE))
}



write.table(activity_data, "Activity_Data.csv", col.names=TRUE, sep=",")
                          
stdevByActivity <- lapply(split_activity, function(x) sd(as.numeric(unlist(x), na.rm = TRUE))
stdevBySubject <- lapply(as.numeric(unlist(split_subject)), function(x) sd(x, na.rm = TRUE))
