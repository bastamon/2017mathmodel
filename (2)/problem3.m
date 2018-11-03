clear all;
clc;
load mymap.mat;
w=xlsread('map.xlsx');
%wΪ�о�����
w(isnan(w))=0;
Temp=[D;Z;F;J];
% figure(1);
% plot(D(:,1),D(:,2),'+');
% hold on;
% plot(F(:,1),F(:,2),'s');
% hold on
% plot(Z(:,1),Z(:,2),'d');
% hold on
% plot(J(:,1),J(:,2),'o');
% hold on;

% u=triu(w);
% d=tril(w);
Vc=30.*ones(130);
%Va��b��c���¸����ɵ�
for i=69:1:78
    Vc(i,i+1)=50;
end
clear i;

for i=80:1:87
    Vc(i,i+1)=50;
end
clear i;



dist=inf(130);
for i=1:1:130
    for j=1:1:130
        if w(i,j)>0;
%           �㵽��������dist
           dist(i,j)=sqrt((Temp(i,1)-Temp(j,1))^2+(Temp(i,2)-Temp(j,2))^2);%�������ߵ�ľ���
%            x=[Temp(i,1),Temp(j,1)];
%            y=[Temp(i,2),Temp(j,2)];

%            plot(x,y,'k');           
        end
        if i==j
            dist(i,j)=0;
        end
%         clear x y;
    end
end
clear i j;


%C�ֱ��ڵ�-����������ʻʱ�����
tc=dist./Vc;


firstshot=[xlsread('firstshot_1.xlsx',1);xlsread('firstshot_1.xlsx',2);xlsread('firstshot_1.xlsx',3)];

%%%%%%%%%%%%%%%%%%%%

%ע��firstshot(:,3)�ǲ����õĵ�continue
clear path2 distance2
%J04,J06 ,J08
for i=72:2:76
    for j=9:1:68
        flag=0;
        for k=1:1:24
            if j==firstshot(k,3)
                flag=1;
                break;
            end
        end
        if flag==0
            if i==72&&j==9
                [distance3,path3] = mydijkstra(dist,i,j);%ʹ��dijkstra  
                path3=[path3,zeros(1,130-length(path3))];
            else
                [d,p]=mydijkstra(dist,i,j);
                p=[p,zeros(1,130-length(p))];
                distance3=[distance3;d];
                path3=[path3;p];
            end
        end
    end
end
clear d p flag;

%J13~J15
for i=81:1:83
    for j=9:1:68
        flag=0;
        for k=1:1:24
            if j==firstshot(k,3)
                flag=1;
                break;
            end
        end
        if flag==0
            if i==81&&j==9
                [distance4,path4] = mydijkstra(dist,i,j);%ʹ��dijkstra  
                path4=[path4,zeros(1,130-length(path4))];
            else
                [d,p]=mydijkstra(dist,i,j);
                p=[p,zeros(1,130-length(p))];
                distance4=[distance4;d];
                path4=[path4;p];
            end
        end
    end
end
clear d p flag;

path34=[path3;path4];
clear path3 path4
path34=path34(:,any(path34));%ɾ��ȫΪ0��

%�������Ϊ228�ľ���wpa2��ÿһ�����һ�����·������,wp2(:,:,:)=1ѡ·
[m,n]=size(path34);
wp34=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path34(i,j+1)~=0
            wp34(path34(i,j),path34(i,j+1),i)=1; %����·��
        end
    end
end
clear i j m n;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ע��k�ķ��仹δȷ��
%A��,ftaÿ��·��fTa�Ƿ���kʱ��ȫ��ʱ��
% for k=1:1:216
%     a=ta.*wp34(:,:,k);
%     a(isnan(a))=0;
%     eta(:,:,k)=a;
%     eTa(1,k)=sum(sum(eta(:,:,k)));
%     clear a;
% end
% 
% %Ta2ΪA�ֳ�ʹ�÷���Ia2ʱ�����ʱ��
% [Ta2,Ia2]=sort(eTa);
% a=[Ta2;Ia2];
% xlswrite('newtime3.xls',a,1);
% clear a;
% % 
% %%B��
% %B��,ftbÿ��·��fTb�Ƿ���kʱ��ȫ��ʱ��
% for k=1:1:216
%     a=tb.*wp34(:,:,k);
%     a(isnan(a))=0;
%     etb(:,:,k)=a;
%     eTb(1,k)=sum(sum(etb(:,:,k)));
%     clear a;
% end
% 
% %Tb1ΪB�ֳ�ʹ�÷���Ib1ʱ�����ʱ��
% [Tb2,Ib2]=sort(eTb);
% a=[Tb2;Ib2];
% xlswrite('newtime3.xls',a,2);
% clear a;
%%%%%%%%%%%%%%

%C��,ftcÿ��·��fTc�Ƿ���kʱ��ȫ��ʱ��
for k=1:1:216
    a=tc.*wp34(:,:,k);
    a(isnan(a))=0;
    etc(:,:,k)=a;
    eTc(1,k)=sum(sum(etc(:,:,k)));
    clear a;
end

%T1ΪB�ֳ�ʹ�÷���Ib1ʱ�����ʱ��
[Tc2,Ic2]=sort(eTc);
a=[Tc2;Ic2];
xlswrite('newtime3.xls',a,3);
clear k;

add3Cshot=xlsread('promble3.xlsx',3);

for i=1:1:12
    x(1,i)=Temp(add3Cshot(i,3),1);
    y(1,i)=Temp(add3Cshot(i,3),2);
end
