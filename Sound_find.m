
%%%%%%%截取声音有效值---归一化后自相关判断（识别开头结尾）%%%%%%%%%%%
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
%x=Gnoisegen(x,SNR);                % 叠加噪声
%x=doFilter3(xx1);




wnd=hamming(wlen);                      % 设置窗函数
overlap=wlen-inc;                       % 求重叠区长度
NIS=fix((IS*fs-wlen)/inc +1);           % 求前导无话段帧数
xf=doFilter3(x);
xa=xf/max(abs(xf));                      % 幅值归一化
y=enframe(xa,wnd,inc)';             % 分帧
fn=size(y,2);                           % 求帧数
frameTime=frame2time(fn, wlen, inc, fs);% 计算各帧对应的时间



for k=2 : fn                            % 计算自相关函数
    u=y(:,k);
    ru=xcorr(u);
    Ru(k)=max(ru);
end
Rum=multimidfilter(Ru,10);              % 平滑处理
Rum=Rum/max(Rum);                       % 归一化
thredth=max(Rum(1:NIS));                % 计算阈值
T1=1.1*thredth;
T2=2*thredth;
[voiceseg,vsl,SF,NF]=vad_param1D(Rum,T1,T2);% 自相关函数的端点检测

for k=1 : vsl                           % 标出语音端点
    nx1=voiceseg(k).begin; nx2=voiceseg(k).end;
    D(k,:)=[nx1,nx2];
    fprintf('%4d   %4d   %4d\n',k,nx1,nx2);
   % if frameTime(1,nx2)-frameTime(1,nx1)>19
    %time1=frameTime(:,nx1);
    %time2=frameTime(:,nx2);
    %break
    %end
end
    time1=frameTime(:,min(nx1));
    time2=frameTime(:,max(nx2));
    xend=x(time1*fs:time2*fs,:);
    N1=length(xend);                            % 取信号长度
time0=(0:N1-1)/fs;                        % 设置时间
 plot(time0,xend,'b');
axis tight;
 ylabel('Amplitude');xlabel('Time/s');













