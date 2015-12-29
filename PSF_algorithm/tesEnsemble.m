totalMRE=[]
totalPdays=[]
serNum=datenum(dates)';
startDate=datenum('2011-01-05');
endDate=datenum('2012-01-05');
iStart=find(serNum==startDate);
iEnd=find(serNum==endDate);
for i= iStart:1:iEnd
    i
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% k means
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    SIZE_OF_WINDOW=5;
    initialSOW=SIZE_OF_WINDOW;
    predDate=datenum('12-Apr-2012');
    pDateIndex=find(datenum(dates)==predDate);
    NUMBER_OF_CLUSTERS=5;
    [mre1 pDay1]=predictKMeans(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS)




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% SOM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    threshold=0.9;

    findOptimalSOW;

    %insert the optimal size of window
    optimalSOW=optSOW(1,2);

    [mre2 pDay2]=predictSOM(D,predDate,optimalSOW,dates);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%       RBF
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    interval=1464; 

    [mre3 pDay3]=predictRBF(D,predDate,interval,dates);


    totalMRE=[totalMRE;mre1 mre2 mre3];
    totalPdays=[totalPdays;pDay1 pDay2 pDay3];
    
    
end