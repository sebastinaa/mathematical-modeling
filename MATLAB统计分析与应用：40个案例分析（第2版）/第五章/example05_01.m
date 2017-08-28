%% 读取文件examp02_14.xls中的第一个工作表中的G2:G52中的数据，即总成绩数据。
score = xlsread('examp02_14.xls', 'Sheet1', 'G2:G52');

score = score(score>0); % 去掉大于零的部分。

%% 计算平均值。
score_mean = mean(score); % 计算平均值。

%% 方差的标准差。
% 方差
ss1 = var(score);   % 计算分母为n-1。

ss1 = var(score, 0);    % 计算分母为n-1。

ss2 = var(score, 1);    % 计算分母为n。

ss3 = std(score);    % 计算分母为n-1。

ss3 = std(score, 0);    % 计算分母为n-1。

ss4 = std(score, 1);    % 计算分母为n。

%% 计算最大值和最小值。
score_max = max(score);

score_min = min(score);

%% 极差

score_range = range(score);

%% 中位数

score_median = median(score);

