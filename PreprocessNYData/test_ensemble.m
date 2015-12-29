load('PDAY1_NY.mat')
load('PDAY2_NY.mat')
load('PDAY3_NY.mat')
load('PDAY4_NY.mat')
serNum=datenum(dates)';
startDate=datenum('2011-01-05');
endDate=datenum('2012-01-05');
iStart=find(serNum==startDate);
iEnd=find(serNum==endDate);
ACTUAL=D(iStart:iEnd,:);
ensRes=[]
weights1=[]
PDAY_ENS=[]
ERR_ENS=[]
n=4;
w=ones(4,1)/n;
TEST_SET=[]
TEST_ERRORS=[]
for day=1:30

i=1
A=PDAY1(day,:);
B=PDAY2(day,:);
C=PDAY3(day,:);
D1=PDAY4(day,:);
res=A*w(1)+B*w(2)+C*w(3)+D1*w(4);
banana = @(w)(100/size(ACTUAL(day,:),2))*sum(abs((A*w(1)+B*w(2)+C*w(3)+D1*w(4))-ACTUAL(day,:))/mean(ACTUAL(day,:)));
[w,fval] = fminsearch(banana,[1/4, 1/4, 1/4, 1/4]);
finalOutput=A*w(1)+B*w(2)+C*w(3)+D1*w(4);
y=ACTUAL(day,:);
yhat=finalOutput;
mre=MRE(y,yhat);
mse=MSE(y,yhat);

sigmamre=sigmaMRE(y,yhat);

TEST_ERRORS=[TEST_ERRORS,;mre mse sigmamre]
TEST_SET=[TEST_SET;finalOutput];
weights1=[weights1;w];
end

for day=31:366
w=mean(weights1)
A=PDAY1(day,:);
B=PDAY2(day,:);
C=PDAY3(day,:);
D1=PDAY4(day,:);
finalOutput=A*w(1)+B*w(2)+C*w(3)+D1*w(4);
weights1=[weights1;w]
y=ACTUAL(day,:);
yhat=finalOutput;
mre=MRE(y,yhat);
mse=MSE(y,yhat);
sigmamre=sigmaMRE(y,yhat);

ERR_ENS=[ERR_ENS;mre mse sigmamre]
PDAY_ENS=[PDAY_ENS;finalOutput]
end
ERR_ENS=[TEST_ERRORS; ERR_ENS]
PDAY_ENS=[TEST_SET;PDAY_ENS]


day=191%176
x=1:24

%%%%%%%%%%%%%%%%%%%%%%%%%%%% denormalization
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


plot(x,ACTUAL(day,:),'-r*',x,normPDAY_ENS(day,:),'-ko',x,normPDAY1(day,:),'-g^',x,normPDAY2(day,:),'-mv',x,normPDAY3(day,:),'--y+',x,normPDAY4(day,:),'--bs')
legend('actual','ensemble','kmeans','SOM','RBF',0)
title( datestr(startDate+day))
y=ACTUAL(day,:);
yhat=normPDAY_ENS(day,:);
mre=MRE(y,yhat);
mse=MSE(y,yhat);
sigmamre=sigmaMRE(y,yhat);

mre1=MRE(y,normPDAY1(day,:));
mse1=MSE(y,normPDAY1(day,:));
sigmamre1=sigmaMRE(y,normPDAY1(day,:));

mre2=MRE(y,normPDAY2(day,:));
mse2=MSE(y,normPDAY2(day,:));
sigmamre2=sigmaMRE(y,normPDAY2(day,:));

mre3=MRE(y,normPDAY3(day,:));
mse3=MSE(y,normPDAY3(day,:));
sigmamre3=sigmaMRE(y,normPDAY3(day,:));

mre4=MRE(y,normPDAY4(day,:));
mse4=MSE(y,normPDAY4(day,:));
sigmamre4=sigmaMRE(y,normPDAY4(day,:));

name1=['ensemble   ' num2str(round(mre*1000)/1000)]
name2=['kmeans      ' num2str(round(mre1*1000)/1000)]
name3=['SOM          ' num2str(round(mre2*1000)/1000)]
name4=['RBF           ' num2str(round(mre3*1000)/1000)]
name5=['Hierarcical    ' num2str(round(mre4*1000)/1000)]
legend('actual',name1,name2,name3,name4,name5,0)
set(gca,'XTick',0:1:25)
xlabel('hours')
%ylabel('load, MW')
ylabel('price LBMP, ($/MWHr)')


