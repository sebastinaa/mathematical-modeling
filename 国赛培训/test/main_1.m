x =linspace(0,1,20); %x 取 20 点
t=linspace(0,2,5); %时间取 5 点输出
m=0; %依步骤 1 之结果
sol=pdepe(m,@ex20_1pdefun,@ex20_1ic,@ex20_1bc,x,t);
% 步骤 7 显示结果。
u=sol(:,:,1);
surf(x,t,u)
title('pde 数值解')
xlabel('位置')
ylabel('时间' )
zlabel('u')

figure(2); %绘成图 2
M=length(t); %取终点时间的下标
xout=linspace(0,1,100); %输出点位置
[uout,dudx]=pdeval(m,x,u(M,:),xout);
plot(xout,uout); %绘图
title('时间为 2 时,各位置下的解')
xlabel('x')
ylabel('u')