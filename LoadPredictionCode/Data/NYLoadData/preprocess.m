% clear all
% close all 
% currentDayLoad=[]
% currentDayDate=[]
% 


for k=31:-1:1
    if k<10
       name=['2007010', num2str(k),'palIntegrated.csv']
    else
        name=['200701', num2str(k),'palIntegrated.csv']
    end
fid = fopen(name, 'rt');
%fid = fopen('data.csv', 'rt');
preData = textscan(fid, '%s %s %s %d %f ','Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);
fclose(fid);

format short g
M = [datevec(preData{1}(:,1)) preData{2}];
M1= preData{3};
areas=strcat(char(preData{1}(:,3)));
captilAreas=[]
ind=[]
for i=1:size(areas,1)
    if ~isempty(strfind(areas(i,:),'CAPITL'))
        ind=[ind;i];
        captilAreas=[captilAreas; areas(i,:)];
    end
end
if(size(ind,1)>24)
    ind=[ind(1);ind(3:end)];
end
if(size(ind,1)<24)
    ind=[ind;244];
end
currentDayLoad=[currentDayLoad;M1(ind,1)']
currentDayDate=[ currentDayDate;datestr(datenum(preData{1}(1)))];
save LOAD_DATA.mat currentDayLoad
save DATES.mat currentDayDate
end

% preD=flipdim(currentDayLoad,1);
% dates=flipdim(currentDayDate,1);

D=zeros(size(preD,1),size(preD,2));
preD=loadDataNY24;

for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end