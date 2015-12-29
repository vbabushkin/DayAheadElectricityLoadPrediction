function res=MAE(Actual,Predicted) 
res=(1/size(Actual,2))*sum(abs(Predicted-Actual));
end