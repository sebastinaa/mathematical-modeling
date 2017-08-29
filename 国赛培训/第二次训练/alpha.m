%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本: 将电子表格按名称排序之后再导入数据。
%
%    工作簿: /Users/wangyang/mathematical-modeling/国赛培训/第二次训练/sort.xlsx
%    工作表: data
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2017/08/29 12:03:04

%% 清空数据。
clear;

%% 导入数据
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/国赛培训/第二次训练/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% 创建输出变量
data = reshape([raw{:}],size(raw));

%% 将导入的数组分配给列变量名称
Teacher = cellVectors(:,1);
VarName2 = cellVectors(:,2);
m = size(data, 1);  % 记录数。
score = data(:, 3:end); % 十道题得分矩阵。

%% 计算每一行的总分。
total = sum(score')';

%% 对于教授课程班数大于1的进行系数计算。

TeacherNames = unique(Teacher);
NumberOfTeachers = size(TeacherNames, 1); % 计算有多少教师。

NumberTeacherNames = size(TeacherNames, 1); %老师个数。
NumberClassTeacherTeach = zeros(NumberTeacherNames, 1); %老师教的班级数目。
TeacherTeachStu = zeros(NumberTeacherNames, 1); % 老师教的人数。

for i = 1:NumberTeacherNames
    for j = 1:m
       if(isequal(TeacherNames(i), Teacher(j))) 
%            TeacherTeachStu(i) = TeacherTeachStu(i) + D(j);
           NumberClassTeacherTeach(i) = NumberClassTeacherTeach(i) + 1;
       end
    end
end

%% 得到教授课程数量大于1的数据。（老师和所教授的课程）

index = (NumberClassTeacherTeach > 1); % 下标。

TeacherNames = TeacherNames(index);
NumberClassTeacherTeach = NumberClassTeacherTeach(index);

Teachers = {
    '教师姓名';
    '教授学生人数';
    '教授班数';
}';

%% 计算系数。
len = size(TeacherNames, 1); % 教师数目。
Alpha = zeros(len, 1);
k = 10;
for i = 1:len % 循环教师。
   score_all = []; % 得分。
   problem1 = [];
   problem2 = [];
   problem3 = [];
   problem4 = [];
   problem5 = [];
   problem6 = [];
   problem7 = [];
   problem8 = [];
   problem9 = [];
   problem10 = [];
   
   for j = 1:m % 循环记录数。
       if(isequal(TeacherNames(i), Teacher(j))) % 如果名称相等。
           score_all = [score_all; total(j)]; % 将该老师的总分加入一个向量当中。
           problem1 = [problem1; score(j, 1)];
           problem2 = [problem2; score(j, 2)];
           problem3 = [problem3; score(j, 3)];
           problem4 = [problem4; score(j, 4)];
           problem5 = [problem5; score(j, 5)];
           problem6 = [problem6; score(j, 6)];
           problem7 = [problem7; score(j, 7)];
           problem8 = [problem8; score(j, 8)];
           problem9 = [problem9; score(j, 9)];
           problem10 = [problem10; score(j, 10)];
       end
   end
   % 循环完了所有的记录，获得了数据。
   var_score = var(score_all);
   var_1 = var(problem1);
   var_2 = var(problem2);
   var_3 = var(problem3);
   var_4 = var(problem4);
   var_5 = var(problem5);
   var_6 = var(problem6);
   var_7 = var(problem7);
   var_8 = var(problem8);
   var_9 = var(problem9);
   var_10 = var(problem10);
   
   % 方差求和。
   var_sum = sum([var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10]);
   
   Alpha(i) = k / (k - 1) * (1 - (var_sum / var_score));
end

%% 表。
Names = {
    '教师姓名', '信度系数'
};

result3(1, :) = Names;
result3(2:len+1, :) = [TeacherNames, num2cell(Alpha)]; 

%% 绘图
hist(Alpha);
title('信度系数及人数分布直方图');
xlabel('信度系数');
ylabel('人数');