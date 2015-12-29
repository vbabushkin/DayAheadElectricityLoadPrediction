function [mre2 mape2 pDay2]=predictSOM1(D,pDateIndex,SIZE_OF_WINDOW,NUMBER_OF_CLUSTERS)
    initialSOW=SIZE_OF_WINDOW;
    remainingDays =D(1:pDateIndex-1,:);
    net = selforgmap(NUMBER_OF_CLUSTERS)%here we insert number of clusters
    net.trainParam.epochs = 100;
    net.trainParam.showWindow = false;
    net.trainParam.showCommandLine = false;
    net = train(net,remainingDays');
    %view(net)
    y = net(remainingDays');
    classes = vec2ind(y);
    IDX=classes';
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
                pDay2=daysWithSimilarPattern;
            else
                %pDay1=trimmean(daysWithSimilarPattern,10);
                pDay2=mean(daysWithSimilarPattern);
            end
            y=D(pDateIndex,:);
            yhat=pDay2;
            mre2=MRE(y,yhat);
            mape2=MAPE(y,yhat);
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

 