
library(XML)
url<-download.file ("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile = "./balt.xml", method="curl")

doc<-xmlTreeParse("./balt.xml", useInternal=T)
rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[1]

zips <- xpathSApply(doc, "//row/zipcode", xmlValue)
zip<-subset(zips,zips==21231)

library(data.table)

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(url, destfile="./idaho.csv", method="curl")

DT<-fread("idaho.csv")
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

; mean(DT[DT$SEX==2,]$pwgtp15))
