rankall <- function(outcome, num = "best") {
        data1<-read.csv("outcome-of-care-measures.csv", colClasses ="character", na.strings = "Not Available")
        data2<-data1[, c(2, 7, 11, 17, 23)]
        data<-na.omit(data2)
        colnames(data) <- c("hospital", "state", "MI", "CHF", "PNA")
        outcomes<-c("heart attack","heart failure","pneumonia")
        if(!(is.element(outcome, outcomes))){stop("invalid outcome")}
        if(outcome == "heart attack"){data$dx<-data$MI}
        if(outcome == "heart failure"){data$dx<-data$CHF}
        if(outcome == "pneumonia"){data$dx<-data$PNA}
        sorted<-data[order(data$state,as.numeric(data$dx),data$hospital),]
        sorted$id<-NA
        ranks<-tapply(sorted$id,sorted$state,rank)
        rank<-unlist(ranks)
        ranked<-cbind(sorted,rank)
        if(num=="worst"){
                split<-split(ranked,ranked$state)
                split2<-lapply(split,subset,rank==max(rank))
                split3<-do.call(rbind, split2)
                split3[,1:2]
                
        }else if(num=="best"){
                best<-subset(ranked,ranked$rank==1)
                best[,1:2]
        }else {split<-split(ranked[,c(1,2,8)],ranked$state)
                get<-function(st){
                        if(is.element(num,st$rank)){
                                row<-subset(st,st$rank==num)
                        }else{
                                row<-data.frame(hospital=NA, state=st[1,2],rank=NA)
                        }
                }
               rows<-lapply(split,get)
               tab<-do.call(rbind,rows)
               tab[,1:2]
        }
                           
}
