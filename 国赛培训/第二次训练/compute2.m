%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: /Users/wangyang/mathematical-modeling/国赛培训/第二次训练/data.xlsx
%    工作表: data
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2017/08/29 12:58:54

%% 清空数据
clear;

%% 导入数据
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/国赛培训/第二次训练/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% 创建输出变量
data = reshape([raw{:}],size(raw));
m = size(data, 1);
score = data(:, 3:end); % 十道题得分矩阵。

%% 将导入的数组分配给列变量名称
TeacherNames = cellVectors(:,1);
CourseNames = cellVectors(:,2);

%% 
TecherNamesTable = unique(TeacherNames);

TeachMum = zeros(size(TecherNamesTable, 1), 1);
for i = 1:size(TecherNamesTable, 1)
    TeachCourse = {};
    for j = 1:m % 循环所有记录。
        if(isequal(TecherNamesTable(i), TeacherNames(j)))
            if(ismember(CourseNames(j), TeachCourse))
                ; % 不做事情。
            else
                TeachMum(i,1) = TeachMum(i,1) + 1;
                TeachCourse = [TeachCourse, CourseNames(j)];
            end
        end
    end
end

%% 生成表。
Names = {
    '教师姓名', '该老师教授的课程种类数'
};

result4(1, :) = Names;
result4(2:size(TecherNamesTable, 1)+1, :) = [TecherNamesTable, num2cell(TeachMum)]; 

%% 分组。
index_1 = (TeachMum==1);    % 只教一门课。
index_2 = (TeachMum==2);    % 只教两门课。
index_3 = (TeachMum==3);    % 只教三门课。

%% 计算与绘图。
% 只教一门课的所有老师在第一题上的平均得分

Group_1_Name = TecherNamesTable(index_1); 

len = size(Group_1_Name, 1);

for i = 1:len % 循环教师。
%    score_all = []; % 总分。
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
   
   for j = 1:m  % 循环记录数。
       if(isequal(Group_1_Name(i), TeacherNames(j)))     % 如果名称相等。
%            score_all = [score_all; total(j)];       % 将该老师的总分加入一个向量当中。
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
%        end
   end

   
   % 循环完了所有的记录，获得了数据。
%    var_score = var(score_all);
%    var_1 = var(problem1);
%    var_2 = var(problem2);
%    var_3 = var(problem3);
%    var_4 = var(problem4);
%    var_5 = var(problem5);
%    var_6 = var(problem6);
%    var_7 = var(problem7);
%    var_8 = var(problem8);
%    var_9 = var(problem9);
%    var_10 = var(problem10);
   
   % 方差求和。
   var_sum = sum([var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10]);
%    Alpha(i) = k / (k - 1) * (1 - (var_sum / var_score));
end
%% 清除临时变量
% clearvars data raw cellVectors;