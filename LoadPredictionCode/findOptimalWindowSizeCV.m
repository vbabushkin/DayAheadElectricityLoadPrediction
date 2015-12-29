% load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\Australian Dataset\datesAust24.mat')
% load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\Australian Dataset\priceDataAust24.mat')

% load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\NYPriceData\dataPriceNY24.mat')
% load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\NYPriceData\datesPriceNY24.mat')

serNum=datenum(dates);
MErrAustralianLoad={}
%not normalized data, type: preD=your own dataset
preD=loadDataNY24;%priceDataAust24;
%preD=loadDataNY24;
NUMBER_OF_CLUSTERS=3;


D=zeros(size(preD,1),size(preD,2)); %normalized data


for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end

currentSet=D;

D=D(1:365,:);
dates=dates(1:365,:);

for M=1:12
    ind=find(month(datenum(dates(end-364:end,:)))==M);% & year(datenum(dates(1:731,:)))==2008);
    Testing=currentSet(ind,:); %%% one month long dataset
    %Training=currentSet(ind(1)-365:ind(end)-365,:);%11 months long dataset
    if M<12
        Training=[currentSet(1:ind(1)-1,:);currentSet(ind(end)+1:end,:)];%11 months long dataset
    else
        Training=currentSet(1:ind(1)-1,:);
    end

    newD=[Training;Testing];
    meanErr=[]
    iStart=size(Training,1)+1;
    iEnd=size(newD,1);
    for SIZE_OF_WINDOW=2:15
        ERR1=[]
        PDAY1=[]
        for predDate=iStart:iEnd
            pDateIndex=predDate;%find(datenum(dates)==predDate)

            initialSOW=SIZE_OF_WINDOW;
    
            [mre1 mape1 pDay1]=predictKMeans1(newD,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS);
            norm=sum(preD(pDateIndex,:));
            mae1=MAE(preD(pDateIndex,:),pDay1*norm);
            ERR1=[ERR1;mre1 mae1 mape1];
            %PDAY1=[PDAY1;pDay1];
        end
    meanErr=[meanErr;mean(ERR1)]
    end
    
    MErrAustralianLoad{M}=meanErr
end
results=[]
mreVals=[]
maeVals=[]
mapeVals=[]
for k=1:12
    mreVals=[mreVals,MErrAustralianLoad{k}(:,1)];
    maeVals=[maeVals,MErrAustralianLoad{k}(:,2)];
    mapeVals=[mapeVals,MErrAustralianLoad{k}(:,3)];
    
end
[val ind]=min(mean(mreVals'))




