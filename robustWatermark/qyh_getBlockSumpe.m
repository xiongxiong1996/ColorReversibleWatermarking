% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sum_pe] = qyh_getBlockSumpe(block,block_size)
% QYH_GETBLOCKSUMPE Summary of this function goes here
% ���������ڶԵ���һ��С�����Ԥ�⣬����Ԥ������sum
%   Detailed explanation goes here
% ���룺block----------Ҫ���м���ľ���
% ���룺block_size----------���С
% �����sum_pe----------�������sum_pe
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[block_size,block_size]=size(block);
sum_pe =0;
for i=1:block_size                          %����ÿ��С��
	for j=1:block_size 
        if mod(i+j,2)==0                    %�±�Ͷ�2ȡ��Ϊ0ʱ��Ȩ��Ϊ1
            sum_pe=sum_pe+block(i,j);            
        else
            sum_pe=sum_pe-block(i,j);       %�±�Ͷ�2ȡ��Ϊ1ʱ��Ȩ��Ϊ-1
        end
	end % for
end % for

end

