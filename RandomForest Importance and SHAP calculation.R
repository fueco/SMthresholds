#############RandomForest Importance and SHAP calculation
library(randomForest)
library(rhdf5)
library(iml)
mydata=read.csv("/home/surface3/zfu/threshold/driver.csv")
model <- randomForest(theta ~ Sand+LAI+WoodD+SLA+LeafN+
                        Rad+VPD+AI+Rplant+Cfvo+Pfreq,data=mydata,nodesize=4,ntree = 1500,importance=TRUE)
saveRDS(model, "rfmodel11.rds")
#r2=median(model$rsq)
data_for_shap=mydata
predictor<-Predictor$new(model,data=data_for_shap[,2:12],y=data_for_shap[,1])###

shapley_result<-matrix(data=NA,nrow=length(mydata[,1]),ncol=11)	
for (i in 1:length(mydata[,1]))
{
  shapley <- Shapley$new(predictor, x.interest = data_for_shap[i,2:12])
  shapley_result[i,]<-shapley$results$phi[1:11]  
}
write.csv(shapley_result,'shapley_result.csv')