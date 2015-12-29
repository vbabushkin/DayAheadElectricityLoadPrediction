
meanMRE=[]
meanMSE=[]
meanSigmaMRE=[]
serNum=datenum(dates)';
startDate=datenum('2011-01-01');
endDate=datenum('2011-12-31');
iStart=find(serNum==startDate);
iEnd=find(serNum==endDate);
for i= iStart:1:iEnd
    predDate=serNum(i);
    threshold=0.9;
    findOptimalSOW;
    maxSOW=round(max(max(optSOW)))
    minSOW=round(min(min(optSOW)))
    currentMRE=[]
    currentMSE=[]
    currentSigmaMRE=[]
    for currentWin=minSOW:1:maxSOW
        SIZE_OF_WINDOW=currentWin;
        predict;
        currentMRE=[currentMRE;currentWin mre];
        currentMSE=[currentMSE;currentWin mse];
        currentSigmaMRE=[currentSigmaMRE;currentWin sigmamre];
    end
    minMRE=min(currentMRE)
    minMSE=min(currentMSE)
    minSigmaMRE=min(currentSigmaMRE)
    if size(minMRE,2)==1
        meanMRE=[meanMRE;currentMRE];
        meanMSE=[meanMSE;currentMSE];
        meanSigmaMRE=[meanSigmaMRE;currentSigmaMRE];
    else
        meanMRE=[meanMRE;minMRE ];
        meanMSE=[meanMSE;minMSE ];
        meanSigmaMRE=[meanSigmaMRE;minSigmaMRE];
    end
    
end




