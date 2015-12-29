%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% k means
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SIZE_OF_WINDOW=5
initialSOW=SIZE_OF_WINDOW
predDate=datenum('12-Apr-2012');
pDateIndex=find(datenum(dates)==predDate);
NUMBER_OF_CLUSTERS=5
[mre1 pDay1]=predictKMeans(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SOM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold=0.9;

findOptimalSOW

%insert the optimal size of window
optimalSOW=optSOW(1,2);

[mre2 pDay2]=predictSOM(D,predDate,optimalSOW,dates)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       RBF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

interval=1464; 

[mre3 pDay3]=predictRBF(D,predDate,interval,dates);



figure(1)
plotPredictedActual(pDay1,predDate,dates,D,'--mv')
hold on
x=1:24;
plot(x,pDay2,'-.gs')
plot(x,pDay3,'-b*')
legend('k-means','actual','SOM','RBF',0);




allMRE=[mre1;mre2;mre3];
allPdays=[pDay1;pDay2;pDay3];

[val ind]=min(allMRE)
predictedDay=allPdays(ind,:);

figure (2)
plotPredictedActual(predictedDay,predDate,dates,D,'-*b')
legend('predicted','actual',0);
pDateIndex=find(datenum(dates)==predDate);
actual=D(pDateIndex,:);
y=actual;
yhat=predictedDay;
mre=MRE(y,yhat);
mse=MSE(y,yhat);
sigmamre=sigmaMRE(y,yhat);
str(1) = {sprintf('%s%f\n%s%f\n%s%f','MRE ',mre,'MSE ',mse','\sigmaMRE ', sigmamre)};
text(1, (max(y)-(max(y)-min(y))/10),str);