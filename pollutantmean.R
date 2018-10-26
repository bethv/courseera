pollutantmean <- function(directory, pollutant, id = 1:332){
  #create a list of the files
  list<-list.files(directory, full.names=TRUE)
  subset<-list[id]
  tables<-lapply(subset,read.csv)
  
  # create empty dataframe
  data<-data.frame()
  
  #rbind files in tables to data
  for (i in 1:length(id)){
    data<-rbind(data,as.data.frame(tables[i]))
  }
  #calculate mean pollutant
 if(pollutant=="sulfate") {mean.pollutant<-mean(data$sulfate, na.rm=T)
 } 
 if(pollutant=="nitrate"){mean.pollutant<-(mean(data$nitrate, na.rm=T))
 } 
 print(mean.pollutant)
  
}