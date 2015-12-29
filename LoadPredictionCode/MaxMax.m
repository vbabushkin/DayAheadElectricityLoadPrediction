function M = MaxMax(x)
%MAXMAX Maximum of all elements in an n-dimension array
% S = MAXMAX(X)
M=x;
for i = 1:ndims(x)
   M=max(M);
end
