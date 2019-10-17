
%%%%%%%��ȡ������Чֵ---��һ����������жϣ�ʶ��ͷ��β��%%%%%%%%%%%
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
%x=Gnoisegen(x,SNR);                % ��������
%x=doFilter3(xx1);




wnd=hamming(wlen);                      % ���ô�����
overlap=wlen-inc;                       % ���ص�������
NIS=fix((IS*fs-wlen)/inc +1);           % ��ǰ���޻���֡��
xf=doFilter3(x);
xa=xf/max(abs(xf));                      % ��ֵ��һ��
y=enframe(xa,wnd,inc)';             % ��֡
fn=size(y,2);                           % ��֡��
frameTime=frame2time(fn, wlen, inc, fs);% �����֡��Ӧ��ʱ��



for k=2 : fn                            % ��������غ���
    u=y(:,k);
    ru=xcorr(u);
    Ru(k)=max(ru);
end
Rum=multimidfilter(Ru,10);              % ƽ������
Rum=Rum/max(Rum);                       % ��һ��
thredth=max(Rum(1:NIS));                % ������ֵ
T1=1.1*thredth;
T2=2*thredth;
[voiceseg,vsl,SF,NF]=vad_param1D(Rum,T1,T2);% ����غ����Ķ˵���

for k=1 : vsl                           % ��������˵�
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
    N1=length(xend);                            % ȡ�źų���
time0=(0:N1-1)/fs;                        % ����ʱ��
 plot(time0,xend,'b');
axis tight;
 ylabel('Amplitude');xlabel('Time/s');













