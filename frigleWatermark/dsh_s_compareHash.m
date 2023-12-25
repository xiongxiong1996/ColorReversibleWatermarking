% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Revision			 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [istag,isuncertain,error_num]=dsh_s_compareHash(hash_sequence,ex_sequence,block_size,unc_len)
% DSH_PEEEMBED Summary of this function goes here
% �Ƚ�hashֵ�Ƿ���ͬ
%   Detailed explanation goes here
% ���룺hash_sequence----------�������hash quence
% ���룺ex_sequence----------��ȡ����hash quence
% ���룺block_size----------���С
% ���룺unc_len----------�Ƚ�hash����ʱ���� (len-unc_len)����ΪδǶ�룬����Ϊ�ÿ�Ϊ���ɿ�
% �����istag----------��ͬtag�������ͬ����0����ͬ����1
% �����error_num----------����hashֵ�Աȴ�������
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
watermark_len = ((block_size/2)-1)*(block_size-2); % ��Ƕ�����еĳ��� 3*6 =18
hash_sequence = hash_sequence(1:watermark_len);% ȡǰwatermark_lenλ

isuncertain=0;
unembed_num=0;
error_num=0;
istag=0;
for i=1:watermark_len
	if ex_sequence(i)==-1
		unembed_num=unembed_num+1;
	else if hash_sequence(i) == ex_sequence(i)
	else
		istag=1;
		error_num=error_num+1;
	end
end
% ��δǶ��̫���λ����������Ϊ�ÿ�ıȽϽ��������
if istag==0 && unembed_num > (watermark_len-unc_len)
	isuncertain=1;
end
end

