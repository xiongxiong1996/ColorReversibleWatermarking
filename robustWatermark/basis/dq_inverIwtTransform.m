% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% % %%%  Copyright (C) 2021  Duan shaohua                                  %%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [img]=dq_inverIwtTransform(img,lh,hl,hh,n)
    [M,M]=size(img);
    N=2*M;
    for i=n:-1:1
        M=N/2;
        imgwave1(1:M,1:M)=img;
        imgwave1(M+1:N,1:M)=lh{i};
        imgwave1(1:M,M+1:N)=hl{i};
        imgwave1(M+1:N,M+1:N)=hh{i};
        img=lwaverec2(imgwave1,N);
        N=N*2;
    end
    % img=lwaverec2_26(imgwave1,N);
end
%********************************************************************%
%***********************    2/6С���任    **************************%
%********************************************************************%
function f_column=lwaverec2_26(f_row,N);
T=N/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%���任%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.�б任
%   A.��ȡ����Ƶ��Ƶ�ֿ���
f1=f_row(:,[T+1:1:N]);  %  ��Ƶ ����
f2=f_row(:,[1:1:T]);    %  ��Ƶ ż��
%  B.����
f2(:,T+1)=f2(:,1);  % ����
% ��һ�е������� !!!!!!! �˴�Ҫ��floor��ǰ����ceil��������floor��
low_frequency_row(:,1)=floor((2*f2(:,1)-f1(:,1)+ceil(((f2(:,T)-f2(:,2))/4)+1/2))/2);
for i_lr=2:T;
    low_frequency_row(:,i_lr)=floor((2*f2(:,i_lr)-f1(:,i_lr)+ceil(((f2(:,i_lr-1)-f2(:,i_lr+1))/4)+1/2))/2);
end;
%  C.Ԥ��
% ��һ�е�������
high_frequency_row(:,1)=low_frequency_row(:,1)+f1(:,1)-ceil((((f2(:,T))-(f2(:,2)))/4)+1/2);
for i_hr=2:T;
    high_frequency_row(:,i_hr)=low_frequency_row(:,i_hr)+f1(:,i_hr)-ceil((((f2(:,i_hr-1))-(f2(:,i_hr+1)))/4)+1/2);
end;
%  D.�ϲ�(��ż�ֿ��ϲ�)
f_row(:,[2:2:N])=low_frequency_row(:,[1:T]);
f_row(:,[1:2:N-1])=high_frequency_row(:,[1:T]);    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.�б任
%  A.��ȡ����Ƶ��Ƶ�ֿ�
f1=f_row([T+1:1:N],:);  %  ���� ��Ƶ
f2=f_row([1:1:T],:);    %  ż�� ��Ƶ
%  B.����
f2(T+1,:)=f2(1,:);  % ����
% ��һ�е�������
low_frequency_column(1,:)=floor((2*f2(1,:)-f1(1,:)+ceil(((f2(T,:)-f2(2,:))/4)+1/2))/2);
for i_lc=2:T;
    low_frequency_column(i_lc,:)=floor((2*f2(i_lc,:)-f1(i_lc,:)+ceil(((f2(i_lc-1,:)-f2(i_lc+1,:))/4)+1/2))/2);
end;
%  C.Ԥ��
% ��һ�е�������
high_frequency_column(1,:)=low_frequency_column(1,:)+f1(1,:)-ceil((((f2(T,:))-(f2(2,:)))/4)+1/2);
for i_hc=2:T;
    high_frequency_column(i_hc,:)=low_frequency_column(i_hc,:)+f1(i_hc,:)-ceil((((f2(i_hc-1,:))-(f2(i_hc+1,:)))/4)+1/2);
end;
%  D.�ϲ�(��ż�ֿ��ϲ���
f_column([2:2:N],:)=low_frequency_column([1:T],:);
f_column([1:2:N-1],:)=high_frequency_column([1:T],:);
end











%********************************************************************%
%********************************************************************%
%************************    SС���任    ***************************%
%********************************************************************%

function f_column=lwaverec2(f_row,N);
T=N/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.�б任
%   A.��ȡ����Ƶ��Ƶ�ֿ���
f1=f_row(:,[T+1:1:N]);  %  ����
f2=f_row(:,[1:1:T]);    %  ż��
%  B.����
for i_lr=1:T;
    low_frequency_row(:,i_lr)=f2(:,i_lr)-ceil(1/2*f1(:,i_lr));
end;
%  C.Ԥ��
for i_hr=1:T;
    high_frequency_row(:,i_hr)=f1(:,i_hr)+low_frequency_row(:,i_hr);
end;
%  D.�ϲ�(��ż�ֿ��ϲ�)
f_row(:,[2:2:N])=low_frequency_row(:,[1:T]);
f_row(:,[1:2:N-1])=high_frequency_row(:,[1:T]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.�б任
%  A.��ȡ����Ƶ��Ƶ�ֿ���
f1=f_row([T+1:1:N],:);  %  ����
f2=f_row([1:1:T],:);    %  ż��
%  B.����
for i_lc=1:T;
    low_frequency_column(i_lc,:)=f2(i_lc,:)-ceil(1/2*f1(i_lc,:));
end;
%  C.Ԥ��
for i_hc=1:T;
    high_frequency_column(i_hc,:)=f1(i_hc,:)+low_frequency_column(i_hc,:);
end;
%  D.�ϲ�(��ż�ֿ��ϲ���
f_column([2:2:N],:)=low_frequency_column([1:T],:);
f_column([1:2:N-1],:)=high_frequency_column([1:T],:);
end
