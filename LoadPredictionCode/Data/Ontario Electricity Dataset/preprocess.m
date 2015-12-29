%load by hand
load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\Ontario Electricity Dataset\rawOntarioLoad.mat')
load('C:\Users\Wild\Desktop\Electricity Price Prediction Program\Data\Ontario Electricity Dataset\rawOntarioPrices.mat')

priceDataOntario=rawOntarioPrices(40945:end,end);
datesOntario=rawOntarioPrices(40945:end,1);
loadDataOntario=rawOntarioLoad(40945:end,end);
priceDataOntario24=[];
datesOntario24=[];
loadDataOntario24=[];

for k=1:3893
   priceDataOntario24=[priceDataOntario24;priceDataOntario((k-1)*24+1:k*24)'];
   datesOntario24=[datesOntario24;datestr(datesOntario((k-1)*24+1))] ;
   loadDataOntario24=[loadDataOntario24;loadDataOntario((k-1)*24+1:k*24)'];
end

preD=loadDataOntario24;
%preD=loadDataNY24;
D=zeros(size(preD,1),size(preD,2));


for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end