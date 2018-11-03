clc;
load mymap.mat;
w=xlsread('map.xlsx');
%wΪ�о�����
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
           plot(x,y,'k');           
        end
        if i==j
            dist(i,j)=0;
        end
        clear x y;
    end
end
clear i j;
         



% figure(2);
% plot(D(:,1),D(:,2),'+');
% hold on;
% plot(F(:,1),F(:,2),'s');
% hold on
% plot(Z(:,1),Z(:,2),'d');
% hold on
% plot(J(:,1),J(:,2),'o');
% hold on;
% for i=1:1:130
%     for j=1:1:130
%         if u(i,j)>0;
%            x=[Temp(i,1),Temp(j,1)];
%            y=[Temp(i,2),Temp(j,2)];
%            plot(x,y,'k');
%            
%         end
%     end
% end
%ispath=-ones(130);
%

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


%��һ������׶�
%������ΪD1

%D1������̨i
for i=9:1:68    
        if i==9
            [distance1,path1] = mydijkstra(dist,1,i);%ʹ��dijkstra  
%             distance1=[distance1,zeros(1,130-length(distance1))];
            path1=[path1,zeros(1,130-length(path1))];
        else
            [~,p]=mydijkstra(dist,1,i);
%             d=[d,zeros(1,130-length(d))];
            p=[p,zeros(1,130-length(p))];
%             distance1=[distance1;d];
            path1=[path1;p];
        end
end
clear p d;
% [distance path] = mydijkstra(dist,1,42);

%������ΪD2������̨i
for i=9:1:68    
        if i==9
            [distance2,path2] = mydijkstra(dist,2,i);%ʹ��dijkstra  
%             distance2=[distance2,zeros(1,130-length(distance2))];
            path2=[path2,zeros(1,130-length(path2))];
        else
            [~,p]=mydijkstra(dist,2,i);
%             d=[d,zeros(1,130-length(d))];
            p=[p,zeros(1,130-length(p))];
%             distance2=[distance2;d];
            path2=[path2;p];
        end
end
clear p d;

%distanceΪ��㵽�յ��ȫ�־���
distance=[distance1;distance2];
path=[path1;path2];
clear distance1 distance2 path1 path2 i;
 
% %���Ҿ�����ͬ�յ��·��
% for i=1:1:120
%     for j=1:1:20
%         if path(i,j+1)==0
%             term(i,1)=path(i,j);
%             break;
%         end
%     end
% end
% clear i j;
% 
% %���Ҿ�����ͬ�յ��·��
% for i=1:1:120
%     for j=1:1:120
%         if (i~=j)&&(term(i,1)==term(j,1))
%             term(j,1)=0;
%         end
%     end
% end
% clear i j;
% 
% %���ظ��յ��г�0
% for i=1:1:120
%     if term(i,1)==0
%         for j=1:1:20
%             path(i,j)=term(i,1)*path(i,j);
%         end
%     end
% end
% clear i j;

