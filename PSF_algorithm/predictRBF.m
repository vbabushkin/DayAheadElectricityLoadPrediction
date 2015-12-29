function [mre3 pDay3]=predictRBF(D,predDate,interval,dates)
    pDateIndex=find(datenum(dates)==predDate);
    initial=pDateIndex-interval-1;%till 635
    P=D(initial:initial+interval-1,:)';
    T=D(initial+interval,:)';
    net = newrb(P',T',0,6,1000,1);
    start=initial+1;
    finish=start+interval-1;
    tST=D(start:finish,:)';
    actual=D(finish+1,:);
    pDay3 = sim(net,tST');
    y=D(pDateIndex,:);
    yhat=pDay3;
    mre3=MRE(y,yhat)
    mse3=MSE(y,yhat)
    sigmamre3=sigmaMRE(y,yhat)
end