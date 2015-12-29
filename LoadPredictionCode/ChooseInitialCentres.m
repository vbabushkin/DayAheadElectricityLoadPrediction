function [C,perm]=ChooseInitialCentres(set,k)
%CHOOSEINITIALCENTRES Randomly picks sample points
% Centres=CHOOSEINITIALCENTRES(Data,k) where Data is
% the data matrix, and k is the number of points required.
% Used to initialise various clustering routines.

perm = randperm(size(set,1));
perm = perm(1:k);
C = set(perm,:);
