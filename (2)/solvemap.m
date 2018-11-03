clc;
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

% u=triu(w);
% d=tril(w);
dist=inf(130);
for i=1:1:130
    for j=1:1:130
        if w(i,j)>0;
           x=[Temp(i,1),Temp(j,1)];
           y=[Temp(i,2),Temp(j,2)];
           %点到点距离矩阵dist
           dist(i,j)=sqrt((Temp(i,1)-Temp(j,1))^2+(Temp(i,2)-Temp(j,2))^2);%所有连线点的距离
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
%Va，b，c重新赋主干道
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


%第一波发射阶段
%出发地为D1

%D1到发射台i
for i=9:1:68    
        if i==9
            [distance1,path1] = mydijkstra(dist,1,i);%使用dijkstra  
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

%出发地为D2到发射台i
for i=9:1:68    
        if i==9
            [distance2,path2] = mydijkstra(dist,2,i);%使用dijkstra  
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

%distance为起点到终点的全局距离
distance=[distance1;distance2];
path=[path1;path2];
clear distance1 distance2 path1 path2 i;
 
% %查找具有相同终点的路径
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
% %查找具有相同终点的路径
% for i=1:1:120
%     for j=1:1:120
%         if (i~=j)&&(term(i,1)==term(j,1))
%             term(j,1)=0;
%         end
%     end
% end
% clear i j;
% 
% %将重复终点行充0
% for i=1:1:120
%     if term(i,1)==0
%         for j=1:1:20
%             path(i,j)=term(i,1)*path(i,j);
%         end
%     end
% end
% clear i j;

