% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [recoveredImg] = dq_robustWatermarkRecover(local_map,exw_sequence,watermarkedImg,block_size,T,G,n_level)
% DQ_ROBUSTWATERMARKRECOVER Summary of this function goes here
% ³��ˮӡ���п���ָ�
%   Detailed explanation goes here
% ���룺local_map----------³��ˮӡǶ��ͼ
% ���룺exw_sequence----------��ȡ��ˮӡ����
% ���룺watermarkedImg----------Ҫ���лָ���ˮӡͼ�񣬵���Ҷ�ͼ��
% ���룺block_size----------�ֿ��С
% ���룺T,G,----------T:������ͣ�G:��ֵ
% �����recoveredImg----------�ָ����ͼ��
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index=1; % ��ȡˮӡ���е�����
block_size_l=block_size/2; % Ƶ��Ŀ��С
M = ((block_size_l/2)-1)*(block_size_l-2); % M
recoveredImg=watermarkedImg; % ����ָ����ͼ��
rr_l=recoveredImg(:,:,1); % �ָ���ͼ���R��
rg_l=recoveredImg(:,:,2); % �ָ���ͼ���G��
wr_l=watermarkedImg(:,:,1); % ˮӡͼ���R��
wg_l=watermarkedImg(:,:,2); % ˮӡͼ���G��
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ����Ԥ�����ֱ��ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[L L]=size(local_map); % ˮӡǶ��ͼ 
for i=1:L
	for j=1:L % ����local_map
		if local_map(i,j)==1 % ���locla_mapΪ1����ʾǶ��
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;
			if exw_sequence(index)==1 % ���ˮӡ����Ϊ1����ʾ�ÿ������ֱ��ͼƽ�ƣ�����лָ� R��
				block_r=wr_l(x1:x2,y1:y2); 
				% block_r = imcrop(wr_l,[x1,y1,block_size-1,block_size-1]);
				[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level);
                % [ll_r,imgwave]=liftwavedec2(block_r,block_size,1); % ����IWT
				ll_rr = qyh_blockRecover(ll_r,block_size/2,T,G,M);
                % imgwave(1:block_size/2,1:block_size/2)=ll_rr;
                % block_rr=liftwaverec2(imgwave,block_size,1);
				[block_rr] = dq_inverIwtTransform(ll_rr,lh_r, hl_r, hh_r,n_level);
				rr_l(x1:x2,y1:y2)=block_rr;
			end
			index=index+1; % ˮӡ��������+1
			if exw_sequence(index)==1 % ���ˮӡ����Ϊ1����ʾ�ÿ������ֱ��ͼƽ�ƣ�����лָ� G��
				block_g=wg_l(x1:x2,y1:y2); 
                % [ll_g,imgwave]=liftwavedec2(block_g,block_size,1); % ����IWT
				[ll_g, lh_g, hl_g, hh_g] = dq_iwtTransfrom(block_g,n_level);
				ll_rg = qyh_blockRecover(ll_g,block_size/2,T,G,M);
                % imgwave(1:block_size/2,1:block_size/2)=ll_rg;
                % block_rg=liftwaverec2(imgwave,block_size,1);
				[block_rg] = dq_inverIwtTransform(ll_rg,lh_g, hl_g, hh_g,n_level);
				rg_l(x1:x2,y1:y2)=block_rg;
			end
			index=index+1; % ˮӡ��������+1
		end % if
	end % for
end % for
recoveredImg(:,:,1)=rr_l; % �ָ���ͼ���R��
recoveredImg(:,:,2)=rg_l; % �ָ���ͼ���G��
end

