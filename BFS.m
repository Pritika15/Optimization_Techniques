format short
clear all
clc
%step1- Input parameters%
c=[2 3 4 7];
a=[2,3,-1,4; 1,-2,6,-7];
b=[8;-3];

%step2- defining n and m%
n=size(a,2);
m=size(a,1);

%step3- finding nCm and making basic solutions%
basic_var=nchoosek(n,m);
basic_pair=nchoosek(1:n,m);

%step4- basic solution

sol=[];
if n>m
    for i=1:basic_var
        y=zeros(n,1);
        x=a(:,basic_pair(i,:))\b;
        if all(x>=0 & x~=inf & x~= -inf)
            y(basic_pair(i,:))=x;
            sol=[sol y];
        end
    end
else
    error('Equations are larger than variables')
end
%step5- objective function%
z=c*sol;
%step6-optimal value%
[Zmax Zind]= max(z);
bfs=sol(:,Zind);

%step7- Print all solutions%
optval=[bfs' Zmax]
optimal_bfs=array2table(optval);
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2))={'x_1','x_2','x_3','x_4','z_val'};