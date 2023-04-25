function[BFS,A]=simp(A,BV,cost,variables)
ZjCj=cost(BV)*A-cost
RUN=true
while RUN
    ZC=ZjCj(1,1:end-1)
    if any(ZC<0)
        fprintf('the current BFS is not optimal')
        [EnterCol pvt_Col]=min(ZC)
        fprintf('Entering col= %d', pvt_Col)
        sol=A(:,end)
        column=A(:,pvt_Col)
        if column <=0
            fprintf('unbounded sol')
        else
            for i=1:1:size(A,1)
                if column(i)>0
                    ratio(i)=sol(i)/column(i)
                else
                    ratio(i)=inf
                end
            end
            [Minratio, pvt_row]=min(ratio)
            fprintf('leaving row is %d', pvt_row)
        end
        BV(pvt_row)=pvt_Col
        pvt_key=A(pvt_row,pvt_Col)
        A(pvt_row,:)=A(pvt_row,:)./pvt_key
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:)
            end
        end
        ZjCj=ZjCj-ZjCj(pvt_Col).*A(pvt_row,:)
        ZCj=[ZjCj;A]
        Table=array2table(ZCj)
        Table.Properties.VariableNames(1:size(ZCj,2))=variables
        BFS(BV)=A(:,end);
    else
        RUN=false
        fprintf('optimal soln is reached')
        fprintf('----phase ends----')
        BFS=BV;
    end
end
