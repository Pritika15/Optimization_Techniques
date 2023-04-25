format short
clear all
clc

%step1-Input parameter%
c=[3,5];
a=[1,2;1,1;0,1];
b=[2000;1500;600];

%step2- Identifying the inqualities; let 0 is for <= and 1 for >=%
IneqSign=[0 0 1];

%step3-adding surplus and slack variables (using identity matrix)
s=eye(size(a,1));
index=find(IneqSign>0);
s(index,:)=-s(index,:);

%step4-standard form%
objFns=array2table(c);
objFns.Properties.VariableNames(1:size(c,2))={'x_1','x_2'};
mat=[a s b];
constraint=array2table(mat);
constraint.Properties.VariableNames(1:size(mat,2))={'x_1','x_2','s_1','s_2','s_3','sol'};