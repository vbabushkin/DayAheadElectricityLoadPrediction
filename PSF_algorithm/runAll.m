clear all
close all
preprocessData


%prediction for date
predDate=datenum('2011-02-05');
%threshold value
threshold=0.9;

findOptimalSOW

%insert the optimal size of window
SIZE_OF_WINDOW=2

predict
plotResults