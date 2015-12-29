function res=sigma(Actual,Predicted) 
avgActual=mean(Actual);
eh=(Predicted-Actual)/avgActual;
e=mean(eh);
res=sqrt(mean((eh-e).^2));

end