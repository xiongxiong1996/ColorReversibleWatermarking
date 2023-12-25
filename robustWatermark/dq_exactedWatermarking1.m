% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [exw_sequence] = dq_exactedWatermarking1(watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_EXACTEDWATERMARKING1 Summary of this function goes here
% �ú�������ˮӡ���е���ȡ��
%   Detailed explanation goes here
% ���룺watermarkedImg----------ˮӡͼ��
% ���룺local_map----------³��ˮӡǶ��ͼ
% ���룺block_size----------�ֿ��С
% ���룺T,G,----------T:������ͣ�G:��ֵ
% �����exw_sequence----------��ȡ��ˮӡ����
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wr_l=watermarkedImg(:,:,1);
wg_l=watermarkedImg(:,:,2);
wb_l=watermarkedImg(:,:,3);
index=1; % ˮӡ���е�index
exw_sequence=zeros(1,1); % ��ȡ����ˮӡ����
[L L]=size(local_map); % ��ȡǶ��ͼ��size
for i=1:L
	for j=1:L
		if local_map(i,j)==1			
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;
			% %%%%%%%%%%%%%%%%%%%%%
			% %%%    R����ȡ    %%%
			% %%%%%%%%%%%%%%%%%%%%%
			block_r=wr_l(x1:x2,y1:y2);
			[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level);
            % [ll_r,imgwave]=liftwavedec2(block_r,block_size,1); % ����IWT
			[sum_pe] = qyh_getBlockSumpe(ll_r,block_size/2); % ��ȡ��С���sum_pe
			if sum_pe>=(-T-G/2) && sum_pe<=(T+G/2)
				w=0;
			else
				w=1;
			end
			exw_sequence(index)=w;
			index=index+1;
			% %%%%%%%%%%%%%%%%%%%%%
			% %%%    G����ȡ    %%%
			% %%%%%%%%%%%%%%%%%%%%%
			block_g=wg_l(x1:x2,y1:y2);
            % [ll_g,imgwave]=liftwavedec2(block_g,block_size,1); % ����IWT
			[ll_g, lh_g, hl_g, hh_g] = dq_iwtTransfrom(block_g,n_level);
			[sum_pe] = qyh_getBlockSumpe(ll_g,block_size/2);% ��ȡ��С���sum_pe
			if sum_pe>=(-T-G/2) && sum_pe<=(T+G/2)
				w=0;
			else
				w=1;
			end
			exw_sequence(index)=w;
			index=index+1;
		end
	end
end
end

