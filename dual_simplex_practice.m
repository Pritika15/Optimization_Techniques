% Max z=-2x1-x3
% s.t -x1-x2+x3+s1= -5
%     -x1+2x2-4x3+s2= -8
%Input variable
variables={'x_1','x_2','x_3','s_1','s_2','sol'}
A=[-1 -1 1 1 0 -5; -1 2 -4 0 1 -8]
cost=[-2 0 -1 0 0 0]
%Identity matrix
s=eye(size(A,1))
%BV
BV=[]
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV=[BV i]
        end
    end
end
%Computing Zj-Cj
ZjCj=cost(BV)*A-cost
%Print the table
ZCj=[ZjCj;A]
Simpletable=array2table(ZCj)
Simpletable.Properties.VariableNames(1:size(ZCj,2))=variables
%DUAL SIMPLEX
RUN=true
while RUN
    Sol=A(:,end)
    if any(Sol<0)
        fprintf('The current BFS is not feasible\n')
        %Leaving var
        [leavingVar, pvt_row]=min(Sol)
        %Entering var
        ROW=A(pvt_row,1:end-1)
        ZJ=ZjCj(1,1:end-1)
        for i=1:size(ROW,2)
            if ROW(i)<0
                ratio(i)=abs(ZJ(i)./ROW(i))
            else
                ratio(i)=inf
            end
        end
        [EnteringVar, pvt_col]=min(ratio)
        %Updating BV
        BV(pvt_row)=pvt_col
        %Updating the table
        pvt_key=A(pvt_row, pvt_col)
        A(pvt_row,:)=A(pvt_row,:)./pvt_key
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:)
            end
        end
        ZjCj=ZjCj-ZjCj(pvt_col).*A(pvt_row,:)

        final_BFS=zeros(1,size(A,2))
        final_BFS(BV)=A(:,end)
        final_BFS(end)=sum(final_BFS.*cost)

        optimal_BFS=array2table(final_BFS)
        optimla_BFS.Properties.VariableNames(1:size(optimal_BFS,2))=variables

    else
        RUN=false
        fprintf('the optimla and feasible soln is \n')
    end
end
