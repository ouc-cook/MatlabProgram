function [ output_signal ] = RangeAlignment( input_signal )
%RANGEALIGNMENT Summary of this function goes here
%   Detailed explanation goes here
%使用最小熵法进行对齐
%%
%设置距离对齐参数
Range = 50;     %对齐操作的搜索范围
K_interpolation = 4;        %插值倍数
[R_scale A_scale] = size(input_signal);     %得到数据矩阵大小
Factor = 1;   %指数加权的倍数
%%
%插值运算
%input_signal = Interpolation(input_signal,K_interpolation);
input_signal = complex(spline(1:R_scale,real(input_signal.'),1:1/K_interpolation:R_scale).',spline(1:R_scale,imag(input_signal.'),1:1/K_interpolation:R_scale).');
%%
%初始化输出数据
output_signal = input_signal;
%%
%初始化包络对齐所使用的数据
%input_signal = ValidData(input_signal,Range);
%%
%包络对齐处理
U_sum = input_signal(:,1);      %已经处理过的包络和
h2 = waitbar(0,'包络对齐');
for i = 2:A_scale                                   %这里是从第2列开始进行对齐
    t_move = MinEntropy(U_sum,input_signal(:,i),Range*K_interpolation);        %调用函数
    output_signal(:,i) = circshift(output_signal(:,i),t_move);        %对某一列进行对齐
    U_sum = U_sum*Factor+input_signal(:,i);               %将对齐列加入U_sum
    waitbar(i/A_scale);
end
delete(h2);
output_signal = output_signal(1:K_interpolation:end,:);
%%
%显示包络对齐结果
figure,imagesc(abs(output_signal')/max(max(abs(output_signal)))),colormap(gray);
title('包络对齐结果');
