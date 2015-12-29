% load('Data\NYPriceData\dataPriceNY24.mat')
% load('Data\NYPriceData\datesPriceNY24.mat')

%dataset=1%'ANEM_Load'
dataset=2%'ANEM_Price'
%dataset=3%NYISO_Load
preD=priceDataAust24;%loadDataNY24;%priceDataOntario24;%dataPriceNY24;dataPriceNY24;
D=zeros(size(preD,1),size(preD,2));


for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end

%serIalizedDates=datenum(dates);

PriceMeanErr={}
%not normalized data, type: preD=your own dataset


Training=D(1:365,:);
Testing=D(366:367,:);%95,:);


newD=[Training;Testing];
meanErr=[]
iStart=size(Training,1)+1;
iEnd=size(newD,1);

All_MRE_kmeans=zeros(25,20);
All_MAPE_kmeans=zeros(25,20);
%All_MRE_som=zeros(25,20);
%All_MAPE_som=zeros(25,20);
All_MRE_hier=zeros(25,20);
All_MAPE_hier=zeros(25,20);
All_MRE_fuzzy=zeros(25,20);
All_MAPE_fuzzy=zeros(25,20);
All_MRE_kmed=zeros(25,20);
All_MAPE_kmed=zeros(25,20);
for NUMBER_OF_CLUSTERS=2:21;
    NUMBER_OF_CLUSTERS
    predictedResults={};
    for SIZE_OF_WINDOW=2:26
        SIZE_OF_WINDOW
        ERR1=[];
        %ERR2=[];
        ERR3=[];
        ERR4=[];
        ERR5=[];
        
        for predDate=iStart:iEnd
            pDateIndex=predDate;%find(datenum(dates)==predDate)

            initialSOW=SIZE_OF_WINDOW;
    
            [mre1 mape1 pDay1]=predictKMeans1(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
            %[mre2 mape2 pDay2]=predictSOM1(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
            [mre3 mape3 pDay3]=predictHierarchical(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
            [mre4 mape4 pDay4]=predictFuzzy(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
            [mre5 mape5 pDay5]=predictKMedoids(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
            norm=sum(preD(pDateIndex,:));
            mae1=MAE(preD(pDateIndex,:),pDay1*norm);
            %mae2=MAE(preD(pDateIndex,:),pDay2*norm);
            mae3=MAE(preD(pDateIndex,:),pDay3*norm);
            mae4=MAE(preD(pDateIndex,:),pDay4*norm);
            mae5=MAE(preD(pDateIndex,:),pDay5*norm);
            
            ERR1=[ERR1;mre1 mape1 mae1];
            %ERR2=[ERR2;mre2 mape2 mae2];
            ERR3=[ERR3;mre3 mape3 mae3];
            ERR4=[ERR4;mre4 mape4 mae4];
            ERR5=[ERR5;mre5 mape5 mae5];
        end

        All_MRE_kmeans(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR1(:,1));
        All_MAPE_kmeans(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR1(:,2));
        All_MAE_kmeans(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR1(:,3));
%         All_MRE_som(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR2(:,1));
%         All_MAPE_som(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR2(:,2));
%         All_MAE_som(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR2(:,3));
        All_MRE_hier(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR3(:,1));
        All_MAPE_hier(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR3(:,2));
        All_MAE_hier(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR3(:,3));
        All_MRE_fuzzy(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR4(:,1));
        All_MAPE_fuzzy(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR4(:,2));
        All_MAE_fuzzy(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR4(:,3));
        All_MRE_kmed(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR5(:,1));
        All_MAPE_kmed(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR5(:,2));
        All_MAE_kmed(NUMBER_OF_CLUSTERS,SIZE_OF_WINDOW)=mean(ERR5(:,3));
    end
end

AustPriceErrors={All_MRE_kmeans,All_MAPE_kmeans,All_MAE_kmeans,...
    %All_MRE_som,All_MAPE_som,All_MAE_som,...
    All_MRE_hier,All_MAPE_hier,All_MAE_hier,...
    All_MRE_fuzzy,All_MAPE_fuzzy,All_MAE_fuzzy,...
    All_MRE_kmed,All_MAPE_kmed,All_MAE_kmed}
save 'AustPriceErrors.mat'  AustPriceErrors
% [minA,ind] = min(All_MRE_kmeans(2:21,2:26));
% [m,n] = ind2sub(size(All_MRE_kmeans),ind)

