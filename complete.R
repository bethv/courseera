complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases

#create a list of the files
list<-list.files(directory, full.names=TRUE)

#create a function to calculate nobs
f1<-function(x){
  data<-read.csv(list[x])
  cases<-subset(data,data$nitrate!="" & data$sulfate!="")
  nrow(cases)
}

#apply f1 to id
nobs<-sapply(id,f1)

table<-as.data.frame(cbind(id,nobs))
print(table)
}