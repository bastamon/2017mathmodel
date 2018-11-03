clear all;clc;
load mymap.mat;
w=xlsread('map.xlsx');
%w为有径矩阵
w(isnan(w))=0;
Temp=[D;Z;F;J];
figure(1);
plot(D(:,1),D(:,2),'+');
hold on;
plot(F(:,1),F(:,2),'s');
hold on
plot(Z(:,1),Z(:,2),'d');
hold on
plot(J(:,1),J(:,2),'o');
hold on;
dist=zeros(130);

u=triu(w);
d=tril(w);
for i=1:1:130
    for j=i:1:130
        if u(i,j)>0;
           x=[Temp(i,1),Temp(j,1)];
           y=[Temp(i,2),Temp(j,2)];
           dist(i,j)=sqrt((Temp(i,1)-Temp(j,1))^2+(Temp(i,2)-Temp(j,2))^2);%所有连线点的距离
           plot(x,y,'k');           
        end
        clear x y;
    end
end
clear i j;

flag=ones(130);
for i=1:1:130
    for j=1:1:130
        if w(i,j)>0
            if w(i,j)~=w(j,i)
                flag(i,j)=0;
                flag(j,i)=0;
            end
        end
    end
end
xlswrite('output.xlsx',flag);