function plotPredictedActual(predicted,predDate,dates,D, marker)
    pDateIndex=find(datenum(dates)==predDate);
    x=1:24;
    
    plot(x,predicted,marker,x,D(pDateIndex,:),'ro-')
   
    title(datestr(predDate));
    xlabel('hours');
    ylabel('prices');
   
end