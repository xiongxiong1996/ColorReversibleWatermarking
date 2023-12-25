% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [att] = dq_robustAttact_test(wImg,watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_ROBUSTATTACT_TEST Summary of this function goes here
% ³��ˮӡ�������ԣ����Ը���³������
%   Detailed explanation goes here
% ���룺wImg----------ˮӡͼ��
% ���룺watermarkedImg----------Ƕ��ˮӡ���ͼ��������ȡˮӡ��
% ���룺local_map----------³��ˮӡǶ��ͼ
% ���룺block_size----------�ֿ��С
% ���룺T,G,----------T:������ͣ�G:��ֵ
% �����att----------��������ȡЧ���б�
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
ow_Img=wImg;
att_n=0;% 44
att=zeros(76,3); % ���ڴ�Ź�����ͼ���³������Ϣ
for i=1:25  % 77
		% [attacked_img,att_name] = attacks(watermarkedImg,att_n); % ���ù�������
		[attacked_img,att_name] = attacks_filter(watermarkedImg,att_n); % ���ù�������
        % [exw_sequence]= dq_exactedWatermarking1(attacked_img,local_map,block_size,T,G); % �Թ������ͼ�����ˮӡ��ȡ
		[exw_sequence] = dq_exactedWatermarking_all(attacked_img,local_map,block_size,T,G,n_level);
		[exwImg] = dq_get_wImg(exw_sequence);
		% ber = qyh_getBER(w_sequence,exw_sequence); % �����ʼ���
		ber=d_get_ber(ow_Img,exwImg);
		nc_num=d_get_nc(ow_Img,exwImg);
		% psnr_w=psnr(ow_Img,extract_w);
		% figure(i);
		% imshow(exwImg);
		att(i,1)=i-1;
    att(i,2)=ber;
    att(i,3)=nc_num;
		att_n=att_n+1;
end
end

