%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preprocess and denormalize Australian Data from Jan 01 2007 to Nov 30 2012
%% and form 185 X 24 matrices of price and load
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all 
loadDataAust=[]
priceDataAust=[]
datesAust=[]
% 

for year=2007:1:2012
    if year==2012
        lastMonth=11;
    else
        lastMonth=12;
    end
for k=1:1:lastMonth
    if k<10
       name=['DATA', num2str(year), '0', num2str(k),'_NSW1.csv']
    else
        name=['DATA',num2str(year), num2str(k),'_NSW1.csv']
    end
    fid = fopen(name, 'rt');

    preData = textscan(fid, '%s %s %f %f %s ','Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);
    fclose(fid);

    format short g
    M = datevec(preData{1}(:,2));
    ind=find(M(:,5)==0);
    datesM=M(ind,:);
    M1= preData{2};
    priceAndLoad=M1(ind,:);
    loadDataAust=[loadDataAust;priceAndLoad(:,1)];
    datesAust=[datesAust;datestr(datesM)];
    priceDataAust=[priceDataAust;priceAndLoad(:,2)];
end



end
save loadDataAust.mat loadDataAust
save datesAust.mat datesAust
save priceDataAust.mat priceDataAust


% preD=flipdim(loadDataAust,1);
% dates=flipdim(datesAust,1);
% 

% % % %FOR PRICE CREATE MATRIX num_of_days X 24
priceDataAust24=[];
datesAust24=[];
loadDataAust24=[];
for k=1:2161
   priceDataAust24=[priceDataAust24;priceDataAust((k-1)*24+1:k*24)'];
   %datesAust24=[datesAust24;datesAust((k-1)*24+1,1:11)] ;
   loadDataAust24=[loadDataAust24;loadDataAust((k-1)*24+1:k*24)'];
end
dates=datesAust24;
preD=priceDataAust24;
save priceDataAust24.mat priceDataAust24
save loadDataAust24.mat loadDataAust24
save datesAust24.mat dates
% % % %FOR LOAD
preD=loadDataAust24;
%preD=loadDataNY24;
D=zeros(size(preD,1),size(preD,2));


for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end