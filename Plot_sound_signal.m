%%�����źŻ�ͼ
clear all
clc
fs=40000;                         %�źŲɼ�Ƶ��
filename=['H:\�ļ�\ʵ������\20191015�����3\����\'];                         % �����ļ�·��
type='.txt';                      % �����ļ�����
 num='1-1';                       %�ļ�˳��
fle=[filename num type];          % �����ļ�·��������
[x]=load(fle);                    % ��������
N=length(x);                            % ȡ�źų���
time=(0:N-1)/fs;                        % ����ʱ��
xx=x-mean(x);                         % ����ֱ������
plot(time,xx,'k');  axis tight;
 ylabel('Amplitude');xlabel('Time/s');