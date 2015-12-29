% load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\Australian Dataset\datesAust24.mat')
% load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\Australian Dataset\priceDataAust24.mat')

load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\NYPriceData\dataPriceNY24.mat')
load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\NYPriceData\datesPriceNY24.mat')

serNum=datenum(dates);
MErrAustralianPrice={}
%not normalized data, type: preD=your own dataset
preD=dataPriceNY24;%priceDataAust24;
NUMBER_OF_CLUSTERS=5;


D=zeros(size(preD,1),size(preD,2)); %normalized data


for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end

currentSet=D;



for M=1:12
    ind=find(month(datenum(dates(end-365:end,:)))==M);% & year(datenum(dates(1:731,:)))==2008);
    Testing=currentSet(ind,:); %%% one month long dataset
    %Training=currentSet(ind(1)-365:ind(end)-365,:);%11 months long dataset
    if M<12
        Training=[currentSet(1:ind(1)-1,:);currentSet(ind(end)+1:end,:)];%11 months long dataset
    else
        Training=currentSet(1:ind(1)-1,:);
    end
    threshold=1

    newD=[Training;Testing];
    meanErr=[]
    iStart=size(Training,1)+1;
    iEnd=size(newD,1);
    for SIZE_OF_WINDOW=2:20
        ERR1=[]
        PDAY1=[]
        for predDate=iStart:iEnd
            pDateIndex=predDate;%find(datenum(dates)==predDate)

            initialSOW=SIZE_OF_WINDOW;
    
            [mre1 mae1 mape1 pDay1]=predictKMeans(newD,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS, threshold);
    
            ERR1=[ERR1;mre1 mae1 mape1];
            %PDAY1=[PDAY1;pDay1];
        end
    meanErr=[meanErr;nanmean(ERR1)]
    end
    
    MErrAustralianPrice{M}=meanErr
end
results=zeros(12,19)
for k=1:12
    results(k,:)=[MErrAustralianPrice{k}(:,1)]';
end
mean(results)