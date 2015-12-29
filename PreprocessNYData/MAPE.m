function res=MAPE(Actual,Predicted) 
res=(100/size(Actual,2))*sum(abs((Predicted-Actual)./Actual));
end