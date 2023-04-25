format short
%step1%
c=[3,5];
a=[1,2;1,1;0,1];
b=[2000;1500;600];
y1=0:1:max(b);
x21=(b(1)-a(1,1).*y1)./a(1,2);
x22=(b(2)-a(2,1).*y1)./a(2,2);
x23=(b(3)-a(3,1).*y1)./a(3,2);
%step2%
x21=max(0,x21);
x22=max(0,x22);
x23=max(0,x23);
plot(y1,x21,'r',y1,x22,'k',y1,x23,'b');
xlabel('values of x1');
ylabel('values of x2');
title('graphical method LPP');
legend('x1+2x2<=2000','x1+x2<=1500','x2<=600');
grid on
%step3%
cx1=find(y1==0);
c1=find(x21==0);
line1=[y1(:,[c1 cx1]); x21(:,[c1 cx1])]';

c2=find(x22==0);
line2=[y1(:,[c2 cx1]); x22(:,[c2 cx1])]';

c3=find(x23==0);
line3=[y1(:,[c3 cx1]); x23(:,[c3 cx1])]';

cornerpt=unique([line1; line2 ; line3],'rows');

%step4%
HG=[0;0];
for i=1:size(a,1)
    hg1=a(i,:);
    b1=b(i,:);
    for j=i+1:size(a,1)
        hg2=a(j,:);
        b2=b(j,:);
        Aa=[hg1; hg2];
        Bb=[b1;b2];
        Xx=Aa\Bb;
        HG=[HG Xx];
    end
end
pt=HG';

%step5%
allpts=[pt;cornerpt];
points=unique(allpts,'rows');

%step6%
PT=constraint(points);
PT=unique(PT,'rows');

%step7%
for i=1:size(PT,1)
    FX(i,:)=sum(PT(i,:).*c);
end

Vert_Fns=[PT FX];

%step8%
[fxval indfx]=max(FX);
optval=Vert_Fns(indfx,:);
optimal_BFS=array2table(optval);