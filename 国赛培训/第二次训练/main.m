%% 清除所有变量。
clear;

%% 导入数据。
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/国赛培训/第二次训练/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% 创建输出变量。
data = reshape([raw{:}],size(raw));

%% 将导入的数组分配给列变量名称。
Teacher = cellVectors(:,1);     % 教师姓名。
Course = cellVectors(:,2);      % 课程名。
C = data(:, 1);     % 已评人数。
D = data(:, 2);     % 班级规模。


E = data(:, 3);     % 教学内容充实，注意推荐参考资料。
F = data(:, 4);     % 关注学科专业发展，能用最新科研成果充实、更新教学内容。
G = data(:, 5);     % 遵守教学纪律，按时上课，保证学时。
H = data(:, 6);     % 采用的教学方法能有效地启发学生思维，强调相关学科的思想，引导学生探究。
I = data(:, 7);     % 注意引导、激发学生对本课程的学习兴趣。
J = data(:, 8);     % 通过本课程学习，掌握了知识，开阔了视野，比学习之初更热爱本课程，收获大。
K = data(:, 9);     % 注意教学反馈，认真听取学生意见并加以改进。
L = data(:, 10);    % 教学认真负责，对学生要求严格，耐心解答疑问。
M = data(:, 11);    % 讲授娴熟，概念准确，条理清晰，重点突出，注意联系实际，引导学生学以致用。
N = data(:, 12);    % 合理使用板书和多媒体教学手段，有助于学生理解和掌握知识。
P = C ./ D * 10;	% 参评率，满分10分。

% 特征的名称。
featureNames = {
    '已评人数';
    '班级规模';
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

%% 数据的平移-标准差化。
m = size(data, 1);  % 记录数。
n = size(data, 2);  % 记录的特征数。 

X= [E F G H I J K L M N P]; % 重新定义矩阵。

X_standard = zscore(X);  % 矩阵的标准化。

X_R = corrcoef(X_standard); % 计算相关系数。

[vec, lambda, rate] = pcacov(X_R); % 利用相关系数进行主成分析，vec的列为相关系数的特征向量，既主成分系数。

% lambda 为特征值，rate为各成分的贡献率。

contr = cumsum(rate); % 计算累计贡献率。

f = repmat(sign(sum(vec)), size(vec, 1), 1); % 构造与vec相同维数的符号矩阵。

vec_2 =vec .* f; % 修改特征向量的符号，使得每个向量的分量和为正。

num = 3; % 主成分的份数。

df = X_standard * vec_2(:,1:num);

tf = df * rate(1:num) / 100; % 计算综合得分。

[stf,ind] = sort(tf, 'descend');

%% 给出排序结果。
i = 1:m;
i = i';
result0(1,1:3) = {
    '原始数据表中的排序号';
    '得分';
    '次序';
};
result0(2:m+1,1:3) = num2cell([i, tf, ind]);

%% 显示结果。

result1(1, :) = {
    '特征值', '差值', '贡献率', '累计贡献率'
};
result1(2:size(lambda, 1) + 1,1) = num2cell(lambda);
result1(2:size(lambda, 1), 2) = num2cell(-diff(lambda));
result1(2:size(lambda, 1) + 1,3:4) = num2cell([rate, cumsum(rate)]);

%% 标准化变量。
s = {
    '标准化变量', 'x1', 'x2', 'x3', 'x4', 'x5', 'x6', 'x7', 'x8', 'x9', 'x10', 'x11'
};

result2(:, 1) = s;

f=[];
for i=1:num
    Frame_Name = ['主成分' num2str(i)];
    f = [f;Frame_Name];
end

result2(1, 2:num + 1) = cellstr(f);
result2(2:end, 2:num + 1) = num2cell(vec_2(:,1:num));

%% 绘图。
x = 1:size(contr, 1);
plot(x, contr','.-') % 累计贡献值的图。
title('主成分选取个数与累计贡献值');
xlabel('主成分选取个数');
ylabel('累计贡献值');

%% 计算多少名老师，多少种课程。
TeacherNames = unique(Teacher);
NumberOfTeachers = size(TeacherNames, 1); % 计算有多少教师。
TypeOfCourse = unique(Course); % 计算有多少种课程。

%% 计算每类课程各自的平均值。
NumberOfCourseTypes = size(TypeOfCourse, 1); % 课程种类数。
MeanCourse = zeros(NumberOfCourseTypes, n); % 记录每门课程各项的平均值矩阵。
NumberOfCourse = zeros(NumberOfCourseTypes, 1); % 记录每门课成的班级数。

for i = 1:NumberOfCourseTypes % 循环每中课程。
    for j = 1:m % 循环每个原始数据。
        if(isequal(TypeOfCourse(i), Course(j))) % 如果课程名相同。
            MeanCourse(i,:) = MeanCourse(i,:) + data(j,:);
            NumberOfCourse(i) = NumberOfCourse(i) + 1;
        end
    end
end

MeanCourse = MeanCourse ./ NumberOfCourse; % 计算每种课程的平均值。

%% 课程类型及其同类平均分表。
Courses = ['课程名'; featureNames];
Courses = [Courses'; [TypeOfCourse,num2cell(MeanCourse)]]; % 课程类型及其同类平均分。

%% 计算每个老师教多少个班，多少人。

NumberTeacherNames = size(TeacherNames, 1); %老师个数。
NumberClassTeacherTeach = zeros(NumberTeacherNames, 1); %老师教的班级数目。
TeacherTeachStu = zeros(NumberTeacherNames, 1); % 老师教的人数。

for i = 1:NumberTeacherNames
    for j = 1:m
       if(isequal(TeacherNames(i), Teacher(j))) 
           TeacherTeachStu(i) = TeacherTeachStu(i) + D(j);
           NumberClassTeacherTeach(i) = NumberClassTeacherTeach(i) + 1;
       end
    end
end

Teachers = {
    '教师姓名';
    '教授学生人数';
    '教授班数';
}';

% 教师部分信息表。
Teachers = [Teachers; [TeacherNames, num2cell([TeacherTeachStu, NumberClassTeacherTeach])]];

%% 清楚所有变量
% clear;