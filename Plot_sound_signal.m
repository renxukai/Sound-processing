%%声音信号绘图
clear all
clc
fs=40000;                         %信号采集频率
filename=['H:\文件\实验数据\20191015变截面3\声音\'];                         % 设置文件路径
type='.txt';                      % 设置文件名称
 num='1-1';                       %文件顺序
fle=[filename num type];          % 构成文件路径和名称
[x]=load(fle);                    % 读入数据
N=length(x);                            % 取信号长度
time=(0:N-1)/fs;                        % 设置时间
xx=x-mean(x);                         % 消除直流分量
plot(time,xx,'k');  axis tight;
 ylabel('Amplitude');xlabel('Time/s');