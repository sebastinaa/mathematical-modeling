%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: /Users/wangyang/mathematical-modeling/国赛培训/第三次训练/新评教系统下的数据供学生参考.xlsx
%    工作表: Sheet1
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2017/08/31 10:11:36
%% 清楚数据
clear;

%% 导入数据
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/国赛培训/第三次训练/新评教系统下的数据供学生参考.xlsx','Sheet1');
raw = raw(3:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10]);

%% 创建输出变量
data = reshape([raw{:}],size(raw));
m = size(data, 1);  % 数据条数。

%% 将导入的数组分配给列变量名称
TeacherName = cellVectors(:,1);   % 教师姓名。
CourseName = cellVectors(:,2);    % 评估内容(课程名)。
Number_Of_Judges = data(:,1);     % 已评人数。
Class_Size = data(:,2);           % 班级规模。
x_1 = data(:,3);            % 评估内容（关于课程，评分）。
x_2 = data(:,4);            % 授课中常应用多种相关例证、提出引发思考的问题，组织课堂讨论。
x_3 = data(:,5);            % 多媒体制作优秀?板书规范而清晰。
x_4 = data(:,6);            % 尊重并且公平公正对待每一个学生。
x_5 = data(:,7);            % 愿意在课堂外通过多种方式帮助学生。
x_6 = data(:,8);            % 我从这门课学到许多东西并对该学科更感兴趣。


% score = [x_1, x_2, x_3, x_4, x_5, x_6, x_7];
score = [x_1, x_2, x_3, x_4, x_5, x_6]; % 不采用参评率。

%% 计算老师数量
UniqueTeacherName = unique(TeacherName);    % 计算老师人数。
UniqueTeacherNameNum = size(UniqueTeacherName, 1);

UniqueCourseName = unique(CourseName);
UniqueCourseNameNum = size(UniqueCourseName, 1);

%% 分类前

X_standard_1 = zscore(score); % 标准化。
X_R_1 = corrcoef(X_standard_1); % 计算相关系数。

[vec_1, lambda_1, rate_1] = pcacov(X_R_1); % 利用相关系数进行主成分析，vec的列为相关系数的特征向量，既主成分系数。
% lambda 为特征值，rate为各成分的贡献率。

contr_1 = cumsum(rate_1); % 计算累计贡献率。

f = repmat(sign(sum(vec_1)), size(vec_1, 1), 1); % 构造与vec相同维数的符号矩阵。

vec_1_2 =vec_1 .* f; % 修改特征向量的符号，使得每个向量的分量和为正。

%% 选取主成分个数

num_1 = 1;

df_1 = X_standard_1 * vec_1_2(:,1:num_1);

% p1_1 = df_1(:, 1)';
% p2_1 = df_1(:, 2)';

% figure;
% scatter(p1_1, p2_1,'o');
% title('选取两个主成分之后绘制散点图')
% xlabel('主成分1')
% ylabel('主成分2')
% text(p1_1, p2_1, TeacherName);

tf_1 = df_1 * rate_1(1:num_1) / 100; % 计算综合得分。

[stf_1 ,ind_1] = sort(tf_1, 'descend');

%% 显示结果

result1(1, :) = {
    '特征值', '差值', '贡献率', '累计贡献率'
};
result1(2:size(lambda_1, 1) + 1,1) = num2cell(lambda_1);
result1(2:size(lambda_1, 1), 2) = num2cell(-diff(lambda_1));
result1(2:size(lambda_1, 1) + 1,3:4) = num2cell([rate_1, cumsum(rate_1)]);

