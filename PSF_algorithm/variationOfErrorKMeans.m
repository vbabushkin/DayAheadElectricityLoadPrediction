
currentMRE=[]
currentMSE=[]
currentSigmaMRE=[]
serNum=datenum(dates)';
startDate=datenum('2011-01-01');
endDate=datenum('2011-12-31');
iStart=find(serNum==startDate);
iEnd=find(serNum==endDate);
for i= iStart:1:iEnd
    i
    predDate=serNum(i);
    threshold=1;
    kMeans;
    y=D(pDateIndex,:);
    yhat=pDay;
    mre=MRE(y,yhat)
    mse=MSE(y,yhat)
    sigmamre=sigmaMRE(y,yhat)
 
       
        currentMRE=[currentMRE;predDate mre];
        currentMSE=[currentMSE;predDate mse];
        currentSigmaMRE=[currentSigmaMRE;predDate sigmamre];
   
  
    
end




