% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [histImg,spe_squence] = qyh_getHistogram(Img,block_size)
% QYH_GETBLOCKSUMPE Summary of this function goes here
% ���������ڻ�ȡֱ��ͼ
%   Detailed explanation goes here
% ���룺Img----------��Ҫ��ȡֱ��ͼ��ͼƬ
% ���룺block_size----------���С
% �����histImg----------ֱ��ͼ
% �����spe_squence----------��������ֱ��ͼ������
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[L L]=size(Img);
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
		block = imcrop(Img,[x1,y1,block_size-1,block_size-1]);
		[sum_pe] = qyh_getBlockSumpe(block,block_size);
		spe_squence(index)=sum_pe;
		index=index+1;
	end % for
end % for
histImg=histogram(spe_squence,1000);
end

