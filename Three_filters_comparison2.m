%
%
%%%%%%%%%%�����źŽ��룬�����׼�����ά���˲�����ͨ�˲��Ա�%%%%%%%%%%




clear all; clc; close all;
filedir=['H:\�ļ�\ʵ������\20190912�����2\����\'];                             % ָ���ļ�·��
filename='1-2.txt';                % ָ���ļ���
fle=[filedir filename]                  % ����·�����ļ������ַ���
fs=40000;                               %����Ƶ��
[xx]=load(fle);                   % ���������ļ�
xx=xx-mean(xx);                         % ����ֱ������
x=xx;%/max(abs(xx));                      % ��ֵ��һ��
N=length(x);                            % �źų���
time=(0:N-1)/fs;                        % ����ʱ��
%%%%%%%%%��ͨ�˲�
output1=doFilter9(x);
%%%%%%%%%�����׼���
IS=1;                                % ����ǰ���޻��γ���
wlen=200;                               % ����֡��Ϊ25ms
inc=80;                                 % ����֡��Ϊ10ms
overlap=wlen-inc;                       % ���ص�������
NIS=fix((IS*fs-wlen)/inc +1);           % ��ǰ���޻���֡��

a=4; b=0.001;                           % ���ò���a��b
output2=simplesubspec(x,wlen,inc,NIS,a,b);% �׼�

%%%%%%%%%ά���˲�
output3=WienerScalart96m_2(x,fs,IS,0.12);
ol=length(output3);                      % ��output������x�ȳ�
if ol<N
    output3=[output3; zeros(N-ol,1)];
end
audiowrite('66.wav',x,fs)
sound(x,fs);
clear sound
% ��ͼ
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

