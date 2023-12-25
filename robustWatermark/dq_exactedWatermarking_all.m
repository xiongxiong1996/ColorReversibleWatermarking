% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [exw_sequence] = dq_exactedWatermarking_all(watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_EXACTEDWATERMARKING_ALL Summary of this function goes here
% �ú���ʹ�����ַ�������ˮӡ����ȡ������һ����ȡ����ˮӡ����
%   Detailed explanation goes here
% ���룺watermarkedImg----------ˮӡͼ��
% ���룺local_map----------³��ˮӡǶ��ͼ
% ���룺block_size----------�ֿ��С
% ���룺T,G,----------T:������ͣ�G:��ֵ
% �����exw_sequence----------��ȡ��ˮӡ����
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[exw_sequence1]=dq_exactedWatermarking1(watermarkedImg,local_map,block_size,T,G,n_level); % ��ȡˮӡ���з���1
[exw_sequence2]=dq_exactedWatermarking2(watermarkedImg,local_map,block_size,T,G,n_level); % ��ȡˮӡ���з���2
[exw_sequence3]=dq_exactedWatermarking3(watermarkedImg,local_map,block_size,T,G,n_level); % ��ȡˮӡ���з���3


[r l]=size(exw_sequence1);
exw_sequence=zeros(1,l);

for i=1:l
	if exw_sequence1(i)==exw_sequence2(i)
		if exw_sequence1(i)==exw_sequence3(i)
			w=exw_sequence1(i);
		else
			w=exw_sequence1(i);
		end
	else
		if exw_sequence2(i)==exw_sequence3(i)
			w=exw_sequence2(i);
		end
		if exw_sequence1(i)==exw_sequence3(i)
			w=exw_sequence3(i);
		end
	end
	exw_sequence(i)=w;
end
end

