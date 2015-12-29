function [class,U,centres,error] = FuzzyCMeans(X,c,m,InitCentres)
%FuzzyCMeans Performs fuzzy c-means clustering
% [Class,U] = FuzzyCMeans(Data,c,m,InitCentres) where
% Data is matrix with variables as columns and records as rows,
% c is number of clusters to find,
% m is degree of fuzziness (default = 1.25),
% InitCentres is initial centres of clusters (default - randomly 
% chosen from data). 
%
% "Class" is a list of most likely cluster labels, U is the fuzzy membership matrix.
% "centres" is the centre of each cluster, and "error" is the final error value.

[R,ndim]=size(X);

if exist('m')~=1
   m=1.5;
end
mpower=2/(m-1);	%saves time later...

if exist('InitCentres')~=1
   InitCentres= ChooseInitialCentres(X,c);
end

U=zeros(c,R);				%partition (membership) matrix: [0..1]

for i=1:c			
   ThisCentre=repmat(InitCentres(i,:),R,1);
   U(i,:)=sum((ThisCentre-X).^2,2)';
end
U=U./(MaxMax(U));

OldU=U;
MaxIter=250;
v=zeros(c,ndim);

for r=1:MaxIter
   U=U.^m;
   for i = 1:c
      sumUi=sum(U(i,:));
      for j=1:ndim
			v(i,j)=sum(U(i,:).*X(:,j)')/sumUi;
      end
   end
   
   Xt=permute(X, [1 3 2]);
   vt=permute(v, [3 1 2]);
   dik=sqrt(sum(abs(Xt(:,ones(1,c),:) - vt(ones(1,R),:,:)).^2,3));
   %[zi,zj]=find(dik==0);dik(zi,zi)=1;
   for i = 1:c
      td(i,:)=sum((repmat(dik(:,i),1,c)./dik).^mpower,2)';
   end
   %td(zi,:)=zeros(1,c);td(zi,zj)=1;   
   U=1./td;
	
   Change=max(sqrt(sum((OldU-U).^2,2)));
   if Change<1e-5
      break		%convergence reached
   end
   OldU=U;
end

for i = 1:c
   sumUi=sum(U(i,:));
   for j=1:ndim
      v(i,j)=sum(U(i,:).*X(:,j)')/sumUi;
   end
end

[strength,class]=max(U);
centres=v;
error=sum((U.^m).*(dik.^2)',1);