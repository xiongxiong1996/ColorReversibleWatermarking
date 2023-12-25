% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [histImg,spe_squence] = dq_getHistogram(Img,local_map,block_size,n_level)
% DQ_GETHISTOGRAM Summary of this function goes here
% �˺������ڻ�ȡǶ��λ�õ�Ԥ�����ֱ��ͼ
%   Detailed explanation goes here
% ���룺Img----------��Ҫ��ȡԤ�����ֱ��ͼ��ͼ��Ƕ��ˮӡ��ͼ��/����ͼ��
% ���룺local_map----------Ƕ��λ��ͼ
% ���룺block_size----------�ֿ��С
% �����histImg----------ֱ��ͼ
% �����spe_squence----------��������ֱ��ͼ��Ԥ���������
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


wr_l=Img(:,:,1);
wg_l=Img(:,:,2);
wb_l=Img(:,:,3);
index=1;
spe_squence=zeros(1,1);
[L L]=size(local_map);

for i=1:L
	for j=1:L
		if local_map(i,j)==1			
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;

			block_r=wr_l(x1:x2,y1:y2); 
			% block_r = imcrop(wr_l,[x1,y1,block_size-1,block_size-1]);
			[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level);

			block_g=wg_l(x1:x2,y1:y2);
			% block_g = imcrop(wg_l,[x1,y1,block_size-1,block_size-1]);
			[ll_g, lh_g, hl_g, hh_g] = dq_iwtTransfrom(block_g,n_level);

			% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			% %%%%%% ��ȡ��С���sum_pe %%%%%%
			% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			[sum_pe] = qyh_getBlockSumpe(ll_r,block_size/2);
			spe_squence(index)=sum_pe;
			index=index+1;
			if abs(sum_pe)>28
				a=1;
			end
			[sum_pe] = qyh_getBlockSumpe(ll_g,block_size/2);
			spe_squence(index)=sum_pe;
			index=index+1;
		end
	end
	histImg=Img;
	% histImg=histogram(spe_squence,1000);
end


