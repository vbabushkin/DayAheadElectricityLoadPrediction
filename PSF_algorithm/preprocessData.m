clear all
close all 

%fid = fopen('coastData.csv', 'rt');
fid = fopen('data.csv', 'rt');
preData = textscan(fid, '%s %f','Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);
fclose(fid);

format short g
M = [datevec(preData{1}) preData{2}];
ds=[M(:,1:4),M(:,7)];



% i=1
% while i<size(ds,1)-2-24%35089 %1096
%     %if i<size(ds,1)-23
%     s=ceil(i/24);
%     dates(s,:)=datestr([ds(i,1) ds(i,2) ds(i,3) 0 0 0], 'yyyy-mm-dd');
%     for j=1:24
%         i
%         preD(s,j)=ds(i,end);
%         i=i+1;
%     end
% %     else 
% %         break
% %     end
%     
% end


preD=[]
dates=[]
for currYear=2008:1:2012
for m=1:size(unique(M(M(:,1)==currYear,2)),1)
for i=1:size(unique(M(M(:,1)==currYear & M(:,2)==m,3)),1)
    dates=[dates;datestr([currYear, m,i,0,0,0],'yyyy-mm-dd')];
    preD=[preD;  M(M(:,1)==currYear & M(:,2)==m & M(:,3)==i,end)'];
end
end
end




D=zeros(size(preD,1),size(preD,2));
for i=1:size(preD,1)
    norm=sum(preD(i,:));
    for j=1:size(preD,2)
        D(i,j)=preD(i,j)/norm;
    end
end