############SM Threshold estimation 
library(readxl)
library(nlstools)
library(segmented)
library(rhdf5)
library(ggplot2)

sm <- h5read("/home/surface3/zfu/threshold/sm.mat","/sm")
dt <- h5read("/home/surface3/zfu/threshold/dt.mat","/dt")

result<-array(, c(720,1440,8))

for (i in 1:720){
  print(i)
  for (j in 1:1440){
    sw<-sm[i,j,];dlst<-dt[i,j,];
    if (length(na.omit(sw))<30|
        sd(sw,na.rm=TRUE)<0.03){
      next
    }else{
      test0<-data.frame(x=sw,y=dlst)
      test<-data.frame(na.omit(test0))
      o<-lm(y~1,test)
      xx<- -(test$x)
      o2<-try(segmented(o,seg.Z=~xx),silent=T)
      if(length(o2)==1){
        o3<-lm(y~x,test)
        result[i,j,3]=summary(o3)$coef[2]
        result[i,j,4]=summary(o3)$coef[4]
        result[i,j,7]=length(test[,1])
      }else{
        #summary(o2)
        a1=test$x;a2=test$y;
        result[i,j,1]=ifelse(length(summary(o2)$coef)==4,9999,
                             ifelse(-summary(o2)$psi[2]<quantile(test$x, probs = c(0.1))|
                                      -summary(o2)$psi[2]>quantile(test$x, probs = c(0.9))|
                                      -summary(o2)$psi[2]<0.01|-summary(o2)$psi[2]<1.96*summary(o2)$psi[3],
                                    9999,-summary(o2)$psi[2]))
      }
    }
  }
}
saveRDS(result,"/home/surface3/zfu/threshold/output.rds")
