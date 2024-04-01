############# RandomForest recursive feature elimination (RFE) analysis
library(randomForest)
library(rhdf5)
mydata=read.csv("/home/surface3/zfu/threshold/drivers.csv")
mydata1=mydata
nvar=35-3
rmvar = matrix(, nrow = nvar, ncol = 1)
mydata2<-mydata1
for (i in 1:nvar) {
  model <- randomForest(theta ~.,data=mydata2,nodesize=4,ntree = 1500,importance=TRUE)
  test<-data.frame(IMP=importance(model)[,1])
  mydata2<-mydata2[,-(which.min(test$IMP)+1)]
  rmvar[nvar+1-i,1]=rownames(test)[which.min(test$IMP)]
  i
}
r2=median(model$rsq)
three=data.frame(rownames(test))
a = data.frame(mydata1[, rmvar[1, 1]])
names(a) <- c(rmvar[1, 1])
mydata2 <- cbind(mydata2, a)

for (j in 1:(nvar-1)) {
  a = data.frame(mydata1[, rmvar[j+1, 1]])
  names(a) <- c(rmvar[j+1, 1])
  mydata3 <- cbind(mydata2, a)
  model <-randomForest(theta_IB ~.,data=mydata3,nodesize=4,ntree = 1500,importance=TRUE)
  if (median(model$rsq) - r2 < 0.005) {
    mydata3 <- mydata3[,-ncol(mydata3)]
  } else{
    r2 = median(model$rsq)
    mydata2=mydata3
  }
} 
finnaldriver=names(mydata3)

datalist = list(mydata3=mydata3, three=three, rmvar=rmvar,r2=r2,finnaldriver=finnaldriver)
saveRDS(datalist, "/home/surface3/zfu/threshold/driver/driver1.rds")

