figure (1)
x=2:20;
plot(x,Y2(1,2:end),'-ko',x,Y4(1,2:end),'--b*',x,Y6(1,2:end),'-r^','LineWidth',1); %
set(gca,'XTick',2:1:22)
%set(gca,'YTick',0:0.05:1)

xlabel('Number of clusters')
%ylabel('Mean Silhouette value')
%ylabel('Mean Dunn Index value')
ylabel('Mean Davies-Bouldin Index value')
legend('NYISO','ANEM','IESO',0)