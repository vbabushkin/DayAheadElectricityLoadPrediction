 
interval=1464; 
initial=163;%till 635
P=D(initial:initial+interval-1,:)';
T=D(initial+interval,:)';
net = newrb(P',T',0,6,1000,1);
start=initial+1;
finish=start+interval-1;
tST=D(start:finish,:)';
actual=D(finish+1,:);
predicted = sim(net,tST');
figure(1)
 scatter(T,predicted)
 
 figure(2)
 x=1:24
 plot(x,predicted,'ro-',x,actual,'b*-')
 y=actual;
yhat=predicted;
mre=MRE(y,yhat)
mse=MSE(y,yhat)
sigmamre=sigmaMRE(y,yhat)
str(1) = {sprintf('%s%f\n%s%f\n%s%f','MRE ',mre,'MSE ',mse','\sigmaMRE ', sigmamre)};
text(1, (max(y)-(max(y)-min(y))/10),str)
title(datestr(dates(interval+start,:)))
xlabel('hours')
ylabel('prices')
legend('predicted','actual',0)
%hold on
% plot(x,D(finish,:),'--k')
% 
% 
% results=[]
% 
% for initial=1:635
%     P=D(initial:initial+interval-1,:)';
%     T=D(initial+interval,:)';
%     net = newrb(P',T',0,6,1000,1);
%     start=initial+1;
%     finish=start+interval-1;
%     tST=D(start:finish,:)';
%     actual=D(finish+1,:);
%     predicted = sim(net,tST');
%     
%     
%     
%     
%     
%     y=actual;
%     yhat=predicted;
%     mre=MRE(y,yhat);
%     mse=MSE(y,yhat);
%     sigmamre=sigmaMRE(y,yhat);
%     results=[results; start mre mse sigmamre];
%     
% end
