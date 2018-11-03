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
dist=inf(130);
for i=1:1:130
    for j=1:1:130
        if w(i,j)>0;
           x=[Temp(i,1),Temp(j,1)];
           y=[Temp(i,2),Temp(j,2)];
           %�㵽��������dist
           dist(i,j)=sqrt((Temp(i,1)-Temp(j,1))^2+(Temp(i,2)-Temp(j,2))^2);%�������ߵ�ľ���
%          plot(x,y,'k');           
        end
        if i==j
            dist(i,j)=0;
        end
        
        clear x y;
    end
end
clear i j;


%%%%%%%%%������F���䵽J25��J34��J36��J42��J49�����·���µ�ʱ���ж�
%J25->93������̨i
for i=9:1:68    
        if i==9
            [distance1,path1] = mydijkstra(dist,93,i);%ʹ��dijkstra  
            path1=[path1,zeros(1,130-length(path1))];
        else
            [d,p]=mydijkstra(dist,93,i);
            p=[p,zeros(1,130-length(p))];
            path1=[path1;p];
        end
end
clear p d;
% [distance path] = mydijkstra(dist,1,42);

%������ΪJ34->102������̨i
for i=9:1:68    
        if i==9
            [distance2,path2] = mydijkstra(dist,102,i);%ʹ��dijkstra  
            path2=[path2,zeros(1,130-length(path2))];
        else
            [d,p]=mydijkstra(dist,102,i);
            p=[p,zeros(1,130-length(p))];
            path2=[path2;p];
        end
end
clear p d;

%������ΪJ36->104������̨i
for i=9:1:68    
        if i==9
            [distance3,path3] = mydijkstra(dist,104,i);%ʹ��dijkstra  
            path3=[path3,zeros(1,130-length(path3))];
        else
            [d,p]=mydijkstra(dist,104,i);
            p=[p,zeros(1,130-length(p))];
            path3=[path3;p];
        end
end
clear p d;

%������ΪJ42->110������̨i
for i=9:1:68    
        if i==9
            [distance4,path4] = mydijkstra(dist,110,i);%ʹ��dijkstra  
            path4=[path4,zeros(1,130-length(path4))];
        else
            [d,p]=mydijkstra(dist,117,i);
            p=[p,zeros(1,130-length(p))];
            path4=[path4;p];
        end
end
clear p d i;



%������ΪJ49->117������̨i
for i=9:1:68    
        if i==9
            [distance5,path5] = mydijkstra(dist,117,i);%ʹ��dijkstra  
            path5=[path5,zeros(1,130-length(path5))];
        else
            [d,p]=mydijkstra(dist,117,i);
            p=[p,zeros(1,130-length(p))];
            path5=[path5;p];
        end
end
clear p d i;
    
% ss(1)=sum(distance1)
% ss(2)=sum(distance2)
% ss(3)=sum(distance3)
% ss(4)=sum(distance4)
% [u v]=sort(ss);

path1=path1(:,any(path1));%ɾ��ȫΪ0��
path2=path2(:,any(path2));%ɾ��ȫΪ0��
path3=path3(:,any(path3));%ɾ��ȫΪ0��
path4=path4(:,any(path4));%ɾ��ȫΪ0��
path5=path5(:,any(path5));%ɾ��ȫΪ0��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%J25
[m,n]=size(path1);
wp1=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path1(i,j+1)~=0
            wp1(path1(i,j),path1(i,j+1),i)=1; %����·��
        end
    end
end
clear i j m n;

%%%%%J34
[m,n]=size(path2);
wp2=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path2(i,j+1)~=0
            wp2(path2(i,j),path2(i,j+1),i)=1; %����·��
        end
    end
end
clear i j m n;

%%%%%J36
[m,n]=size(path3);
wp3=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path3(i,j+1)~=0
            wp3(path3(i,j),path3(i,j+1),i)=1; %����·��
        end
    end
end
clear i j m n;


%%%%%J42
[m,n]=size(path4);
wp4=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path4(i,j+1)~=0
            wp4(path4(i,j),path4(i,j+1),i)=1; %����·��
        end
    end
end
clear i j m n;

%%%%%J49
[m,n]=size(path5);
wp5=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path5(i,j+1)~=0
            wp5(path5(i,j),path5(i,j+1),i)=1; %����·��
        end
    end
end
clear i j m n;

%%%%%%%%%%%%%%%%%%
Va=45.*ones(130);
Vb=35.*ones(130);
Vc=30.*ones(130);
%Va��b��c���¸����ɵ�
for i=69:1:78
    Va(i,i+1)=70;
    Vb(i,i+1)=60;
    Vc(i,i+1)=50;
end
clear i;

for i=80:1:87
    Va(i,i+1)=70;
    Vb(i,i+1)=60;
    Vc(i,i+1)=50;
end
clear i;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disto=dist;
disto(isinf(disto))=0;
ta=disto./Va;tb=disto./Vb;tc=disto./Vc;
tq=sum(sum(ta+tb+tc));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for k=1:1:60
    a=tq.*wp1(:,:,k);
    a(isnan(a))=0;
    tj(:,:,k)=a;
    Tj25(1,k)=sum(sum(tj(:,:,k)));
    clear a;
end
clear tj;

for k=1:1:60
    a=tq.*wp2(:,:,k);
    a(isnan(a))=0;
    tj(:,:,k)=a;
    Tj34(1,k)=sum(sum(tj(:,:,k)));
    clear a;
end
clear tj;

for k=1:1:60
    a=tq.*wp3(:,:,k);
    a(isnan(a))=0;
    tj(:,:,k)=a;
    Tj36(1,k)=sum(sum(tj(:,:,k)));
    clear a;
end
clear tj;

for k=1:1:60
    a=tq.*wp4(:,:,k);
    a(isnan(a))=0;
    tj(:,:,k)=a;
    Tj42(1,k)=sum(sum(tj(:,:,k)));
    clear a;
end
clear tj;

for k=1:1:60
    a=tq.*wp5(:,:,k);
    a(isnan(a))=0;
    tj(:,:,k)=a;
    Tj49(1,k)=sum(sum(tj(:,:,k)));
    clear a;
end
clear tj;
qTj25=Tj25./tq;
qTj34=Tj34./tq;
qTj36=Tj36./tq;
qTj42=Tj42./tq;
qTj49=Tj49./tq;
su(1,1)=sum(qTj25);
su(1,2)=sum(qTj34);
su(1,3)=sum(qTj36);
su(1,4)=sum(qTj42);
su(1,5)=sum(qTj49);
[B,I]=sort(su);
e={'J25' 'J34' 'J36' 'J42' 'J49'};
disp('��ʱװ�����ڵ���:')
e(I(1)),e(I(2))
% disp('Ӧѡ'+e(I(1))+'��'+e(I(2))+'%��Ϊ��ʱװ����');