%% 绘图。
x_temp1 = 1:size(contr_1, 1);
figure;
plot(x_temp1, contr_1','.-') % 累计贡献值的图。
title('主成分选取个数与累计贡献值');
xlabel('主成分选取个数');
ylabel('累计贡献值');

%% 按课程分类计算并标准化。
X = [];
X = [Number_Of_Judges, Class_Size, x_1, x_2, x_3, x_4, x_5, x_6];

MeanCourse = zeros(UniqueCourseNameNum, 8);     % 记录每门课程各项的平均值矩阵。班级规模，参评人数不平均，不累加参评率。
P = zeros(UniqueCourseNameNum, 1);              % 参评率。
count = zeros(UniqueCourseNameNum, 1);          % 计数。

X_new = [];
for i = 1:UniqueCourseNameNum % 循环每中课程。
    temp = [];
    for j = 1:m % 循环每个原始数据。
        if(isequal(UniqueCourseName(i), CourseName(j))) % 如果课程名相同。
            count(i,1) = count(i,1) + 1;    % 计数。
            MeanCourse(i, :) = MeanCourse(i, :) + X(j, :);
            temp = [temp; X(j, :)];
        end % 循环完所有记录，则已经分好类。
    end
%     temp = [temp(:, 3:end), temp(:, 1) ./ temp(:, 2)];
    temp = [temp(:, 3:end)]; % 不采用参评率。
    X_new = [X_new; zscore(temp)];  % 加入新的矩阵中。
end

MeanCourse(:, 3:end) = MeanCourse(:, 3:end) ./ count; % 该类课程的6项指标的平均分，以及总参评人数以及总班级规模。
P = MeanCourse(:, 1) ./ MeanCourse(:, 2); % 该类课程的平均参评率。 总参评人数/总班级规模。

MeanCourse = [MeanCourse, P];

result4(1, 1:2) = {'课程名', '授课教师数'};
result4(2:6, 1) = UniqueCourseName;
result4(2:6, 2) = num2cell(count);

%% 显示
featureNames = {
    '已评人数';
    '班级规模';
    '评估内容';
    '授课中常应用多种相关例证、提出引发思考的问题，组织课堂讨论。';
    '多媒体制作优秀?板书规范而清晰。';
    '尊重并且公平公正对待每一个学生。';
    '愿意在课堂外通过多种方式帮助学生。';
    '我从这门课学到许多东西并对该学科更感兴趣。';
    '总体参评率';
};

result2(1,1) = {'课程名'};
result2(2:6,1) = UniqueCourseName;
result2(1, 2:10) =  featureNames;
result2(2:6,2:end) = num2cell(MeanCourse);
%% 分类后
X_standard_2 = X_new;

X_R_2 = corrcoef(X_standard_2); % 计算相关系数。

[vec_2, lambda_2, rate_2] = pcacov(X_R_2); % 利用相关系数进行主成分析，vec的列为相关系数的特征向量，既主成分系数。

% lambda 为特征值，rate为各成分的贡献率。

contr_2 = cumsum(rate_2); % 计算累计贡献率。

f_2 = repmat(sign(sum(vec_2)), size(vec_2, 1), 1); % 构造与vec相同维数的符号矩阵。

vec_2_2 =vec_2 .* f_2; % 修改特征向量的符号，使得每个向量的分量和为正。

num_2 = 1; % 主成分的份数。

df_2 = X_standard_2 * vec_2_2(:,1:num_2); % 降维后的主成分。

% p1_2 = df_2(:, 1)';
% p2_2 = df_2(:, 2)';
% 
% figure;
% scatter(p1_2, p2_2,'o');
% text(p1_2, p2_2, TeacherName);
% title('分类之后两个主成分的散点图');
% xlabel('主成分1');
% ylabel('主成分2');

tf_2 = df_2 * rate_2(1:num_2) / 100; % 计算综合得分，根据主成分及其内容。

[stf_2,ind_2] = sort(tf_2, 'descend');

%% 绘图。
figure;
x_temp2 = 1:size(contr_2, 1);
plot(x_temp2, contr_2','.-') % 累计贡献值的图。
title('分类之后主成分选取个数与累计贡献值');
xlabel('主成分选取个数');
ylabel('累计贡献值');

%% 显示结果
result3(1, :) = {
    '特征值', '差值', '贡献率', '累计贡献率'
};
result3(2:size(lambda_2, 1) + 1,1) = num2cell(lambda_2);
result3(2:size(lambda_2, 1), 2) = num2cell(-diff(lambda_2));
result3(2:size(lambda_2, 1) + 1,3:4) = num2cell([rate_2, cumsum(rate_2)]);

%% 清除临时变量
clearvars data raw cellVectors;