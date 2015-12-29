% clear all
% close all 
% currentDayLoad=[]
% currentDayDate=[]
% 

name='OASIS_Real_Time_Dispatch_Zonal_LBMP2007.csv'
fid = fopen(name, 'rt');
%fid = fopen('data.csv', 'rt');
preData = textscan(fid, '%s %s %d %f %f %f %d','Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);
fclose(fid);

%then import it by hand

% PriceData=[PriceData; untitled(2:end-1,:)];
% for k=31:-1:1
%     if k<10
%        name=['2007010', num2str(k),'palIntegrated.csv']
%     else
%         name=['200701', num2str(k),'palIntegrated.csv']
%     end
% 
% 
% format short g
% M = [datevec(preData{1}(:,1)) preData{2}];
% M1= preData{3};
% areas=strcat(char(preData{1}(:,3)));
% captilAreas=[]
% ind=[]
% for i=1:size(areas,1)
%     if ~isempty(strfind(areas(i,:),'CAPITL'))
%         ind=[ind;i];
%         captilAreas=[captilAreas; areas(i,:)];
%     end
% end
% if(size(ind,1)>24)
%     ind=[ind(1);ind(3:end)];
% end
% if(size(ind,1)<24)
%     ind=[ind;244];
% end
% currentDayLoad=[currentDayLoad;M1(ind,1)']
% currentDayDate=[ currentDayDate;datestr(datenum(preData{1}(1)))];
% save LOAD_DATA.mat currentDayLoad
% save DATES.mat currentDayDate
% end
PriceData=[PriceData;untitled];

datesInVec=datevec(PriceData(:,1));
rawPriceData=[datesInVec, PriceData(:,4)];
tempPrice=[]
tempDates=[]
for year=2007:1:2012
   tempYearlyPrice=rawPriceData(rawPriceData(:,1)==year,:) ;
   for month=1:1:12
       tempMonthlyPrice=tempYearlyPrice(tempYearlyPrice(:,2)==month,:);
       days=unique( tempMonthlyPrice(:,3));
       for day=1:size(days,1)
           tempDayPrice=tempMonthlyPrice(tempMonthlyPrice(:,3)==day,:);
           [val, ind]=unique(tempDayPrice(:,4),'first');
           if size(ind,1)==24
               tempPrice=[tempPrice; tempDayPrice(ind,7)'];
           else
                x=1:23;
                a=ismember(x,val);
                zeroInd=find(a==0);
                xPrice=[tempDayPrice(ind,7);tempDayPrice(ind(end)+zeroInd,7)];
                tempPrice=[tempPrice;xPrice' ];
           end
           
           
           tempDates=[tempDates;datestr(datenum([year month day]))];
       end
   end
end

datesPriceNY24=tempDates;
dataPriceNY24=tempPrice;
save datesPriceNY24.mat datesPriceNY24
save dataPriceNY24.mat dataPriceNY24

%dates=datestr(PriceData(:,1));
preD=dataPriceNY24;
D=zeros(size(preD,1),size(preD,2));


for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end

save D_NY_PRICE.mat D