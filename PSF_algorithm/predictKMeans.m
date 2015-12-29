function [mre1 pDay1]=predictKMeans(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS)
    initialSOW=SIZE_OF_WINDOW
    remainingDays =D(1:pDateIndex-1,:);

    IDX=kmeans(remainingDays,NUMBER_OF_CLUSTERS);
 
    % Y = pdist(remainingDays,'cityblock');
    % Z = linkage(Y,'average');
    % 
    % IDX = cluster(Z,'cutoff',0.99)



    daysWithSimilarPattern=[];
    threshold=1%0.8;
    weight=0;


    sow=0;
    while isempty(daysWithSimilarPattern)& SIZE_OF_WINDOW>1
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
        pDay1=daysWithSimilarPattern;
    else
        %pDay=trimmean(daysWithSimilarPattern,20)
        pDay1=mean(daysWithSimilarPattern);
    end
    y=D(pDateIndex,:);
    yhat=pDay1;
    mre1=MRE(y,yhat)
    mse1=MSE(y,yhat)
    sigmamre1=sigmaMRE(y,yhat)
end







