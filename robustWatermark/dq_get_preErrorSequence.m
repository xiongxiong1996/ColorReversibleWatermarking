% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [perror_sequence] = dq_get_preErrorSequence(hostImg,block_size,n_level)
% DQ_GET_PREERRORSEQUENCE Summary of this function goes here
% �ԻҶ�ͼ����ɫͼ�񵥲㣬���зֿ�Ԥ������������SUM������sequence
% ���룺hostImg----------����ͼ��
% ���룺block_size----------�ֿ��С
% �����perror_sequence----------Ԥ����������
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ȡ����ͼ��Ĵ�С
[L L]=size(hostImg);
% ����perror_sequence
perror_sequence=zeros(1,floor(L/block_size)*floor(L/block_size));
% perror_sequence������
index=1;

% %%%%%%%%%%%%%%%%%%
% %%%%%% �ֿ� %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%% ��ȡ��С���sum_pe %%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		block=hostImg(x1:x2,y1:y2); 
		% block = imcrop(hostImg,[x1,y1,block_size-1,block_size-1]);
		[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block,n_level);
		[sum_pe] = qyh_getBlockSumpe(ll_r,block_size/2);
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%% ����perror_sequence %%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		perror_sequence(index)=sum_pe;
		index=index+1;

	end % for
end % for

end

