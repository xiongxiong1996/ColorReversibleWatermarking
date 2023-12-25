% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [recoverImg,recoverlayer,taggedImg,istagged] = dsh_frigleWatermarkExact(watermarkedImg,block_size,bit_len,block_cell,unc_len,block_t_num)
% DSH_ROBUSTWATERMARKEMBED Summary of this function goes here
% ��ȡ����ˮӡ�����лָ�
%   Detailed explanation goes here
% ���룺watermarkedImg----------ˮӡͼ��
% ���룺block_size----------�ֿ��С
% ���룺bit_len----------��������Ƕ�������
% ���룺block_cell----------�洢��ÿ����������ȡ�ͻָ���len_map
% ���룺unc_len----------�Ƚ�hash����ʱ���� (len-unc_len)����ΪδǶ�룬����Ϊ�ÿ�Ϊ���ɿ�
% ���룺block_t_num----------��һ��3*3�������У���Χ8���飬��block_t_num�鱻�۸ģ�����Ϊ�ÿ�Ҳ���۸���
% �����recoverImg----------��ԭ���ͼ��
% �����recoverlayer----------��ԭ��Ĳ�
% �����taggedImg----------�۸Ķ�λͼ
% �����istagged----------�Ƿ񱻴۸ģ�Ĭ����0����ʾδ���۸ģ����Ϊ1��ʾ���۸�
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recoverImg = watermarkedImg;
recoverlayer = watermarkedImg(:,:,3);
taggedImg = watermarkedImg;
block_num=1;
istagged=0;

% ȡˮӡͼ���size
[L L n] = size(watermarkedImg);
% certain_num=0;
% ���ƴ۸�ͼ
uncertain_map=zeros(L/block_size,L/block_size);
% �۸�ͼ
tagged_map=zeros(L/block_size,L/block_size);

% %%%%%%%%%%%%%%%%%%
% %%%%%% �ֿ� %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;

		% %%%%%%%%%%%%%%%%%%
		% %%%  ����hash  %%%
		% %%%%%%%%%%%%%%%%%%
		temp_block = imcrop(watermarkedImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%%%%%
		% %%%%%% ��ȡ�ָ� %%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%
		mb=temp_block(:,:,3); % B
		len_map=block_cell{block_num,2};
		[ex_sequence,re_mb] = dsh_peeExact(mb,block_size,len_map);% ������ȡˮӡ�������лָ�
		recoverlayer(y1:y2,x1:x2)=re_mb; % ʹ�ûָ���re_mb �滻ԭ��������
		block_num=block_num+1;
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% �Ƚ� %%%%%%
		% %%%%%%%%%%%%%%%%%%
		[istag,isuncertain]=dsh_s_compareHash(hash_sequence,ex_sequence,block_size,unc_len);% ���ڱȽ���������
		
		% %%%%%%%%%%%%%%%%%%%%%%
		% %%%%�۸ļ��ͼ����%%%%
		% %%%%%%%%%%%%%%%%%%%%%%
        if(istag==1)
		 	taggedImg(y1:y2,x1:x2)=1; % ��Ǵ۸�����
		 	istagged=1;
		 	tagged_map(ceil(x1/block_size),ceil(y1/block_size))=1;
        else
            if (isuncertain==1)
				uncertain_map(ceil(x1/block_size),ceil(y1/block_size))=1;
            end
        end
	end % for
end % for
recoverImg(:,:,3) = recoverlayer;
taggedImg=dsh_tamperrCertain2(tagged_map,uncertain_map,taggedImg,block_size,block_t_num);
end

