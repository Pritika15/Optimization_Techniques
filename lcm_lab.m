cost=[11 20 7 8 ; 21 16 10 12; 8 12 18 9]
A=[50 40 70]
B=[30 25 35 40]
if sum(A)==sum(B)
    fprintf('given tranformation problem is balanced')
else
    fprintf('given transformation problem is not balanced')
    if sum(A)<sum(B)
        cost(end+1,:)=zeros(1,size(B,2))
        A(end+1)=sum(B)-sum(A)
    elseif sum(B)<sum(A)
            cost(:,end+1)=zeros(1,size(A,2))
            B(end+1)=sum(A)-sum(B)
    end
    
end
Icost=cost
X=zeros(size(cost))
[m,n]=size(cost)
BFS=m+n-1
for i=1:size(cost,1)
    for j=1:size(cost,2)
        hh=min(cost,1)
        [row_index, col_index]=find(hh==cost)
        X11=min(A(row_index),B(col_index))
        [value, index]=max(X11)
        ii=row_index(index)
        jj=col_index(index)
        y11=min(A(ii),B(jj))
        X(ii,jj)=y11
        A(ii)=A(ii)-y11
        B(jj)=B(jj)-y11
        cost(ii,jj)=inf
    end
end
fprintf('intial bfs=')
IBFS=array2table(X)
disp(IBFS)
TotalBFS=length(nonzeros(X))
if TotalBFS==BFS
    fprintf('intial bfs is mn-degenerate')
else
    fprintf('intial BFS is degenrate')
end
initial_cost=sum(sum(Icost.*X))
fprintf('intial BFS cost=%d',initial_cost)


