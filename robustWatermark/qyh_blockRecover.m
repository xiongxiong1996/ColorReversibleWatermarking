% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [block_r] = qyh_blockRecover(block,block_size,T,G,M)
% QYH_BLOCKRECOVER Summary of this function goes here
% �ú�������С��Ļָ�
%   Detailed explanation goes here
% ���룺block_p----------Ҫ���лָ��Ŀ�
% ���룺block_size----------���С
% ���룺T,G,M----------T:������ͣ�G:��ֵ��M:ÿ����Ԥ������ظ���
% �����block_r----------�ָ���С��

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
block_num=1;
[block_size block_size]=size(block);
[sum_pe] = qyh_getBlockSumpe(block,block_size);
block_r=block;
flag=1;          % beta������flag=1/-1
M=block_size^2;
block_p=block;
block_r=block;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     ���лָ�    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum_pe<0
    flag=-1;
end
for i=1:block_size
    for j=1:block_size
        beta=flag * floor((T+G+block_num-1)/M);
        if mod(i+j,2)==0
              block_r(i,j)=block_p(i,j)-beta;
        else
              block_r(i,j)=block_p(i,j)+beta;
        end % if
        block_num=block_num+1;
    end
end
end

