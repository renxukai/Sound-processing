%
%
%��ʱ�������ܶȺ��� �Ҷ�ͼ��
%
% pr2_4_2 
clear all; clc; close all;

filedir=['H:\�ļ�\ʵ������\20191015�����3\����\'];           % ����·��
filename='1-3.txt';                       % �����ļ���
fs=40000;
fle=[filedir filename];                        % ����������·�����ļ���
wavin1=load(fle);                              % ���������ļ�
N=length(wavin1);
wavin0=wavin1(1:N,1);
wavin0=wavin0-mean(wavin0);                    %����ֱ������
nwind=240; noverlap=160; inc=nwind-noverlap;   % ����֡��Ϊ240���ص�Ϊ160��֡��Ϊ80
w_nwind=hanning(200); w_noverlap=195;          % ���öγ�Ϊ200�����ص�Ϊ195
nfft=1024;                                      % FFT����Ϊ1024
% ��ÿ֡��pwelch_2�����ʱ�������ܶ�
[Pxx] = pwelch_2(wavin0, nwind, noverlap, w_nwind, w_noverlap, nfft);
frameNum=size(Pxx,2);                          % ȡ��֡��
frameTime=frame2time(frameNum,nfft,inc,fs);    % ����ÿ֡��Ӧ��ʱ��
freq=(0:nfft/2)*fs/nfft;                       % ����Ƶ�ʿ̶�
% ��ͼ
imagesc(frameTime,freq,Pxx); axis xy           
ylabel('Frequency/Hz');
xlabel('Time/s');
title('STFT')
m = 256; LightYellow = [0.6 0.6 0.6];
MidRed = [0 0 0]; Black = [0 0 1];
Colors = [LightYellow; MidRed; Black];
colormap(SpecColorMap(m,Colors));
