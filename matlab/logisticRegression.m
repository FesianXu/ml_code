%%%
% Author:FesianXu
% 实现logistic回归二值分类器
%%%
clc
clear
close all
isnew = 'no' ; % 选择数据来源，yes自己绘制，no读取保存的文件，左键确定新的样本，右键换颜色，再点一次右键退出
%% get samples
pos_path = './data_set/human_generate/logistic_posset_mat.mat';
neg_path = './data_set/human_generate/logistic_negset_mat.mat';
if strcmp(isnew,'yes')
    [pos,neg] = getSample2D() ;
    save(pos_path,'pos');
    save(neg_path,'neg');
elseif strcmp(isnew,'no')
    pos = cell2mat(struct2cell(load(pos_path))) ;
    neg = cell2mat(struct2cell(load(neg_path))) ;
end
sample_mat = zeros(length(pos(:,1))+length(neg(:,1)), 4) ;
sample_mat(1:length(pos(:,1)),1:2) = pos ;
sample_mat(1:length(pos(:,1)),4) = 1 ;
sample_mat(1+length(pos(:,1)):end,1:2) = neg ;
sample_mat(1+length(pos(:,1)):end,4) = -1 ;
sample_mat(:,3) = 1 ;

%% train
alpha = 0.6;
sigmoid = @(x) 1./(1+exp(-x)) ; % sigmoid function
w = rand(1,3) ;
for i = 10000*3
    
end


%% plot
figure
plot(sample_mat(1:length(pos(:,1)),1),sample_mat(1:length(pos(:,1)),2),'r*')
axis([0,10,0,10])
hold on
grid on
plot(sample_mat(length(pos(:,1))+1:end,1),sample_mat(length(pos(:,1))+1:end,2),'b*')
axis([0,10,0,10])










