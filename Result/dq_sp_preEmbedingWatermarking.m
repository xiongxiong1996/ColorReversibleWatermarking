% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [bool,local_map] = dq_sp_preEmbedingWatermarking(hostImg_lary,block_size,w_sequence,sorted_index,b_num_p,T,G,n_level)
% DQ_EMBEDINGWATERMARKING Summary of this function goes here
% �˺�����������Ӧ���ж�����local_map
%   Detailed explanation goes here
% ���룺hostImg----------����ͼ��
% ���룺block_size----------�ֿ��С
% ���룺w_sequence----------ˮӡ����
% ���룺sorted_index----------����������ƽ���飩
% ���룺b_num_p----------Ԥ����ҪǶ���ĸ���
% ���룺T,G,----------T:������ͣ�G:��ֵ
% �����bool----------�Ƿ�ȫ��Ƕ��
% �����local_map----------Ƕ��λ��ͼ
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%
% %%%   �趨����   %%%
% %%%%%%%%%%%%%%%%%%%%
w_len=size(w_sequence,2); % ��ȡˮӡ���еĳ���1024
% ������ͼ����зֲ�
[L L n] = size(hostImg_lary); % ��ȡ����ͼ���size
index_num=1; % �����������б��
w_index=1; % ˮӡ���б��
l_num = L/block_size; % ÿһ ��/�� �ж��ٸ���
local_map=zeros(l_num,l_num); % ˮӡǶ��ͼ

for i=1:b_num_p % ��Ԥ��ҪǶ��Ŀ����Ƕ�룬���ܲ��ܽ�ˮӡ����ȫ��Ƕ��
	if w_index<=w_len
		x_b = floor((sorted_index(index_num)-1)/l_num)+1; % ��ı��x
	 	y_b = mod(sorted_index(index_num)-1,l_num)+1; % ��ı��y
		index_num=index_num+1; % �����������б��
		% %%%%%%%%%%%%%%%%%%%%%
		% %%  ���������x,y  %%
		% %%%%%%%%%%%%%%%%%%%%%
		x1=(x_b-1)*block_size+1;
		x2=x_b*block_size;
		y1=(y_b-1)*block_size+1;
		y2=y_b*block_size;
		% %%%%%%%%%%%%%%%%%%%%%
		% %%%   R��ԤǶ��   %%%
		% %%%%%%%%%%%%%%%%%%%%%
		block_r=hostImg_lary(x1:x2,y1:y2); % r��ҪǶ��Ŀ�
		% block_r = imcrop(r_l,[x1,y1,block_size-1,block_size-1]);
		[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level); % r��ҪǶ��Ŀ����IWT�ֽ�
		[ll_rp,bool_r]=qyh_blockEmbed(ll_r,block_size/2,T,G); % ��R�����Ƕ�룬��ʵ�����bool_rû�ã�����Ҫ�������任���Ƿ����
		w_index=w_index+1; % ˮӡ���б��+1
		% %%%%%%%%%%%%%%%%%%%%%
		% %%  �ж��Ƿ����   %%
		% %%%%%%%%%%%%%%%%%%%%%
		[w_block_r] = dq_inverIwtTransform(ll_rp,lh_r, hl_r, hh_r,n_level); % ��R���Ƕ�����任
		[m n] = size(w_block_r); % ��ȡǶ���Ĵ�С
		b=1; % Ĭ�ϲ���������Խ���Ƕ��
		for i=1:m
			for j=1:n
				if w_block_r(i,j)>255 || w_block_r(i,j)<0 
					b=0; % ����R����G��������������ٽ���Ƕ��
					break;
				end
			end
		end
		if b==1 % ��������������Ƕ��
			local_map(x_b,y_b)=1; % local_map��Ӧλ�ý��м�¼
		else % ��������������Ƕ��
			w_index=w_index-1; % ˮӡ���б��-2 R,G��������Ƕ��
		end % if
	end % for
end % for
% %%%%%%%%%%%%%%%%%%%%%
% % ˮӡ�Ƿ�Ƕ����� %%
% %%%%%%%%%%%%%%%%%%%%%
if w_index>w_len % �ж�ˮӡ�����Ƿ�Ƕ�����
	bool=1; % Ƕ����ϻ�1
else
	bool=0; % δǶ�����0
end
end