newpath=path(any(path'),:);%删除全为0行
newpath=newpath(:,any(newpath));%删除全为0列
[m,n]=size(newpath);
xlswrite('selpath.xls',newpath)
fprintf('有%d条路径可供选择，请打开selpath.xlsx文件查看\n',m);

%ABC分别在点-点距离矩阵行驶时间矩阵
ta=dist./Va;tb=dist./Vb;tc=dist./Vc;

%创建深度为60层的矩阵wp，每一层代表一个最短路径方案,wp(:,:,:)=1选路
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



%%%%%%%前往第一波导弹发射区%%%%%%%%%
%A类车
for k=1:1:m
    a=ta.*wp(:,:,k);
    a(isnan(a))=0;
    tta(:,:,k)=a;
    tTa(1,k)=sum(sum(tta(:,:,k)));
    clear a;
end

%Ta为A种车使用方案Ia时的最短时间
[Ta,Ia]=sort(tTa);
a=[Ta;Ia];
xlswrite('第一波发射timetable.xls',a,1);
clear a;
%一共要取6个index;
% fprintf('A类选择方案号\t花费时间\n');
% for i=1:1:6
%     fprintf('%d\t\t %d\n',Ia(i),Ta(i));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%B类车
for k=1:1:m
    a=tb.*wp(:,:,k);
    a(isnan(a))=0;
    ttb(:,:,k)=a;
    tTb(1,k)=sum(sum(tta(:,:,k)));
    clear a;
end

%Tb为B种车使用方案Ib时的最短时间
[Tb,Ib]=sort(tTa);
b=[Tb;Ib];

xlswrite('第一波发射timetable.xls',b,2);
clear b;
%一共要取6个index;
% fprintf('B类选择方案号\t花费时间\n');
% for i=1:1:12
%     fprintf('%d\t\t %d\n',Ib(i),Tb(i));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%C类车
for k=1:1:m
    a=tc.*wp(:,:,k);
    a(isnan(a))=0;
    ttc(:,:,k)=a;
    tTc(1,k)=sum(sum(ttc(:,:,k)));
    clear a;
end

%Tc为C种车使用方案Ic时的最短时间
[Tc,Ic]=sort(tTc);
c=[Tc;Ic];

xlswrite('第一波发射timetable.xls',c,3);
clear c;
%一共要取6个index;
% fprintf('C类选择方案号\t花费时间\n');
% for i=1:1:24
%     fprintf('%d\t\t %d\n',Ic(i),Tc(i));
% end
clear i k m n;


% clear wp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%数据人工处理
%%%%%%前往装载导弹区Z        %%%%%%%%%%%%%%%%
%发射台firstshot(i,3)到装弹区j
firstshot=[xlsread('firstshot_1.xlsx',1);xlsread('firstshot_1.xlsx',2);xlsread('firstshot_1.xlsx',3)];



for i=1:1:24  
    for j=3:1:8
        if i==1&&j==3
            [distance1,path1] = mydijkstra(dist,firstshot(i,3),j);%使用dijkstra  
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
path1=path1(:,any(path1));%删除全为0列

%%%%%%%%%%%%%%%%%%5
%发射台i到装弹区j的路径为path1，全局实际距离distance1
for i=1:1:24
    x(1,i)=Temp(firstshot(i,3),1);
    y(1,i)=Temp(firstshot(i,3),2);
end
% 第一波发射部署图
figure('name','第一次发射部署图');
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

%创建深度为144层的矩阵wpath，每一层代表一个最短路径方案,wp(:,:,:)=1选路
[m,n]=size(path1);
wp1=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path1(i,j+1)~=0
            wp1(path1(i,j),path1(i,j+1),i)=1; %有向路径
        end
    end
end
clear i j m n;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A类,fta每段路，fTa是方案k时的全局时间
for k=1:1:36
    a=ta.*wp1(:,:,k);
    a(isnan(a))=0;
    fta(:,:,k)=a;
    fTa(1,k)=sum(sum(fta(:,:,k)));
    clear a;
end

%Ta1为A种车使用方案Ia1时的最短时间
[Ta1,Ia1]=sort(fTa);
a=[Ta1;Ia1];
xlswrite('newtime1.xls',a,1);
clear a;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%B类,ftb每段路，fTb是方案k时的全局时间
for k=37:1:72
    a=tb.*wp1(:,:,k);
    a(isnan(a))=0;
    ftb(:,:,k)=a;
    fTb(1,k)=sum(sum(ftb(:,:,k)));
    clear a;
end

%Tb1为B种车使用方案Ib1时的最短时间
[Tb1,Ib1]=sort(fTb);
a=[Tb1;Ib1];
xlswrite('newtime1.xls',a,2);
clear a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%C类,ftc每段路，fTc是方案k时的全局时间
for k=73:1:144
    a=tc.*wp1(:,:,k);
    a(isnan(a))=0;
    ftc(:,:,k)=a;
    fTc(1,k)=sum(sum(ftc(:,:,k)));
    clear a;
end

%Tb1为B种车使用方案Ib1时的最短时间
[Tc1,Ic1]=sort(fTc);
a=[Tc1;Ic1];
xlswrite('newtime1.xls',a,3);
clear a k;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%第二波导弹发射
armloadtime=[xlsread('armloadtime_1.xlsx',1);xlsread('armloadtime_1.xlsx',2);xlsread('armloadtime_1.xlsx',3)];


for i=1:1:24
    x(1,i)=Temp(armloadtime(i,3),1);
    y(1,i)=Temp(armloadtime(i,3),2);
end
  

%%装弹部署图
figure('name','装弹部署图');
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

%注意firstshot(:,3)是不能用的点continue
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
                [distance2,path2] = mydijkstra(dist,i,j);%使用dijkstra  
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
path2=path2(:,any(path2));%删除全为0列

%创建深度为228的矩阵wpa2，每一层代表一个最短路径方案,wp2(:,:,:)=1选路
[m,n]=size(path2);
wp2=zeros(130,130,m);
for i=1:1:m
    for j=1:1:n-1
        if path2(i,j+1)~=0
            wp2(path2(i,j),path2(i,j+1),i)=1; %有向路径
        end
    end
end
clear i j m n;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%注意k的分配还未确定
%A类,fta每段路，fTa是方案k时的全局时间
for k=1:1:216
    a=ta.*wp2(:,:,k);
    a(isnan(a))=0;
    eta(:,:,k)=a;
    eTa(1,k)=sum(sum(eta(:,:,k)));
    clear a;
end

%Ta2为A种车使用方案Ia2时的最短时间
[Ta2,Ia2]=sort(eTa);
a=[Ta2;Ia2];
xlswrite('newtime2.xls',a,1);
clear a;
% 
%%B车
%B类,ftb每段路，fTb是方案k时的全局时间
for k=1:1:216
    a=tb.*wp2(:,:,k);
    a(isnan(a))=0;
    etb(:,:,k)=a;
    eTb(1,k)=sum(sum(etb(:,:,k)));
    clear a;
end

%Tb1为B种车使用方案Ib1时的最短时间
[Tb2,Ib2]=sort(eTb);
a=[Tb2;Ib2];
xlswrite('newtime2.xls',a,2);
clear a;
%%%%%%%%%%%%%%

%C类,ftc每段路，fTc是方案k时的全局时间
for k=1:1:216
    a=tc.*wp2(:,:,k);
    a(isnan(a))=0;
    etc(:,:,k)=a;
    eTc(1,k)=sum(sum(etc(:,:,k)));
    clear a;
end

%T1为B种车使用方案Ib1时的最短时间
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
%%第二次发射部署图
figure('name','第二次发射部署');
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
fprintf('整体暴露时间为：%d分钟\n',60*(sum(firstshot(:,2))+sum(armloadtime(:,2))+sum(secondshot(:,2))));
fprintf('单辆车暴露时间为：%d分钟\n',60*(max(firstshot(:,2))+max(armloadtime(:,2))+max(secondshot(:,2))));