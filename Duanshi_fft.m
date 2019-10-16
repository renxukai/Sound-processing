%
%
%短时功率谱密度函数 灰度图像
%
% pr2_4_2 
clear all; clc; close all;

filedir=['H:\文件\实验数据\20191015变截面3\声音\'];           % 设置路径
filename='1-3.txt';                       % 设置文件名
fs=40000;
fle=[filedir filename];                        % 构成完整的路径和文件名
wavin1=load(fle);                              % 读入数据文件
N=length(wavin1);
wavin0=wavin1(1:N,1);
wavin0=wavin0-mean(wavin0);                    %消除直流分量
nwind=240; noverlap=160; inc=nwind-noverlap;   % 设置帧长为240，重叠为160，帧移为80
w_nwind=hanning(200); w_noverlap=195;          % 设置段长为200，段重叠为195
nfft=1024;                                      % FFT长度为1024
% 对每帧用pwelch_2计算短时功率谱密度
[Pxx] = pwelch_2(wavin0, nwind, noverlap, w_nwind, w_noverlap, nfft);
frameNum=size(Pxx,2);                          % 取来帧数
frameTime=frame2time(frameNum,nfft,inc,fs);    % 计算每帧对应的时间
freq=(0:nfft/2)*fs/nfft;                       % 计算频率刻度
% 作图
imagesc(frameTime,freq,Pxx); axis xy           
ylabel('Frequency/Hz');
xlabel('Time/s');
title('STFT')
m = 256; LightYellow = [0.6 0.6 0.6];
MidRed = [0 0 0]; Black = [0 0 1];
Colors = [LightYellow; MidRed; Black];
colormap(SpecColorMap(m,Colors));
