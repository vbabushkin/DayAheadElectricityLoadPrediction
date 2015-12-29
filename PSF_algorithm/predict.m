

initialSOW=SIZE_OF_WINDOW

%predDate=datenum('2010-08-09');

pDateIndex=find(datenum(dates)==predDate);
%%%
%clustering with SOM

remainingDays =D(1:pDateIndex-1,:);

net = selforgmap(6)%here we insert number of clusters
net.trainParam.epochs = 1000;
net = train(net,remainingDays');
%view(net)
y = net(remainingDays');
classes = vec2ind(y);
IDX=classes';


daysWithSimilarPattern=[];
threshold=1%0.8;
weight=0;


sow=0;
while isempty(daysWithSimilarPattern)
   
    
    
beforePredDay=IDX(end-SIZE_OF_WINDOW+1:end);
for i=1:size(IDX,1)-SIZE_OF_WINDOW
    win=IDX(i:i + SIZE_OF_WINDOW - 1, :);
    
    
    equalIndexes=(win==beforePredDay);
    
    remainingWinSize=size(beforePredDay,2)-round(threshold);
    if sum(equalIndexes)/size(beforePredDay,1)>=threshold
        weight=sum(equalIndexes)./size(beforePredDay,1);  
        daysWithSimilarPattern=[daysWithSimilarPattern;weight*D(i + SIZE_OF_WINDOW ,:)];
    else
        continue;
    end
    
end

SIZE_OF_WINDOW=SIZE_OF_WINDOW-1
end

if size(daysWithSimilarPattern,1)==1
    pDay=daysWithSimilarPattern;
else
    %pDay=trimmean(daysWithSimilarPattern,20)
    pDay=mean(daysWithSimilarPattern)
end

y=D(pDateIndex,:);
yhat=pDay;
mre=MRE(y,yhat)
mse=MSE(y,yhat)
sigmamre=sigmaMRE(y,yhat)





