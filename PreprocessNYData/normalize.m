serNum=datenum(dates)';
startDate=datenum('2011-01-05');
iStart=find(serNum==startDate);
normPDAY1=[]
ACTUAL=[]
for i=1:size(PDAY1,1)
    norm=sum(preD(iStart+i-1,:));
    ACTUAL=[ACTUAL;preD(iStart+i-1,:)];
    normPDAY1=[normPDAY1;PDAY1(i,:).*norm];
end

normPDAY2=[]

for i=1:size(PDAY2,1)
    norm=sum(preD(iStart+i-1,:));
    normPDAY2=[normPDAY2;PDAY2(i,:).*norm];
end
normPDAY3=[]
for i=1:size(PDAY3,1)
    norm=sum(preD(iStart+i-1,:));
    normPDAY3=[normPDAY3;PDAY3(i,:).*norm];
end
normPDAY4=[]
for i=1:size(PDAY4,1)
    norm=sum(preD(iStart+i-1,:));
    normPDAY4=[normPDAY4;PDAY4(i,:).*norm];
end
normPDAY_ENS=[]
for i=1:size(PDAY_ENS,1)
    norm=sum(preD(iStart+i-1,:));
    normPDAY_ENS=[normPDAY_ENS;PDAY_ENS(i,:).*norm];
end

day=145
plot(ACTUAL(day,:))
hold on
plot(normPDAY_ENS(day,:))
y=ACTUAL(day,:)
yhat=normPDAY_ENS(day,:)
mre=MRE(y,yhat)
mape=MAPE(y,yhat)
mae=MAE(y,yhat)
mse=MSE(y,yhat)
sigmamre=sigmaMRE(y,yhat)