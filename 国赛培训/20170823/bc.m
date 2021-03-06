function [pl,ql,pr,qr] = bc(xl,ul,xr,ur,t)
    % 边界条件向量。
    % 边界条件BC1: u(0,0,h,t) = 35;
    % 边界条件BC2: (?^2u/?z^2 + αu)在(0,0,h)处的值为 25 * k_1 / k.
    % 第三类边界条件（纽曼边界条件）：说明物体边界到热量与对流换热的能量平衡关系：
    k_water = 0.62;     % 水的热传导系数。W/m?K
    k_air = 0.023;      % 空气的热传导系数。
    alpha = k_air / k_water;
    pl = -35;
    pr = 1;
    %%%% ??????????? %%%%
    % 这个地方不会将第三类边界条件的方程转换成PDE工具箱的标准形式。
    % 设置为0方便调试程序。
    %%%% ??????????? %%%%
    ql = 0;
    qr = 0;
end