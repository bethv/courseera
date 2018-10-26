corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations

#create a list of the files
list<-lapply(list.files(directory, full.names=TRUE),read.csv)

#create a function to calculate nobs
f1<-function(x){
  data<-as.data.frame(list[x])
  cases<-subset(data,data$nitrate!="" & data$sulfate!="")
 nrow(cases)
}

#apply f1 to files in list
  nobs<-sapply(1:length(list),f1)

# make into dataframe
id<-(1:length(list))
table<-as.data.frame(cbind(id,nobs))

# subset nobs > threshold
subset<-subset(table,table$nobs>=threshold)

#id2 is vector of ids with nobs > thresh
id2<-subset$id

#function to get pearson r's
f2<-function(x){
  #create matrix of nit, sulf, complete cases
  data<-as.data.frame(list[x])
  cases<-subset(data,data$nitrate!="" & data$sulfate!="")
  matrix<-cbind(cases$nitrate,cases$sulfate)
  cor(matrix)[1,2]
}

#apply f2 to id2
correlations<-sapply(id2,f2)
}