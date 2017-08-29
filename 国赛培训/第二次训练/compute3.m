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

%% 把参评人数按0-500.500-1000.1000以上分类计算每一大类每个问题的得分均值。
featureNames = {
    '教学内容充实，注意推荐参考资料';
    '关注学科专业发展，能用最新科研成果充实、更新教学内容';
    '遵守教学纪律，按时上课，保证学时';
    '采用的教学方法能有效地启发学生思维，强调相关学科的思想，引导学生探究';
    '注意引导、激发学生对本课程的学习兴趣';
    '通过本课程学习，掌握了知识，开阔了视野，比学习之初更热爱本课程，收获大';
    '注意教学反馈，认真听取学生意见并加以改进';
    '教学认真负责，对学生要求严格，耐心解答疑问';
    '讲授娴熟，概念准确，条理清晰，重点突出，注意联系实际，引导学生学以致用';
    '合理使用板书和多媒体教学手段，有助于学生理解和掌握知识';
};

TecherNamesTable = unique(TeacherNames);
data_temp = zeros(size(TecherNamesTable, 1), 12);
count_temp = zeros(size(TecherNamesTable, 1), 1);

for i = 1:size(TecherNamesTable, 1) % 循环老师。
    for j = 1:m % 循环所有记录。
        if(isequal(TecherNamesTable(i), TeacherNames(j)))
            data_temp(i,:) = data_temp(i,:) + data(j, :);
            count_temp(i) = count_temp(i) + 1;
        end
    end
end

data_temp(:, 3:end) = data_temp(:, 3:end) ./ count_temp;

temp_count = zeros(4, 12);

count = zeros(4, 1);
temp_data_temp = data_temp;
for i = 1:size(temp_data_temp, 1) % 便利所有合并后的记录。
    if(temp_data_temp(i, 1) < 250)
        count(1, 1) = count(1, 1) + 1;
        temp_count(1,:) =  temp_count(1,:) + temp_data_temp(i, :);
    elseif (temp_data_temp(i, 1) < 500)
        count(2, 1) = count(2, 1) + 1;
        temp_count(2,:) =  temp_count(2,:) + temp_data_temp(i, :);
    elseif (temp_data_temp(i, 1) < 750)
        count(3, 1) = count(3, 1) + 1;
        temp_count(3,:) =  temp_count(3,:) + temp_data_temp(i, :);
    else
        count(4, 1) = count(4, 1) + 1;
        temp_count(4,:) =  temp_count(4,:) + temp_data_temp(i, :);
    end
end

temp_count(:, 3:end) = temp_count(:, 3:end) ./ count;

key = temp_count(:, 3:end);

% 按照参评人数划分四个等级。
result10(1:5,1) = {
    '属性名';
    '参评人数小于250人';
    '参评人数大于等于250人且小于500人';
    '参评人数大于等于500人且小于750人';
    '参评人数大于等于750人';
};

result10(1, 2:11) = featureNames;
result10(2:end, 2:end) = num2cell(key);

count_2 = zeros(5, 1);
temp_data_temp_2 = data_temp;
temp_count_2 = zeros(5, 12);
for i = 1:size(temp_data_temp_2, 1) % 便利所有合并后的记录。
    if(temp_data_temp_2(i, 2) < 250)
        count_2(1,1) = count_2(1, 1) + 1;
        temp_count_2(1,:) =  temp_count_2(1,:) + temp_data_temp_2(i, :);
    elseif (temp_data_temp_2(i, 2) < 500)
        count_2(2,1) = count_2(2, 1) + 1;
        temp_count_2(2,:) =  temp_count_2(2,:) + temp_data_temp_2(i, :);
    elseif (temp_data_temp_2(i, 2) < 750)
        count_2(3,1) = count_2(3, 1) + 1;
        temp_count_2(3,:) =  temp_count_2(3,:) + temp_data_temp_2(i, :);
    elseif (temp_data_temp_2(i, 2) < 1000)
        count_2(4,1) = count_2(4, 1) + 1;
        temp_count_2(4,:) =  temp_count_2(4,:) + temp_data_temp_2(i, :);
    else
        count_2(5,1) = count_2(5, 1) + 1;
        temp_count_2(5,:) =  temp_count_2(5,:) + temp_data_temp_2(i, :);
    end
end

temp_count_2(:, 3:end) = temp_count_2(:, 3:end) ./ count_2;

key_2 = temp_count_2(:, 3:end);

% 按照参评人数划分四个等级。
result11(1:6,1) = {
    '属性名';
    '班级规模小于250人';
    '班级规模大于等于250人且小于500人';
    '班级规模大于等于500人且小于750人';
    '班级规模大于等于750人且小于1000人';
    '班级规模大于等于1000人';
};

result11(1, 2:11) = featureNames;
result11(2:end, 2:end) = num2cell(key_2);

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
   % 循环完了所有的记录，获得了数据。
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



%% 清除临时变量
% clearvars data raw cellVectors;