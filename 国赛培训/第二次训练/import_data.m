%% 清除所有变量。
clear;

%% 导入电子表格中的数据。
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: /Users/wangyang/mathematical-modeling/国赛培训/第二次训练/data.xlsx
%    工作表: data
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2017/08/28 21:30:56

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

% for i = 1:n
%     temp = data(:,i);
%     data(:,i) = (temp - mean(temp)) / std(temp);
% end

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

%% 清除临时变量
% clearvars data raw cellVectors;

%% 清楚所有变量
% clear;