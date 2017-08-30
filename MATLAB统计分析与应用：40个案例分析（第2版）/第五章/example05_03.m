%% 5.3 案例12：描述性统计量。



%% 读取文件'examp02_14.xls'中的第一个工作表中的G2:G52中的数据，即总成绩数据。
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

%% 分位数
% 将样本从小到大排序。
score_m1 = quantile(score, [0.25, 0.5, 0.75]);
% 求样本的0.25，0.5和0.75分位数。
% 0.5分位数就是样本的中位数。

score_m2 = prctile(score, [25, 50, 75]);
% 求样本的25%，50%和75%分位数。

%% 众数
% 出现次数最多的数。
score_mode = mode(score);

%% 变异系数

% 变异系数是衡量数据资料中各变量观测值变异程度的一个统计量。
% 标准差与平均值的比值。
score_cvar = std(score) / mean(score);


%% 原点矩
% 一阶原点矩就是样本均值。
A2 = mean(score .^ 2);

%% 中心矩
% 一阶中心距为0，二阶中心距为样本方差（分母为N）？
B1 = moment(score, 1);

%% 偏度
% 样本的偏度反应了总体分布的对称性，偏度越接近0，说明分布越对称。
score_skewnness = skewness(score);

%% 峰度
% 样本峰度反应了总体分布密度曲线在其峰值附近的陡峭程度。
score_kurtsis = kurtosis(score);

%% 协方差
% cov(X, Y) = E[(X - E(X)) * (Y - E(Y))]
% 协方差描述的变量间的相关程度的统计量。
XY = xlsread('examp02_14.xls', 'Sheet1', 'E2:F52');
XY = XY(all(XY>0.2), :);
covXY = cov(XY);
% 对角线为方差。

%% 相关系数
% 用协方差描述变量间的相关程度会受到变量的量纲和数量级的影响，即使对同样的一组变量，
% 当变量的量纲和数量级发生变化时，协方差也会随之改变。
% 所以，先读变量进行标准化变换之后，然后再计算协方差。把标准化变量间的协方差定义为变量间的相关系数。
% 相关系数是一个无单位的量，其绝对值不超过1，它描述了变量间的线性相关程度。
% 当变量的相关系数为0时，变量间不存在线性趋势，但可能存在非线性趋势关系；
% 当变量间的相关系的绝对值为1时，一个变量是另一个变量的线性函数；
% 当变量间相关系数的绝对值越接近1时，变量间线性趋势越明显。
Rxy = corrcoef(XY);