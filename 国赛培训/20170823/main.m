% 网格计算思想。
x=linspace(0,15,3600); %x 取 20 点
t=linspace(0,3600,3600); 
% 1小时内每一秒取一点来计算。
h = 20;
% 水杯中水的面离坐标原点的高度，单位：米。
c_water = 4.2;  
% 水的比热容：环境是在标准大气压下的，水的比热容不随温度变化。单位：千焦每千克摄氏度。
p_water = 1000;
% 水的密度，10^3千克/立方米。
k_water = 0.62;
% 水的热传导系数。W/m K
k_air = 0.023;
% 0.023W/m k 

m=2;

sol = pdepe(m, @pdefun, @ic, @bc, x, t);
u=sol(:,:,1);
surf(x, t, u)
title('pde的数值解:')
xlabel('z(位置)')
ylabel('t(时间)' )
zlabel('u(温度)')
