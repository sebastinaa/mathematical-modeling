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

for i = 1:len % 循环教师。   
   for j = 1:m  % 循环记录数。
       if(isequal(Group_1_Name(i), TeacherNames(j)))     % 如果名称相等。
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
end

mean_1(1) = mean(problem1);
mean_1(2) = mean(problem2);
mean_1(3) = mean(problem3);
mean_1(4) = mean(problem4);
mean_1(5) = mean(problem5);
mean_1(6) = mean(problem6);
mean_1(7) = mean(problem7);
mean_1(8) = mean(problem8);
mean_1(9) = mean(problem9);
mean_1(10) = mean(problem10);

% 教两门课。
Group_2_Name = TecherNamesTable(index_2); 

len = size(Group_2_Name, 1);

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

for i = 1:len % 循环教师。   
   for j = 1:m  % 循环记录数。
       if(isequal(Group_2_Name(i), TeacherNames(j)))     % 如果名称相等。
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
end

mean_2(1) = mean(problem1);
mean_2(2) = mean(problem2);
mean_2(3) = mean(problem3);
mean_2(4) = mean(problem4);
mean_2(5) = mean(problem5);
mean_2(6) = mean(problem6);
mean_2(7) = mean(problem7);
mean_2(8) = mean(problem8);
mean_2(9) = mean(problem9);
mean_2(10) = mean(problem10);

% 教三门课。
Group_3_Name = TecherNamesTable(index_3); 

len = size(Group_3_Name, 1);

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

for i = 1:len % 循环教师。   
   for j = 1:m  % 循环记录数。
       if(isequal(Group_3_Name(i), TeacherNames(j)))     % 如果名称相等。
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
end

mean_3(1) = mean(problem1);
mean_3(2) = mean(problem2);
mean_3(3) = mean(problem3);
mean_3(4) = mean(problem4);
mean_3(5) = mean(problem5);
mean_3(6) = mean(problem6);
mean_3(7) = mean(problem7);
mean_3(8) = mean(problem8);
mean_3(9) = mean(problem9);
mean_3(10) = mean(problem10);

%% 表
result5(1, :) = {
    '题目', '教一门课', '教两门课', '教三门课'
};

result5(2:10+1, 1) = {
    '问题1';
    '问题2';
    '问题3';
    '问题4';
    '问题5';
    '问题6';
    '问题7';
    '问题8';
    '问题9';
    '问题10';
};

result5(2:end, 2) = num2cell(mean_1);
result5(2:end, 3) = num2cell(mean_2);
result5(2:end, 4) = num2cell(mean_3);