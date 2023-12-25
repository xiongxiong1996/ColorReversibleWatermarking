% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [block_p,bool]=qyh_blockEmbed(block,block_size,T,G)
% QYH_GETBLOCKSUMPE Summary of this function goes here
% ˮӡǶ�뷽��
%   Detailed explanation goes here
% ���룺block----------ҪǶ��ˮӡ�Ŀ�
% ���룺block_size----------���С
% ���룺T----------��Χ
% ���룺G----------��ֵ
% �����block_p----------Ƕ��ˮӡ��Ŀ�
% �����bool----------��������bool��Ϊ0����ʾ�ÿ鲻�ʺ�Ƕ��

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bool=0;
sum_pe =0;
flag=1;          % beta������flag=1/-1
block_p=block;
block_num=1; % Ƕ��ļ��顣һ�� M ��   b
[block_size,block_size]=size(block);
M=block_size^2;
% M = ((block_size/2)-1)*(block_size-2); % ��Ƕ�����еĳ��� 3*6 =18


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ����sum_pe  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
sum_pe=qyh_getBlockSumpe(block,block_size);
if sum_pe<0
    flag=-1;
end
% % % % % ��sum_pe>0����ÿ��С��Ȩ�ز��䣻��sum_pe<=0����ÿ��С��Ȩ�ر�Ϊ�෴��%%%%%%
for i=1:block_size
    for j=1:block_size
        beta=flag * floor((T+G+block_num-1)/M);          
        if mod(i+j,2)==0                           %�±�Ͷ�2ȡ��Ϊ0ʱ��
              block_p(i,j)=block_p(i,j)+beta;
        else
              block_p(i,j)=block_p(i,j)-beta;
        end % if
        block_num=block_num+1;
    end
end
end



