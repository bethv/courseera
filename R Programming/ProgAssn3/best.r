best <- function(state, outcome){
        data1<-read.csv("outcome-of-care-measures.csv", colClasses ="character", na.strings = "Not Available")
      data2<-data1[, c(2, 7, 11, 17, 23)]
      data<-na.omit(data2)
      colnames(data) <- c("Hospital", "State", "MI", "CHF", "PNA")
      if(!(is.element(state, data$State))){stop("invalid state")}
      outcomes<-c("heart attack","heart failure","pneumonia")
      if(!(is.element(outcome, outcomes))){stop("invalid outcome")}
      if(outcome == "heart attack"){data$dx<-data$MI}
      if(outcome == "heart failure"){data$dx<-data$CHF}
      if(outcome == "pneumonia"){data$dx<-data$PNA}
      state.data<-subset(data, data$State==state)
      result<-state.data[order(as.numeric(state.data$dx),state.data$Hospital),]
print(result[1,1])
}

## Return hospital name in that state with lowest 30-day death
## rate