function res=MRE(Actual,Predicted) 
avgActual=mean(Actual);
res=(100/24)*sum(abs(Predicted-Actual)./avgActual);
end