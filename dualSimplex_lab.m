%max z=2x1-x3 s.t
%x1+x2-x3>=5
%x1-2x2+4x3>=8
%x1,x2,x3>=0
%max z=2x1-x3
%-x1-x2+x3<= -5
%-x1+2x2-4x3<= -8
variables={'x1','x2','x3','s1','s2','sol'}
cost=[-2 0 -1 0 0 0]
info=[-1 -1 1; -1 2 -4]
B=[-5; -8]
S=eye(size(info,1))
A=[info S B]
BV=[]
for j=1:size(S,2)
    for i=1:size(A,2)
        if(A:,i)==S(:,j)
            BV=[BV i]
        end
    end
end
fprintf('Basic variables=')
disp(variables(BV))
ZjCj=cost(BV)*A-cost
ZCj=[ZjCj;A]
SimplexTable=array2table(ZCj)
SimplexTable.Properties.VariableNames(1:size(ZCj,2))=variables
RUN=True
while RUN
    Sol=A(:,end)
    if any(sol<0)
        fprintf('The correct BFS is not feasible')
        [leaving_value, pivot_row]=min(Sol)
        fprintf('leaving row = %d', pvt_row)
        Row=A(pvt_row,1:end-1)
        ZRow=ZjCj(:,1:end-1)
        for i=1:size(Row,2)
            if Row(i)<0
                ratio(i)=abs(ZRow(i)./Row(i))
            else
                ratio(i)=inf
            end
        end
        [minRatio, pvt_col]=min(ratio)
        fprintf('entering variables %d',pvt_col)
        BV(pvt_row)=pvt_col
        fprintf('basic variables==')
        disp(variables(BV))
        pvt_key=A(pvt_row,pvt_col)
        A(pvt_row,:)./pvt_key
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:)
            end
            ZjCj=cost(BV)*A-cost
            ZCj=[ZjCj;A]
            SimplexTable=array2table