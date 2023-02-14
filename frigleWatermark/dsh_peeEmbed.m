% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fw_martrix,len_map] = dsh_peeEmbed(mb,hash_sequence,block_size,bit_len)
% DSH_PEEEMBED Summary of this function goes here
% Ԥ�������չǶ��
%   Detailed explanation goes here
% ���룺mb----------Ҫ����Ƕ��ľ���
% ���룺hash_sequence----------ҪǶ���hash����
% ���룺block_size----------���С
% ���룺bit_len----------��������Ƕ�������
% �����fw_martrix----------����Ƕ����Ϻ�ľ���
% �����len_map----------Ԥ������map
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fw_martrix = mb; % Ƕ���ľ���
watermark_len = ((block_size/2)-1)*(block_size-2); % ��Ƕ�����еĳ��� 3*6 =18
hash_sequence = hash_sequence(1:watermark_len);% ȡǰwatermark_lenλ
hash_s_num=1; % hash�������

len_map=zeros((block_size/2)-1,(block_size-2)); % 3*6 ����ͼ�����ڴ洢Ԥ������

for i=1:(block_size-2)
	x1=i;
	x2=i+2;
	for j=1:((block_size/2)-1)
		y1=2*j-mod(x1+1,2);
		y2=2*j+2-mod(x1+1,2);
		mx=x1+1; % ����Ԫ������
		my=y1+1; % ����Ԫ������
		% %%%%%%%%%%%%%%%%%%
		% %%% ���Ԥ��  %%%%
		% %%%%%%%%%%%%%%%%%%
		% p 3*3�������
		p=zeros(1,9);
		p_n=1;
		for r=x1:x2
			for l=y1:y2
				p(p_n)=mb(r,l);
				 p_n=p_n+1;
			end
		end
		% c 3*3����������Ԫ��
		c=double(p(5));
		% ��ʼ�� Diamond prediction
		diamond_p_s=zeros(1,4);
		% ����Ԥ��
		diamond_p_s=[p(2) p(4) p(6) p(8)]; 
		% pc ����Ԥ������Ԫ��
		pc=round(mean(diamond_p_s)); 
		% pe Ԥ�����
		pe=double(c-pc);
		
		% %%%%%%%%%%%%%%%%%%
		% %%%%%��չǶ��%%%%%
		% %%%%%%%%%%%%%%%%%%
		if hash_sequence(hash_s_num)==1 % ����1�Ļ�Ƕ��
			if pe==0
				wpe=2;
			else
			wpe = (pe/abs(pe))*(abs(pe)*2+1);
			end
		else % ����0�Ļ���Ƕ
			wpe = pe;
		end
		
		if pe>(2^bit_len) || pe<-(2^bit_len) || pc+wpe>255 || pc+wpe<0 % ������Ԥ�������󣬺�Ƕ��󳬳���Χ����������ǲ�����Ƕ��
			fw_martrix(mx,my)=c;
			len=-1; % len_map Ƕ��-1
			len_map(mod(hash_s_num-1,3)+1,floor((hash_s_num-1)/3)+1)=len;
		else
			fw_martrix(mx,my)=pc+wpe;
			len=1; % ��ʼlen=1
			pe=abs(pe); % ȡ����ֵ����len�ļ���
			% %%%%%%%%%%%%%
			% %% ����len %%
			% %%%%%%%%%%%%%
			while pe>=2
				pe=floor(pe/2);
				len=len+1;
			end
			lx=mod(hash_s_num-1,3)+1;
			ly=floor((hash_s_num-1)/3)+1;
			len_map(lx,ly)=len; % ��len����len_map
		end
		hash_s_num=hash_s_num+1; % hash��������+1
	end % for
end % for

end

