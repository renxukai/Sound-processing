%%���������ܶȺ���
%%
clear all; clc; close all;
IS=0.25;                                % ����ǰ���޻��γ���
wlen=200;                               % ����֡��Ϊ50%%%%%%%%%%(NOTE)
inc=200;                                 % ��֡��
fs=40000;
filename=['H:\�ļ�\ʵ������\20191015�����3\����\'];             % ����·��
type='.txt';                      % �����ļ�����
 num='2-1-1';                       %�ļ�˳��
fle=[filename num type];          % �����ļ�·��������
[x]=load(fle);                    % ��������
x=x-mean(x);                       %ȥֱ������
N=length(x);                       % ȡ�źų���
time=(0:N-1)/fs;                   % ����ʱ��
%%
[Pxx1,F1]=pwelch(xend,hanning(1024),100,1024,fs);
plot(F1,Pxx1,'k')