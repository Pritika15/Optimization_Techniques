format short
clear all
clc
%No of variables in the constraints
Noofvariables=3
%Cost matrix corresponding to Z
C=[-1 3 -2]
%corresponding to constraint matrix
Info=[3 -1 2; -2 4 0; -4 3 8]
%corresponding to RHS of the constraints
b=[7;12;10]
%Identity matrix
s=eye(size(Info,1))
%Forming the main matrix
A=[Info s b]
%The coeff wrt each var
Cost=zeros(1,size(A,2))
Cost(1:Noofvariables)=C
%BV- gives the index of the basic variables
BV=Noofvariables+1:size(A,2)-1
%To find the values of the BV in the cost matrix
Cost(BV)
%To compute Zj-Cj
ZjCj=Cost(BV)*A-Cost
%Print the table
ZCj=[ZjCj;A]
SimpleTable=array2table(ZCj)
SimpleTable.Properties.VariableNames(1:size(ZCj,2))={'x_1','x_2','x_3','s_1','s_2','s_3','sol'}
%Simplex table
RUN=true;
while RUN
    if any(ZjCj<0)
        fprintf('The current BFS is not optimal \n')
        fprintf('-----The next itr results-------\n')
        disp('old basic var(BV)=');
        disp(BV);
        %Finding the entering variable
        ZC=ZjCj(1:end-1);
        [EnteringVar,pvt_col]=min(ZC)
        fprintf('The most negative element in ZjCj is %d corresponding to col %d \n',EnteringVar,pvt_col);
        fprintf('entering variable is %d \n',pvt_col)
    
        %To find the min ratio i.e leaving variable
        
        if all (A(:,pvt_col)<=0)
            error('LPP is unbounded. All entries<=0 in col %d', pvt_col);
        else
            Sol=A(:,end)
            Column=A(:,pvt_col)
            for i=1:size(Column,1)
                if Column(i)>0
                    ratio(i)=Sol(i)./Column(i);
                else
                    ratio(i)=inf
                end
            end
            [MinRatio,pvt_row]=min(ratio)
            fprintf('The minimum ratio is %d at %d row \n', MinRatio, pvt_row)
            fprintf('Leaving Variable is %d \n',BV(pvt_row))
        end
        %To find the pivot key
        BV(pvt_row)=pvt_col;
        disp('New Basic variables (BV)=')
        disp(BV);
        %Pivotkey
        pvt_key=A(pvt_row,pvt_col);
        %Updating the table for the next itr:
        A(pvt_row,:)=A(pvt_row,:)./pvt_key;
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
            end
            ZjCJ=ZjCj-ZjCj(pvt_col).*A(pvt_row,:);
        end
        %For printing the values
        ZCj=[ZjCj;A]
        Table=array2table(ZCj)
        Table.Properties.VariableNames(1:size(ZCj,2))={'x_1','x_2','x_3','s_1','s_2','s_3','sol'}
        BFS=zeros(1,size(A,2));
        BFS(BV)=A(:,end);
        BFS(end)=sum(BFS.*Cost);
        Current_BFS=array2table(BFS);
        Current_BFS.Properties.VariableNames(1:size(Current_BFS,2))={'x_1','x_2','x_3','s_1','s_2','s_3','sol'}

    else
        RUN=false;
        fprintf('************************ \n')
        fprintf('The current BFS is an optimal\n')
        fprintf('************************ \n')
    end
end






