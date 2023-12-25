function [exw_sequence] = dq_exactedWatermarking3(watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_EXACTEDWATERMARKING1 Summary of this function goes here
% �ú�������ˮӡ���е���ȡ��
%   Detailed explanation goes here
% ���룺watermarkedImg----------ˮӡͼ��
% ���룺local_map----------³��ˮӡǶ��ͼ
% ���룺block_size----------�ֿ��С
% ���룺T,G,----------T:������ͣ�G:��ֵ
% �����exw_sequence----------��ȡ��ˮӡ����
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[histImg,spe_squence] = dq_getHistogram(watermarkedImg,local_map,block_size,n_level);
l=size(spe_squence,2);
exw_sequence=zeros(1,l);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     K_means����      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=zeros(l,1);
for i=1:l
	data(i,1)=spe_squence(i);
end
[re] = qyh_kmeans(data,0);
for i=1:l
	if re(i,2) == 2
		w=0;
	else
		w=1;
	end
	exw_sequence(i)=w;
end
end
