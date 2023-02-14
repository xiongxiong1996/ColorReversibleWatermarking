% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%  Copyright (C) 2021  Duan shaohua                                  %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [ll, lh, hl, hh] = dq_iwtTransfrom(block)
% % DQ_IWTTRANSFROM Summary of this function goes here
% % ����IWT�任
% %   Detailed explanation goes here
% % ���룺block----------��Ҫ����IWT�任�Ŀ�
% % �����ll, lh, hl, hh----------����IWT�任���Ƶ��LL LH HI HH
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [img, lh, hl, hh]=dq_iwtTransfrom(img,n)
    img=double(img);
    [N,N]=size(img);
    ll=cell(1,3);
    lh=cell(1,3);
    hl=cell(1,3);
    hh=cell(1,3);
    for i=1:n
        imgwave1=lwavedec2(img,N);
        M=N/2;
        ll{i}=imgwave1(1:M,1:M);
        lh{i}=imgwave1(M+1:N,1:M);
        hl{i}=imgwave1(1:M,M+1:N);
        hh{i}=imgwave1(M+1:N,M+1:N);
        img=ll{i};
        N=N/2;
    end
    % imgwave1=lwavedec2_26(img,N);
end

%********************************************************************%
%***********************    2/6С���任    **************************%
%********************************************************************%
function f_row=lwavedec2_26(image,N)
f=image;
T=N/2;               %  ��ͼ��ά��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.�б任
%  A.���ѣ���ż�ֿ���
f1=f([1:2:N-1],:);  %  ����
f2=f([2:2:N],:);    %  ż��
%  C.����
for i_lc=1:T;
    low_frequency_column(i_lc,:)=f2(i_lc,:)+ceil(((f1(i_lc,:)-f2(i_lc,:)))/2);
end;
%  B.Ԥ��
low_frequency_column(T+1,:)=low_frequency_column(1,:);  %  ����
% ��һ�е�������
high_frequency_column(1,:)=f1(1,:)-f2(1,:)+ceil((low_frequency_column(T,:)-low_frequency_column(2,:))/4+1/2);
for i_hc=2:T;
    high_frequency_column(i_hc,:)=f1(i_hc,:)-f2(i_hc,:)+ceil((low_frequency_column(i_hc-1,:)-low_frequency_column(i_hc+1,:))/4+1/2);
end;
%  D.�ϲ�
f_column([1:1:T],:)=low_frequency_column([1:T],:);
f_column([T+1:1:N],:)=high_frequency_column([1:T],:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.�б任
%  A.���ѣ���ż�ֿ���
f1=f_column(:,[1:2:N-1]);  %  ����
f2=f_column(:,[2:2:N]);    %  ż��
%  C.����
for i_lr=1:T;
    low_frequency_row(:,i_lr)=f2(:,i_lr)+ceil((f1(:,i_lr)-f2(:,i_lr))/2);
end;
%  B.Ԥ��
low_frequency_row(:,T+1)=low_frequency_row(:,1);  %  ����
% ��һ�е�������
high_frequency_row(:,1)=f1(:,1)-f2(:,1)+ceil((low_frequency_row(:,T)-low_frequency_row(:,2))/4+1/2);
for i_hr=2:T;
    high_frequency_row(:,i_hr)=f1(:,i_hr)-f2(:,i_hr)+ceil((low_frequency_row(:,i_hr-1)-low_frequency_row(:,i_hr+1))/4+1/2);
end;
% high_frequency_row(:,T)=high_frequency_row(:,1);  %  ����
%  D.�ϲ�
f_row(:,[1:1:T])=low_frequency_row(:,[1:T]);
f_row(:,[T+1:1:N])=high_frequency_row(:,[1:T]);
end






%********************************************************************%
%************************    SС���任    ***************************%
%********************************************************************%
function f_row=lwavedec2(image,N)
f=image;
T=N/2;               %  ��ͼ��ά��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.�б任

%  A.���ѣ���ż�ֿ���

f1=f([1:2:N-1],:);  %  ����
f2=f([2:2:N],:);    %  ż��

% f1(:,T+1)=f1(:,1);  %  ����
% f2(T+1,:)=f2(1,:);  %  ����

%  B.Ԥ��

for i_hc=1:T;
    high_frequency_column(i_hc,:)=f1(i_hc,:)-f2(i_hc,:);
end;

% high_frequency_column(T+1,:)=high_frequency_column(1,:);  %  ����

%  C.����

for i_lc=1:T;
    low_frequency_column(i_lc,:)=f2(i_lc,:)+ceil(1/2*high_frequency_column(i_lc,:));
end;

%  D.�ϲ�
f_column([1:1:T],:)=low_frequency_column([1:T],:);
f_column([T+1:1:N],:)=high_frequency_column([1:T],:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.�б任
%  A.���ѣ���ż�ֿ���
f1=f_column(:,[1:2:N-1]);  %  ����
f2=f_column(:,[2:2:N]);    %  ż��
% f2(:,T+1)=f2(:,1);    %  ����
%  B.Ԥ��
for i_hr=1:T;
    high_frequency_row(:,i_hr)=f1(:,i_hr)-f2(:,i_hr);
end;
% high_frequency_row(:,T+1)=high_frequency_row(:,1);  %  ����
%  C.����
for i_lr=1:T;
    low_frequency_row(:,i_lr)=f2(:,i_lr)+ceil(1/2*high_frequency_row(:,i_lr));
end;
%  D.�ϲ�
f_row(:,[1:1:T])=low_frequency_row(:,[1:T]);
f_row(:,[T+1:1:N])=high_frequency_row(:,[1:T]);
end