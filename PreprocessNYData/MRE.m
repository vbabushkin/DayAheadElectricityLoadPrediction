function res=MRE(Actual,Predicted) 
avgActual=mean(Actual);
res=(100/size(Actual,2))*sum(abs(Predicted-Actual)./avgActual);
end