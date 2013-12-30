%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 问题二：仿真一周期内多普勒中心频率与纬度关系图
% 问题三：仿真一周期内多普勒调频率与纬度关系图
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
load wenti1; %使用问题设置的参数
lamda=24*10^(-2); %雷达为L波段,波长24cm题目给的波段单位应该是错的MHz
we=2*pi/(24*3600); %角速度，地球同步轨道
rst=514000; %轨道高度514公里
Hg=0; %Greenwich时角为0
thy=0; %滚动角，俯仰角，偏航角始终为0
thp=0;
thr=0;
%--------------------------------------------------------------------------
Aog=[cos(Hg),-sin(Hg),0;sin(Hg),cos(Hg),0;0,0,1];
Avo=Rw*Ri*Romega;
Aov=inv(Avo);
hangji=e*sin(f)./(1+e*cos(f)); %航迹角
Arv=zeros(3,3*length(f)); %第一，二，三行分别存放X，Y，Z分量
j=1;
for i=1:length(f)
thi=f(i)-hangji(i);
Avr(1,j:j+2)=[cos(thi),sin(thi),0];
Avr(2,j:j+2)=[-sin(thi),cos(thi),0];
Avr(3,j:j+2)=[0,0,1];
j=j+3;
end %每三行三列表示某一时刻的变换矩阵
Ay=[1,0,0;0,cos(thy),sin(thy);0,-sin(thy),cos(thy)];
Ap=[cos(thp),sin(thp),0;-sin(thp),cos(thp),0;0,0,1];
Ar=[cos(thr),0,sin(thr);0,1,0;-sin(thr),0,cos(thr)];
Aer=Ay*Ap*Ar;
Are=Aer;
Aea=[1,0,0;0,cos(aten),sin(aten);0,-sin(aten),cos(aten)];
Rs=Aov*[r.*cos(f);r.*sin(f);zeros(size(f))];
Vs=Aov*(sqrt(G*M/a/(1-e^2)).*[-sin(f);e+cos(f);zeros(size(f))]);
As=Aov*(G*M/a^2/(1-e^2)^2.*[-cos(f);-sin(f);zeros(size(f))]);
Rtt=zeros(3,10001);
j=1;
for i=1:length(f)
Rtt(:,i)=Aov*Are*Aea*Avr(:,j:j+2)*[0;rst;0];
j=j+3;
end
Rt=Rtt+Rs;
Vt=zeros(3,10001); %计算目标点的速度Vt
Vt=[-we,0,0;0,we,0;0,0,0]*Rt;
At=zeros(3,10001);
At=[-we^2,0,0;0,-we^2,0;0,0,0]*Vt; %计算目标点的加速度At
%--------------------------------------------------------------------------
% 计算多普勒中心频率fd
%--------------------------------------------------------------------------
fd=2./lamda.*sum((Rs-Rt).*(Vs-Vt))./r;
%--------------------------------------------------------------------------
% 计算多普勒调频率fr
%--------------------------------------------------------------------------
fr=2./lamda*(sum((Vs-Vt).^2)./r+(sum((As-At).*(Vs-Vt)))./r-(sum((Rs-Rt).*(Vs-Vt))./r.^3).^2);
%--------------------------------------------------------------------------
figure
plot(T,fd)
title('多普勒中心频率fd与经纬度关系图')
figure
plot(T,fr)
title('多普勒调频率fr与经纬度关系图')
