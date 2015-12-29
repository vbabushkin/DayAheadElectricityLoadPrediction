function [mre2 pDay2]=predictSOM(D,predDate,optimalSOW,dates)
    pDateIndex=find(datenum(dates)==predDate);
    initialSOW=optimalSOW;

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
        beforePredDay=IDX(end-optimalSOW+1:end);
        for i=1:size(IDX,1)-optimalSOW
            win=IDX(i:i + optimalSOW - 1, :);
            equalIndexes=(win==beforePredDay);
            remainingWinSize=size(beforePredDay,2)-round(threshold);
            if sum(equalIndexes)/size(beforePredDay,1)>=threshold
                weight=sum(equalIndexes)./size(beforePredDay,1);
                daysWithSimilarPattern=[daysWithSimilarPattern;weight*D(i + optimalSOW ,:)];
            else
                continue;
            end
        end
        optimalSOW=optimalSOW-1
    end
    if size(daysWithSimilarPattern,1)==1
        pDay2=daysWithSimilarPattern;
    else
        %pDay=trimmean(daysWithSimilarPattern,20)
        pDay2=mean(daysWithSimilarPattern)
    end
    y=D(pDateIndex,:);
    yhat=pDay2;
    mre2=MRE(y,yhat)
    mse2=MSE(y,yhat)
    sigmamre2=sigmaMRE(y,yhat)
    
end