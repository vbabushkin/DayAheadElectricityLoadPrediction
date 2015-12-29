
%preD=priceDataOntario24;%loadDataNY24;%priceDataOntario24;%
%preD=loadDataOntario24;
%preD=dataPriceNY24;
preD=priceDataAust24;
D=zeros(size(preD,1),size(preD,2));
dates=dates;
serNum=datenum(dates);
for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end



currentDate=datenum('27-Jan-2008');
pDateIndex=find(serNum(:,1)==currentDate);
SIZE_OF_WINDOW=6;
NUMBER_OF_CLUSTERS=4;
[mre1 mape1 pDay1]=predictKMeans1(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
[mre2 mape2 pDay2]=predictSOM1(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
[mre3 mape3 pDay3]=predictHierarchical(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
[mre4 mape4 pDay4]=predictFuzzy(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
[mre5 mape5 pDay5]=predictKMedoids(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
norm=sum(preD(pDateIndex,:));
mae1=MAE(preD(pDateIndex,:),pDay1*norm);
mae2=MAE(preD(pDateIndex,:),pDay2*norm);
mae3=MAE(preD(pDateIndex,:),pDay3*norm);
mae4=MAE(preD(pDateIndex,:),pDay4*norm);
mae5=MAE(preD(pDateIndex,:),pDay5*norm);
plot(pDay1,'--ks')
hold on
plot(pDay2,'-m+')
plot(pDay3,':b*')
plot(pDay4,'-yv')
plot(pDay5,'-g^')
plot(D(pDateIndex,:),'-ro')
legend('k-means','SOM','Hierarchical','Fuzzy c-means','k-medoids',0)

