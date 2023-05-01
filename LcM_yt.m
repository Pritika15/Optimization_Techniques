%Input the parameters
cost=[11 20 7 8; 21 16 10 12; 8 12 18 9]
A=[50 40 70]% row
B=[30 25 35 40]%col
%To check whether the given problem is balanced or unbalanced
if sum(A)==sum(B)
    fprintf('The given problem is balanced')
else
    fprintf('The given problem is not balanced')
    if sum(A)<sum(B)
        cost(end+1,:)=zeros(1,size(A,2))
        A(end+1)=sum(B)-sum(A)
    elseif sum(A)>sum(B)
        cost(:,end+1)=zeros(1,size(A,2))
        B(end+1)=sum(A)-sum(B)
    end
end
%save the cost copy
Icost=cost
%Intialize allocation
X=zeros(size(cost))
%finding row and column
[m,n]=size(cost)
%Total BFS
BFS=m+n-1
if X<BFS
    fprintf('Degenerate')
else
    fprintf('Non-Degenrate')
end
%Finding the cell with min cost for the allocations
for i=1:size(cost,1)
    for j=1:size(cost,2)
        hh=min(cost(:))
        [rowid colid]=find(hh==cost)
        %Assign allocations to each cost
        x11=min(A(rowid),B(colid))
        %Finding the max allocation
        [val, ind]=max(x11)
        %Identify the row pos
        ii=rowid(ind)
        jj=colid(ind)
        %Find the value
        y11=min(A(ii),B(jj));
        %Assign allocation
        X(ii,jj)=y11
        %Reduce Row value
        A(ii)=A(ii)-y11
        %REduce col value
        B(jj)=B(jj)-y11;
        %cell covered
        cost(ii,jj)=inf
    end
end
%Print the initial BFS
fprintf('initial BFS=\n')
IB=array2table(X)
disp(IB)
%Check for degenrate or Non-degen
TotalBFS=length(nonzeros(X))
if TotalBFS==BFS
    fprintf('Non degen')
else
    fprintf('degen')
end
%Computing the initial transportation cost
InitialCost=sum(sum(Icost.*X))
fprintf('Initial BFS cost= %d \n', InitialCost)