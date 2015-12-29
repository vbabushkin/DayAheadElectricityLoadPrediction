preD=priceDataOntario24;
for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end

Training=double(D(1:365,:));%1466
%Testing1=double(D(367:end,:));%1097

% for j=1:size(Training1)
%     TrainWeight(j)=((1/24)*sum(Training1(j,1:24)));
%     Training(j,1:24)=Training1(j,1:24)/TrainWeight(j);
% end
%{
for j=1:size(Testing1)
    TestWeight(j)=((1/24)*sum(Testing1(j,1:24)));
    Testing(j,1:24)=Testing1(j,1:24)/TestWeight(j);
end
%}
for i=2:20
     IDX = kmeans(Training,i);%,'emptyaction','singleton');
    
%     net = selforgmap(i)%here we insert number of clusters
%     net.trainParam.epochs = 100;
%     net.trainParam.showWindow = false;
%     net.trainParam.showCommandLine = false;
%     net = train(net,Training');
%     %view(net)
%     y = net(Training');
%     classes = vec2ind(y);
%     IDX=classes';
% %     


% 
%     dist = pdist(Training,'correlation');
%     Z = linkage(dist,'ward');
%     IDX = cluster(Z,'maxclust',i);

%     


%     IDX=kmedoids(Training',i);
%     IDX=IDX';
%     

%     [class,U,centres,error] =  FuzzyCMeans(Training,i);
%     IDX = class';
    
    
    silh3 = silhouette(Training,IDX,'sqeuclid');
    Y(i)=mean(silh3);
end

figure (1)
x=2:20;
plot1 = plot(x,Y(2:end),'LineWidth',2); %x,Y1,x,Y3,x,Y4,
set(plot1(1),'MarkerFaceColor',[1 0 0],'Marker','diamond','LineStyle',':',...
    'Color',[0 0 1],...
    'DisplayName','K-Means');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DUNN INDEX %%%%%%%%%%%%%%%%%%%%
distM=squareform(pdist(Training,'seuclidean'));

for i=2:20
    IDX = kmeans(Training,i);
    
%     net = selforgmap(i)%here we insert number of clusters
%     net.trainParam.epochs = 100;
%     net.trainParam.showWindow = false;
%     net.trainParam.showCommandLine = false;
%     net = train(net,Training');
%     %view(net)
%     y = net(Training');
%     classes = vec2ind(y);
%     IDX=classes';

    
%     dist = pdist(Training,'correlation');
%     Z = linkage(dist,'ward');
%     IDX = cluster(Z,'maxclust',i);
    
    
%     IDX=kmedoids(Training',i);
%     IDX=IDX';
    
    
%     [class,U,centres,error] =  FuzzyCMeans(Training,i);
%     IDX = class';
    

    
    
    
    
    
    dInd=dunns(i,distM,IDX);
    Y1(i)=mean(dInd);
end

figure (2)
x=2:20;
plot1 = plot(x,Y1(2:end),'LineWidth',2); %x,Y1,x,Y3,x,Y4,
set(plot1(1),'MarkerFaceColor',[1 0 0],'Marker','diamond','LineStyle',':',...
    'Color',[0 0 1],...
    'DisplayName','K-Means');




Re = 'seuclidean';

for i=2:20
    IDX = kmeans(Training,i);
    
%     net = selforgmap(i)%here we insert number of clusters
%     net.trainParam.epochs = 100;
%     net.trainParam.showWindow = false;
%     net.trainParam.showCommandLine = false;
%     net = train(net,Training');
%     %view(net)
%     y = net(Training');
%     classes = vec2ind(y);
%     IDX=classes';

    
%     dist = pdist(Training,'correlation');
%     Z = linkage(dist,'ward');
%     IDX = cluster(Z,'maxclust',i);
    
%     
%     IDX=kmedoids(Training',i);
%     IDX=IDX';
%     
%     
%     [class,U,centres,error] =  FuzzyCMeans(Training,i);
%     IDX = class';

    [DB,CH,KL,Han,st] = valid_internal_deviation(Training,IDX,Re);
    
    Y2(i)=mean(DB);
end

figure (3)
x=2:20;
plot1 = plot(x,Y2(2:end),'LineWidth',2); %x,Y1,x,Y3,x,Y4,
set(plot1(1),'MarkerFaceColor',[1 0 0],'Marker','diamond','LineStyle',':',...
    'Color',[0 0 1],...
    'DisplayName','K-Means');

% 
% 
% clear all
% close all
% fid = fopen('ProjectData.csv');
% VarNames = {'year' 'month' 'day' 'hour' 'price' };
% ds= dataset('file','ProjectData.csv', 'VarNames',VarNames,'Delimiter',',','ReadVarNames',false,'Format','%d%d%d%d%f');
% X = ds(1:end,1:end);
% i=1;
% size_of_window=3;
% while i~=35089 
%     for j=1:24
%         s=ceil(i/24);
%         D(s,j)=X(i,end);
%         i=i+1;
%     end
% end
% Training1=double(D(1:1096,:));
% %Testing1=double(D(367:end,:));%1097
% 
% for j=1:size(Training1)
%     TrainWeight(j)=((1/24)*sum(Training1(j,1:24)));
%     Training(j,1:24)=Training1(j,1:24)/TrainWeight(j);
% end
% %{
% for j=1:size(Testing1)
%     TestWeight(j)=((1/24)*sum(Testing1(j,1:24)));
%     Testing(j,1:24)=Testing1(j,1:24)/TestWeight(j);
% end
% %}
% for i=2:20
%     IDX = kmeans(Training,i);
%     silh3 = silhouette(Training,IDX);
%     Y(i)=mean(silh3);
% end
% 
% 
% for i=2:20
%     
%     IDX1 = kmedoids(Training',i);
%     IDX2=IDX1';
%     silh31 = silhouette(Training,IDX2);
%     Y1(i)=mean(silh31);
% end
% 
% %d = pdist(Training1,'mahalanobis');
% %Z = linkage(d);
% 
% for i=2:20
%     [class,U,centres,error] =  FuzzyCMeans(Training,i,1.7);
%     IDX3 = class';
%     %IDX3 = clusterdata(Z,'linkage','ward','savememory','on','maxclust',i);
%     silh32 = silhouette(Training(1:end,:),IDX3);
%     Y3(i)=mean(silh32);
% end
% 
% for i=2:20
% d = pdist(Training1,'mahalanobis');
% Z = linkage(d,'ward');
% IDX4 = cluster(Z,'maxclust',i);
% silh34 = silhouette(Training,IDX4);
% Y4(i)=mean(silh34);
% end
% 
% figure (1)
% x=1:20;
% plot1 = plot(x,Y,x,Y1,x,Y3,x,Y4,'LineWidth',2);
% set(plot1(1),'MarkerFaceColor',[1 0 0],'Marker','diamond','LineStyle',':',...
%     'Color',[0 0 1],...
%     'DisplayName','K-Means');
% set(plot1(2),'MarkerFaceColor',[0 1 1],'Marker','o','LineStyle','-.',...
%     'Color',[0 0.5 0],...
%     'DisplayName','K-Medoids');
% set(plot1(3),'MarkerFaceColor',[1 1 0],'Marker','v','Color',[1 0 0],...
%     'DisplayName','Fuzzy C-Means Clustering');
% set(plot1(4),'LineStyle','-.','Color',[0 0.75 0.75],...
%     'DisplayName','Hierarchical Clustering');
% 
% xlabel('Number of Cluster, K');
% ylabel('Mean Silhouette');
% legend('K-Means','K-Medoids','Fuzzy C-Means Clustering','Hierarchical Clustering');
% saveas(figure(1), 'hcforall.png')
% 
% figure (2)
% x=1:20;
% plot2 = plot(x,Y,x,Y1,x,Y3,'LineWidth',2);
% set(plot2(1),'MarkerFaceColor',[1 0 0],'Marker','diamond','LineStyle',':',...
%     'Color',[0 0 1],...
%     'DisplayName','K-Means');
% set(plot2(2),'MarkerFaceColor',[0 1 1],'Marker','o','LineStyle','-.',...
%     'Color',[0 0.5 0],...
%     'DisplayName','K-Medoids');
% set(plot2(3),'MarkerFaceColor',[1 1 0],'Marker','v','Color',[1 0 0],...
%     'DisplayName','Fuzzy C-Means Clustering');
% 
% xlabel('Number of Cluster, K');
% ylabel('Mean Silhouette');
% legend('K-Means','K-Medoids','Fuzzy C-Means Clustering');
% saveas(figure(2), 'kforall.png')
%     
