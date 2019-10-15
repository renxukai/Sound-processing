%
%
%%%%%%%%%%声音信号降噪，基本谱减法、维纳滤波，高通滤波对比%%%%%%%%%%




clear all; clc; close all;
filedir=['H:\文件\实验数据\20190912变截面2\声音\'];                             % 指定文件路径
filename='1-2.txt';                % 指定文件名
fle=[filedir filename]                  % 构成路径和文件名的字符串
fs=40000;                               %采样频率
[xx]=load(fle);                   % 读入数据文件
xx=xx-mean(xx);                         % 消除直流分量
x=xx;%/max(abs(xx));                      % 幅值归一化
N=length(x);                            % 信号长度
time=(0:N-1)/fs;                        % 设置时间
%%%%%%%%%高通滤波
output1=doFilter9(x);
%%%%%%%%%基本谱减法
IS=1;                                % 设置前导无话段长度
wlen=200;                               % 设置帧长为25ms
inc=80;                                 % 设置帧移为10ms
overlap=wlen-inc;                       % 求重叠区长度
NIS=fix((IS*fs-wlen)/inc +1);           % 求前导无话段帧数

a=4; b=0.001;                           % 设置参数a和b
output2=simplesubspec(x,wlen,inc,NIS,a,b);% 谱减

%%%%%%%%%维纳滤波
output3=WienerScalart96m_2(x,fs,IS,0.12);
ol=length(output3);                      % 把output补到与x等长
if ol<N
    output3=[output3; zeros(N-ol,1)];
end
audiowrite('66.wav',x,fs)
sound(x,fs);
clear sound
% 作图
plot(time,x,'k');
hold on
plot(time,output1,'c')
subplot 221; plot(time,x,'k'); grid; axis tight;
title('Raw data'); ylabel('Amplitude')
subplot 222; plot(time,output1,'k'); grid; axis tight;
title('Highpass filter'); ylabel('Amplitude')
subplot 223; plot(time,output2,'k');grid;axis tight;%hold on;
title('spectral subtraction filter'); ylabel('Amplitude'); xlabel('Time/s');
subplot 224; plot(time,output3,'k');grid;axis tight;%hold on;
title('Wiener filter'); ylabel('Amplitude'); xlabel('Time/s');

