% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [watermarkedImg,block_cell] = dsh_frigleWatermarkEmbed(hostColorImg,block_size,bit_len)
% DSH_FRIGLEWATERMARKEMBED Summary of this function goes here
% ��ȡ����ˮӡ�����лָ�
%   Detailed explanation goes here
% ���룺hostColorImg----------����ͼ��
% ���룺block_size----------�ֿ��С
% ���룺bit_len----------��������Ƕ�������
% �����watermarkedImg----------Ƕ��ˮӡ���ͼ��
% �����block_cell----------�洢��ÿ����������ȡ�ͻָ���len_map
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Detailed explanation goes here
watermarkedImg=hostColorImg;
fwImg=hostColorImg(:,:,3);
block_num=1;
block_cell=cell(1,2);
% �ֿ�
[L L n] = size(hostColorImg);
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
		temp_block = imcrop(hostColorImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% Ƕ�� %%%%%%
		% %%%%%%%%%%%%%%%%%%
		mb=temp_block(:,:,3); % B
		[fw_martrix,len_map] = dsh_peeEmbed(mb,hash_sequence,block_size,bit_len);
        % [fw_martrix,len_map] = db_peeEmbed(mb,hash_sequence,block_size,bit_len);
		block_cell(block_num,:)={block_num,len_map};
		block_num = block_num+1;
		% �滻ԭ���Ŀ�
		fwImg(y1:y2,x1:x2)=fw_martrix;
	end % for
end % for
watermarkedImg(:,:,3)=fwImg;
end

