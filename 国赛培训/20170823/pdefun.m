function [c,f,s] = pdefun(z,t,u,dudx)
% 偏微分方程的系数向量函数。
    c_water = 4.2;
    % 水的比热容：环境是在标准大气压下的，水的比热容不随温度变化。单位：千焦每千克摄氏度。
    p_water = 1000;
    % 水的密度，10^3千克/立方米。
    k_water = 0.62;
    % 水的热传导系数。W/m?K
    c = (c_water*p_water) / k_water;
    c = c * c;
    f = dudx;
    s = 0;
end