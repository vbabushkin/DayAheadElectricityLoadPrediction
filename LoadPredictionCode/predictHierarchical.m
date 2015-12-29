function [mre3 mape3 pDay3]=predictHierarchical(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS)
    initialSOW=SIZE_OF_WINDOW;
    remainingDays =D(1:pDateIndex-1,:);
    Y = pdist(remainingDays,'correlation');
    Z = linkage(Y,'ward');
    IDX = cluster(Z,'maxclust',NUMBER_OF_CLUSTERS);
    daysWithSimilarPattern=[];
    flag=0;
    while (flag==0)
        beforePredDay=IDX(end-SIZE_OF_WINDOW+1:end);
    
        for i=1:size(IDX,1)-SIZE_OF_WINDOW
            win=IDX(i:i + SIZE_OF_WINDOW - 1, :);
            equalIndexes=(win==beforePredDay);
            if sum(equalIndexes)==SIZE_OF_WINDOW
                daysWithSimilarPattern=[daysWithSimilarPattern;D(i + SIZE_OF_WINDOW,:)];
            else
                continue;
            end 
        end
        if ~isempty(daysWithSimilarPattern)
            flag=1;
            if size(daysWithSimilarPattern,1)==1
                pDay3=daysWithSimilarPattern;
            else
                %pDay1=trimmean(daysWithSimilarPattern,10);
                pDay3=mean(daysWithSimilarPattern);
            end
            y=D(pDateIndex,:);
            yhat=pDay3;
            mre3=MRE(y,yhat);
            mape3=MAPE(y,yhat);
        else
            if (SIZE_OF_WINDOW ~=0)
                flag=0;
                SIZE_OF_WINDOW=SIZE_OF_WINDOW-1;
            else
                flag=1;
            end
        end
    end 
end







