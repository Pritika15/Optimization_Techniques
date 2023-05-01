%Input parameters
variables={'x_1','x_2','x_3','s_1','s_2','sol'};
cost=[-2 0 -1 0 0 0];
A=[-1 -1 1 1 0 -5; -1 2 -4 0 1 -8];
s=eye(size(A,1))
%To find the BV
BV=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV=[BV i]
        end
    end
end
%To compute Zj-Cj
ZjCj=cost(BV)*A-cost
%Print the table
ZCj=[ZjCj;A];
simpletable=array2table(ZCj);
simpletable.Properties.VariableNames(1:size(ZCj,2))=variables
%Dual-Simplex Method

RUN=true;
while RUN
    %Finding the leaving variables
    sol=A(:,end);
    if any(sol<0)
        fprintf('The current BFS is not feasible \n');
        [LeavingVal,pvt_row]=min(sol);
        fprintf('The leaving variable is %d and the pivot row is %d\n',LeavingVal,pvt_row);
        %Entering variables
    
        ROW=A(pvt_row,1:end-1)
        ZJ=ZjCj(1,1:end-1)
        
        for i=1:size(ROW,2)
            if ROW(i)<0
                ratio(i)=abs(ZJ(i)./ROW(i));
            else
                ratio(i)=inf;
            end
        end
        [EnteringVal,pvt_col]=min(ratio);
        fprintf('The entering variable is %d and the pivot col is %d \n',EnteringVal, pvt_col);
    %     %update the BV
        BV(pvt_row)=pvt_col;
        fprintf('the basic variable')
        disp(variables(BV))
        %Pivotkey 
        pvt_key=A(pvt_row,pvt_col);
        A(pvt_row,:)=A(pvt_row,:)./pvt_key;
    %     %updating the tabel
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
            end
        end
%         ZjCj=cost(BV)*A-cost
%         ZCj=[ZjCj;A];
%         table=array2table(ZCj);
%         table.Properties.VariableNames(1:size(table,2))=variables
        ZjCj=ZjCj-ZjCj(pvt_col)*A(pvt_row,:);
    % %     
        final_BFS=zeros(1,size(A,2))
        final_BFS(BV)=A(:,end);
        final_BFS(end)=sum(final_BFS.*cost);
        optimal_BFS=array2table(final_BFS);
        optimal_BFS.Properties.VariableNames(1:size(optimal_BFS,2))=variables
    else
        RUN=false;
        fprintf('The current BFS is feasible and optimal \n');
    end
end
