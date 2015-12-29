optSOWprevDays=[];

for currentDate=datenum(predDate)-30:datenum(predDate)-1

    pDateIndex=find(datenum(dates)==currentDate);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%               clustering with SOM                   %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    remainingDays =D(1:pDateIndex-1,:);

    %  IDX=kmeans(Testing,NUMBER_OF_CLUSTERS);
    %  
    % Y = pdist(Testing,'cityblock');
    % Z = linkage(Y,'average');
    % 
    % IDX = cluster(Z,'cutoff',0.99)


    net = selforgmap(6)%here we insert number of clusters
    net.trainParam.epochs = 2000;
    net = train(net,remainingDays');
    %view(net)
    y = net(remainingDays');
    classes = vec2ind(y);
    IDX=classes';
    records=[]
    for j=2:55% j changes size of window

        SIZE_OF_WINDOW=j;
        daysWithSimilarPattern=[];
        
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
        SIZE_OF_WINDOW=SIZE_OF_WINDOW-1;
        end

        if size(daysWithSimilarPattern,1)==1
            pDay=daysWithSimilarPattern;
        else
            pDay=mean(daysWithSimilarPattern);
        end

        y=D(pDateIndex,:);
        yhat=pDay;
        mre=MRE(y,yhat);
        mse=MSE(y,yhat);
        sigmamre=sigmaMRE(y,yhat);

        records=[records; j mre mse sigmamre];

    end
    [minMRE indMRE]=min(records(:,2));
    [minMSE indMSE]=min(records(:,3));
    [minSMRE indSMRE]=min(records(:,4));
    optSOWprevDays=[optSOWprevDays;records(indMRE,1),records(indMSE,1),records(indSMRE,1)];
end
% plot(pDay,'-ro')
% hold on
% plot(D(pDateIndex,:),'-bx')
% 
% str(1) = {sprintf('%s%f\n%s%d','MRE ',mre,'MSE ',mse')};
% text(1, max(y),str)
% title(datestr(currentDate))
% legend('predicted','actual',0)

optSOW=[median(optSOWprevDays(:,1)) mode(optSOWprevDays(:,1)) mean(optSOWprevDays(:,1));
median(optSOWprevDays(:,2)) mode(optSOWprevDays(:,2)) mean(optSOWprevDays(:,2));
median(optSOWprevDays(:,3)) mode(optSOWprevDays(:,3)) mean(optSOWprevDays(:,3))]
