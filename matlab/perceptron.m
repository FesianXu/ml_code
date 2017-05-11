%%%
% Author:FesianXu
% ʵ�ָ�֪����ֵ������
% ���ۣ�SGD�ٶȿ죬���ȵͣ��ʺ�����ȫ�����Կɷֵ����ݻ����Ǻ������������Ż�����BGD��
% ���ȸߣ��ٶ������ʺ���Ҫ��߾��ȵ����Ż���
%%%
clc
clear
close all
isnew = 'no' ; % ѡ��������Դ��yes�Լ����ƣ�no��ȡ������ļ������ȷ���µ��������Ҽ�����ɫ���ٵ�һ���Ҽ��˳�
mode = 'BGD' ; % SGD or BGD
%% get samples
pos_path = './data_set/human_generate/perceptron_posset_mat.mat';
neg_path = './data_set/human_generate/perceptron_negset_mat.mat';
if strcmp(isnew,'yes')
    [pos,neg] = getSample2D() ;
    save(pos_path,'pos');
    save(neg_path,'neg');
elseif strcmp(isnew,'no')
    pos = cell2mat(struct2cell(load(pos_path))) ;
    neg = cell2mat(struct2cell(load(neg_path))) ;
end
sample_mat = zeros(length(pos(:,1))+length(neg(:,1)), 5) ; % [x1,x2,x0,label,class_res]
sample_mat(1:length(pos(:,1)),1:2) = pos ;
sample_mat(1:length(pos(:,1)),4) = 1 ;
sample_mat(1+length(pos(:,1)):end,1:2) = neg ;
sample_mat(1+length(pos(:,1)):end,4) = -1 ;
sample_mat(:,3) = 1 ;
%% train
tic ;
w = rand(1,3) ;
alpha = 0.3 ;
sum_v = 0 ;
for i = 1:10000*3
    res = sample_mat(:,1:3)*w' ;
    res = (res >= 0) ;
    res = -1*(res == 0) + res ;
    dif = (res ~= sample_mat(:,4)) ; % Ϊ1����û�з�����ȷ��
    [rows,~,~] = find(dif == 1) ;
    if isempty(rows)
        disp(['trainning time = ',num2str(i)]) ;
        break
    else
        if strcmp(mode,'SGD')
            w = w+alpha*sample_mat(rows(1),4)*sample_mat(rows(1),1:3) ;
        elseif strcmp(mode,'BGD')
%             for j = 1:length(rows)
%                 sum_v = sum_v+alpha*sample_mat(rows(j),4).*sample_mat(rows(j),1:3) ;
%             end
%             w = w+sum_v/length(rows) ;

            tmp1 = sum(sample_mat(rows,4).*sample_mat(rows,1)) ;
            tmp2 = sum(sample_mat(rows,4).*sample_mat(rows,2)) ;
            tmp3 = sum(sample_mat(rows,4).*sample_mat(rows,3)) ;
            tmp = [tmp1,tmp2,tmp3] ;
            w = w+tmp/length(rows) ;
        end
    end
end
time = toc ;
disp(['time = ',num2str(time),'s']) ;

%% classfied result,���������
tmp = w*sample_mat(:,1:3)' ;
sample_mat(:,5) = (w*sample_mat(:,1:3)' >= 0)' ;
sample_mat(:,5) = -1*(sample_mat(:,5) == 0)+sample_mat(:,5) ;
err = (sample_mat(:,4) ~= sample_mat(:,5)) ;
sum(err)
err_rate = sum(err)/(length(sample_mat(:,1))) ;
disp(['error rate = ',num2str(err_rate*100),'%']) ;
%% plot
figure
plot(sample_mat(1:length(pos(:,1)),1),sample_mat(1:length(pos(:,1)),2),'r*')
axis([0,10,0,10])
hold on
grid on
plot(sample_mat(length(pos(:,1))+1:end,1),sample_mat(length(pos(:,1))+1:end,2),'b*')
axis([0,10,0,10])
hold on
x = 1:0.01:10 ;
y = -w(1).*x/w(2)-w(3)/w(2) ;
plot(x,y)

