
norm=sum(preD(pDateIndex,:));
plot(pDay*norm,'-ro')
hold on
plot(D(pDateIndex,:)*norm,'-bx')
y=D(pDateIndex,:);
yhat=pDay;
mre=MRE(y,yhat)
mse=MSE(y,yhat)
sigmamre=sigmaMRE(y,yhat)
str(1) = {sprintf('%s%f\n%s%f\n%s%f\n%s%d','MRE ',mre,'MSE ',mse','\sigmaMRE ', sigmamre,'optimal SOW ',initialSOW)};
text(1, (max(y)-(max(y)-min(y))/10)*norm,str)
title(datestr(predDate))
xlabel('hours')
ylabel('prices')
legend('predicted','actual',0)