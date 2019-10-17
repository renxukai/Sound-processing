%%作功率谱密度函数
%%
clear all; clc; close all;
IS=0.25;                                % 设置前导无话段长度
wlen=200;                               % 设置帧长为50%%%%%%%%%%(NOTE)
inc=200;                                 % 求帧移
fs=40000;
filename=['H:\文件\实验数据\20191015变截面3\声音\'];             % 设置路径
type='.txt';                      % 设置文件名称
 num='2-1-1';                       %文件顺序
fle=[filename num type];          % 构成文件路径和名称
[x]=load(fle);                    % 读入数据
x=x-mean(x);                       %去直流分量
N=length(x);                       % 取信号长度
time=(0:N-1)/fs;                   % 设置时间
%%
[Pxx1,F1]=pwelch(xend,hanning(1024),100,1024,fs);
plot(F1,Pxx1,'k')