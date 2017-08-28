%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: /Users/wangyang/mathematical-modeling/国赛培训/第二次训练/data.xlsx
%    工作表: data
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2017/08/28 21:30:56

%% 导入数据
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/国赛培训/第二次训练/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% 创建输出变量
data = reshape([raw{:}],size(raw));

%% 将导入的数组分配给列变量名称
VarName1 = cellVectors(:,1);
VarName2 = cellVectors(:,2);
VarName3 = data(:,1);
VarName4 = data(:,2);
VarName5 = data(:,3);
VarName6 = data(:,4);
VarName7 = data(:,5);
VarName8 = data(:,6);
VarName9 = data(:,7);
VarName10 = data(:,8);
VarName11 = data(:,9);
VarName12 = data(:,10);
VarName13 = data(:,11);
VarName14 = data(:,12);

%% 清除临时变量
clearvars data raw cellVectors;