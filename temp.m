% function [min,path]=dijkstratest(w,start,terminal)
% n=size(w,1);label(start)=0;
% for i=1:n
%     if i~=start
%         label(i)=inf;
%     end
% end
% s(1)=start;u=start;
% while length(s)<n
%     for i=1:n
%         ins=0;
%         for j=1:length(s)
%             if i==s(j)
%                 ins=1;
%             end
%         end
%         if ins==0
%             v=i;
%             if label(v)>(label(u)+w(u,v))
%                 label(v)=(label(u)+w(u,v));
%                 f(v)=u;
%             end
%         end
%     end
%     v1=0;
%     k=inf;
%     for i=1:n
%         ins=0;
%         for j=1:length(s)
%             if i==s(j)
%                 ins=1;
%             end
%         end
%         if ins==0
%             v=i;
%             if k>label(v)
%                 k=label(v);
%                 v1=v;
%             end
%         end
%     end
%     s(length(s)+1)=v1;
%     u=v1;
% end
% min=label(terminal);
% path(1)=terminal;
% i=1;
% while path(i)~=start
%     path(i+1)=f(path(i));
%     i=i+1;
% end
% path(i)=start;
% L=length(path);
% path=path(L:-1:1);
n=75;w=zeros(n);
w(1,41)=9.73;
w(2,41)=6.94;
w(3,32)=4.88;
w(4,42)=6.02;
w(5,42)=4.00;
w(6,43)=5.60;
w(7,44)=9.70;
w(8,45)=7.02;
w(9,46)=5.19;
w(10,47)=6.17;
w(11,48)=10.39;
w(12,48)=5.32;
w(13,51)=5.20;
w(14,55)=3.83;
w(15,55)=7.08;
w(16,54)=5.55;
w(17,57)=6.52;
w(18,53)=4.18;
w(19,50)=5.05;
w(20,58)=4.51;
w(21,58)=4.22;
w(22,59)=5.14;
w(23,61)=5.31;
w(24,61)=5.90;
w(25,65)=4.62;
w(26,65)=8.42;
w(27,64)=5.19;
w(28,66)=7.30;
w(29,66)=5.43;
w(30,39)=5.83;
w(31,32)=7.64;w(31,42)=5.94;
w(32,31)=7.64;w(32,3)=4.88;w(32,69)=5.19;w(32,33)=8.03;w(32,43)=5.06;
w(33,32)=8.03;w(33,34)=7.06;w(33,74)=8.49;
w(34,33)=7.06;w(34,35)=7.40;w(34,45)=5.71;
w(35,34)=7.40;w(35,71)=6.38;w(35,50)=5.85;w(35,36)=4.99;
w(36,35)=4.99;w(36,37)=7.43;w(36,58)=3.49;w(36,59)=8.49;
w(37,36)=7.43;w(37,38)=5.29;w(37,62)=8.03;w(37,72)=6.40;
w(38,37)=5.29;w(38,39)=6.66;w(38,56)=10.07;
w(39,38)=6.66;w(39,40)=7.20;w(39,30)=5.83;
w(40,39)=7.20;w(40,68)=4.72;w(40,75)=7.48;
w(41,1)=9.73;w(41,2)=6.94;w(41,69)=6.20;
w(42,4)=6.02;w(42,5)=4.00;w(42,31)=5.94;
w(43,6)=5.60;w(43,44)=7.47;w(43,32)=5.06;
w(44,43)=7.47;w(44,7)=9.70;w(44,46)=8.40;
w(45,8)=7.02;w(45,34)=5.71;w(45,46)=8.19;w(45,70)=3.89;
w(46,9)=5.19;w(46,45)=8.19;w(46,47)=5.23;w(46,44)=8.40;
w(47,10)=6.17;w(47,46)=5.23;w(47,48)=6.04;w(47,49)=5.92;
w(48,11)=10.39;w(48,12)=5.32;w(48,47)=6.04;
w(49,47)=5.92;w(49,50)=5.57;w(49,51)=6.71;
w(50,49)=5.57;w(50,19)=5.05;w(50,35)=5.85;
w(51,13)=5.20;w(51,49)=6.71;w(51,52)=10.46;
w(52,18)=4.18;w(52,51)=10.46;w(52,53)=4.40;w(52,56)=7.65;w(52,72)=10.08;
w(53,52)=4.40;w(53,54)=2.28;w(53,57)=8.98;
w(54,16)=5.55;w(54,53)=2.28;w(54,55)=6.24;
w(55,14)=3.83;w(55,15)=7.08;
w(56,52)=7.65;w(56,38)=10.07;w(56,57)=4.53;
w(57,17)=6.52;w(57,53)=8.98;w(57,56)=4.53;
w(58,20)=4.51;w(58,21)=4.22;w(58,36)=3.49;
w(59,36)=8.49;w(59,22)=5.14;w(59,60)=3.63;
w(60,59)=3.63;w(60,62)=4.66;w(60,61)=4.44;
w(61,23)=5.31;w(61,24)=5.90;w(61,60)=4.44;
w(62,37)=8.03;w(62,60)=4.66;w(62,63)=5.41;
w(63,62)=5.41;w(63,64)=7.98;w(63,67)=6.15;
w(64,63)=7.98;w(64,27)=5.19;w(64,65)=4.39;
w(65,25)=4.62;w(65,26)=8.42;w(65,64)=4.39;
w(66,28)=7.30;w(66,29)=5.43;w(66,67)=5.86;w(66,73)=7.30;
w(67,66)=5.86;w(67,63)=6.15;w(67,68)=4.63;
w(68,40)=4.72;w(68,67)=4.63;w(68,73)=5.70;
w(69,41)=6.20;w(69,32)=5.19;
w(70,45)=3.89;
w(71,35)=6.38;
w(72,37)=6.40;w(72,52)=10.08;
w(73,66)=7.30;w(73,68)=5.70;
w(74,33)=8.49;
w(75,40)=7.48;
M=max(max(w))*n^2;
w=w+((w==0)-eye(75))*M;
[min,path]=dijkstratest(w,21,73);