newpath=path(any(path'),:);%ɾ��ȫΪ0��
newpath=newpath(:,any(newpath));%ɾ��ȫΪ0��
[m,n]=size(newpath);
xlswrite('selpath.xls',newpath)
fprintf('��%d��·���ɹ�ѡ�����selpath.xlsx�ļ��鿴\n',m);

%ABC�ֱ��ڵ�-����������ʻʱ�����
ta=dist./Va;tb=dist./Vb;tc=dist./Vc;

%�������Ϊ60��ľ���wp��ÿһ�����һ�����·������,wp(:,:,:)=1ѡ·
wp=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if newpath(i,j+1)~=0
            wp(newpath(i,j),newpath(i,j+1),i)=1; 
        end
    end
end
clear i j path;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%ǰ����һ������������%%%%%%%%%
%A�೵
for k=1:1:m
    a=ta.*wp(:,:,k);
    a(isnan(a))=0;
    tta(:,:,k)=a;
    tTa(1,k)=sum(sum(tta(:,:,k)));
    clear a;
end

%TaΪA�ֳ�ʹ�÷���Iaʱ�����ʱ��
[Ta,Ia]=sort(tTa);
a=[Ta;Ia];
xlswrite('��һ������timetable.xls',a,1);
clear a;
%һ��Ҫȡ6��index;
% fprintf('A��ѡ�񷽰���\t����ʱ��\n');
% for i=1:1:6
%     fprintf('%d\t\t %d\n',Ia(i),Ta(i));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%B�೵
for k=1:1:m
    a=tb.*wp(:,:,k);
    a(isnan(a))=0;
    ttb(:,:,k)=a;
    tTb(1,k)=sum(sum(tta(:,:,k)));
    clear a;
end

%TbΪB�ֳ�ʹ�÷���Ibʱ�����ʱ��
[Tb,Ib]=sort(tTa);
b=[Tb;Ib];

xlswrite('��һ������timetable.xls',b,2);
clear b;
%һ��Ҫȡ6��index;
% fprintf('B��ѡ�񷽰���\t����ʱ��\n');
% for i=1:1:12
%     fprintf('%d\t\t %d\n',Ib(i),Tb(i));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%C�೵
for k=1:1:m
    a=tc.*wp(:,:,k);
    a(isnan(a))=0;
    ttc(:,:,k)=a;
    tTc(1,k)=sum(sum(ttc(:,:,k)));
    clear a;
end

%TcΪC�ֳ�ʹ�÷���Icʱ�����ʱ��
[Tc,Ic]=sort(tTc);
c=[Tc;Ic];

xlswrite('��һ������timetable.xls',c,3);
clear c;
%һ��Ҫȡ6��index;
% fprintf('C��ѡ�񷽰���\t����ʱ��\n');
% for i=1:1:24
%     fprintf('%d\t\t %d\n',Ic(i),Tc(i));
% end
clear i k m n;


% clear wp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����˹�����
%%%%%%ǰ��װ�ص�����Z        %%%%%%%%%%%%%%%%
%����̨firstshot(i,3)��װ����j
firstshot=[xlsread('firstshot_1.xlsx',1);xlsread('firstshot_1.xlsx',2);xlsread('firstshot_1.xlsx',3)];



for i=1:1:24  
    for j=3:1:8
        if i==1&&j==3
            [distance1,path1] = mydijkstra(dist,firstshot(i,3),j);%ʹ��dijkstra  
            path1=[path1,zeros(1,130-length(path1))];
        else
            [d,p]=mydijkstra(dist,firstshot(i,3),j);
            p=[p,zeros(1,130-length(p))];
            distance1=[distance1;d];
            path1=[path1;p];
        end
    end
end
clear p d;
path1=path1(:,any(path1));%ɾ��ȫΪ0��

%%%%%%%%%%%%%%%%%%5
%����̨i��װ����j��·��Ϊpath1��ȫ��ʵ�ʾ���distance1
for i=1:1:24
    x(1,i)=Temp(firstshot(i,3),1);
    y(1,i)=Temp(firstshot(i,3),2);
end
% ��һ�����䲿��ͼ
figure('name','��һ�η��䲿��ͼ');
scatter(x,y,'s','filled');
axis([0 250 0 150]);
clear x y;
hold on;


plot(D(:,1),D(:,2),'+');
hold on;
plot(F(:,1),F(:,2),'s');
hold on
plot(Z(:,1),Z(:,2),'d');
hold on
plot(J(:,1),J(:,2),'o');
hold on;

w1=zeros(130);
for k=1:24
    w1=w1+wp(:,:,firstshot(k,1));    
end
for i=1:130
	for j=1:130 
        if w1(i,j)>0;
               x=[Temp(i,1),Temp(j,1)];
               y=[Temp(i,2),Temp(j,2)];
               plot(x,y,'k');           
        end
    end
end
clear x y w1 k i j;


  
 
 
 
 
 
 
 
 
 

%%%%%%%%%%%%%%%%%%

%�������Ϊ144��ľ���wpath��ÿһ�����һ�����·������,wp(:,:,:)=1ѡ·
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A��,ftaÿ��·��fTa�Ƿ���kʱ��ȫ��ʱ��
for k=1:1:36
    a=ta.*wp1(:,:,k);
    a(isnan(a))=0;
    fta(:,:,k)=a;
    fTa(1,k)=sum(sum(fta(:,:,k)));
    clear a;
end

%Ta1ΪA�ֳ�ʹ�÷���Ia1ʱ�����ʱ��
[Ta1,Ia1]=sort(fTa);
a=[Ta1;Ia1];
xlswrite('newtime1.xls',a,1);
clear a;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%B��,ftbÿ��·��fTb�Ƿ���kʱ��ȫ��ʱ��
for k=37:1:72
    a=tb.*wp1(:,:,k);
    a(isnan(a))=0;
    ftb(:,:,k)=a;
    fTb(1,k)=sum(sum(ftb(:,:,k)));
    clear a;
end

%Tb1ΪB�ֳ�ʹ�÷���Ib1ʱ�����ʱ��
[Tb1,Ib1]=sort(fTb);
a=[Tb1;Ib1];
xlswrite('newtime1.xls',a,2);
clear a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%C��,ftcÿ��·��fTc�Ƿ���kʱ��ȫ��ʱ��
for k=73:1:144
    a=tc.*wp1(:,:,k);
    a(isnan(a))=0;
    ftc(:,:,k)=a;
    fTc(1,k)=sum(sum(ftc(:,:,k)));
    clear a;
end

%Tb1ΪB�ֳ�ʹ�÷���Ib1ʱ�����ʱ��
[Tc1,Ic1]=sort(fTc);
a=[Tc1;Ic1];
xlswrite('newtime1.xls',a,3);
clear a k;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%�ڶ�����������
armloadtime=[xlsread('armloadtime_1.xlsx',1);xlsread('armloadtime_1.xlsx',2);xlsread('armloadtime_1.xlsx',3)];


for i=1:1:24
    x(1,i)=Temp(armloadtime(i,3),1);
    y(1,i)=Temp(armloadtime(i,3),2);
end
  

%%װ������ͼ
figure('name','װ������ͼ');
scatter(x,y,'d','filled');
axis([0 250 0 150]);
hold
clear x y;

plot(D(:,1),D(:,2),'+');
hold on;
plot(F(:,1),F(:,2),'s');
hold on
plot(Z(:,1),Z(:,2),'d');
hold on
plot(J(:,1),J(:,2),'o');
hold on;


w1=zeros(130);
for k=1:24
    w1=w1+wp1(:,:,armloadtime(k,1));    
end

w1(10,89)=1;
w1(32,100)=1;
w1(101,100)=1;
w1(46,108)=1;
for i=1:130
	for j=1:130 
        if w1(i,j)>0;
               x=[Temp(i,1),Temp(j,1)];
               y=[Temp(i,2),Temp(j,2)];
               plot(x,y,'k');           
        end
    end
end
clear x y w1 k i j;


%%%%%%%%%%%%%%%%%%%%

%ע��firstshot(:,3)�ǲ����õĵ�continue
clear path2 distance2
for i=3:1:8
    for j=9:1:68
        flag=0;
        for k=1:1:24
            if j==firstshot(k,3)
                flag=1;
                break;
            end
        end
        if flag==0
            if i==3&&j==9
                [distance2,path2] = mydijkstra(dist,i,j);%ʹ��dijkstra  
                path2=[path2,zeros(1,130-length(path2))];
            else
                [d,p]=mydijkstra(dist,i,j);
                p=[p,zeros(1,130-length(p))];
                distance2=[distance2;d];
                path2=[path2;p];
            end
        end
    end
end
clear d p flag;
path2=path2(:,any(path2));%ɾ��ȫΪ0��

%�������Ϊ228�ľ���wpa2��ÿһ�����һ�����·������,wp2(:,:,:)=1ѡ·
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ע��k�ķ��仹δȷ��
%A��,ftaÿ��·��fTa�Ƿ���kʱ��ȫ��ʱ��
for k=1:1:216
    a=ta.*wp2(:,:,k);
    a(isnan(a))=0;
    eta(:,:,k)=a;
    eTa(1,k)=sum(sum(eta(:,:,k)));
    clear a;
end

%Ta2ΪA�ֳ�ʹ�÷���Ia2ʱ�����ʱ��
[Ta2,Ia2]=sort(eTa);
a=[Ta2;Ia2];
xlswrite('newtime2.xls',a,1);
clear a;
% 
%%B��
%B��,ftbÿ��·��fTb�Ƿ���kʱ��ȫ��ʱ��
for k=1:1:216
    a=tb.*wp2(:,:,k);
    a(isnan(a))=0;
    etb(:,:,k)=a;
    eTb(1,k)=sum(sum(etb(:,:,k)));
    clear a;
end

%Tb1ΪB�ֳ�ʹ�÷���Ib1ʱ�����ʱ��
[Tb2,Ib2]=sort(eTb);
a=[Tb2;Ib2];
xlswrite('newtime2.xls',a,2);
clear a;
%%%%%%%%%%%%%%

%C��,ftcÿ��·��fTc�Ƿ���kʱ��ȫ��ʱ��
for k=1:1:216
    a=tc.*wp2(:,:,k);
    a(isnan(a))=0;
    etc(:,:,k)=a;
    eTc(1,k)=sum(sum(etc(:,:,k)));
    clear a;
end

%T1ΪB�ֳ�ʹ�÷���Ib1ʱ�����ʱ��
[Tc2,Ic2]=sort(eTc);
a=[Tc2;Ic2];
xlswrite('newtime2.xls',a,3);
clear a k;






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
secondshot=[xlsread('secondshot.xlsx',1);xlsread('secondshot.xlsx',2);xlsread('secondshot.xlsx',3)];
for i=1:1:24
    x(1,i)=Temp(secondshot(i,3),1);
    y(1,i)=Temp(secondshot(i,3),2);
end
%%�ڶ��η��䲿��ͼ
figure('name','�ڶ��η��䲿��');
scatter(x,y,'s','filled');
axis([0 250 0 150]);
hold on;
clear i x y;

plot(D(:,1),D(:,2),'+');
hold on;
plot(F(:,1),F(:,2),'s');
hold on
plot(Z(:,1),Z(:,2),'d');
hold on
plot(J(:,1),J(:,2),'o');
hold on;

w1=zeros(130);
for k=1:24
    w1=w1+wp2(:,:,secondshot(k,1));    
end
for i=1:130
	for j=1:130 
        if w1(i,j)>0;
               x=[Temp(i,1),Temp(j,1)];
               y=[Temp(i,2),Temp(j,2)];
               plot(x,y,'k');           
        end
    end
end
clear x y w1 k i j;


%%%%%%%%%%%%%%%%%%%%
fprintf('���屩¶ʱ��Ϊ��%d����\n',60*(sum(firstshot(:,2))+sum(armloadtime(:,2))+sum(secondshot(:,2))));
fprintf('��������¶ʱ��Ϊ��%d����\n',60*(max(firstshot(:,2))+max(armloadtime(:,2))+max(secondshot(:,2))));