% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ex_sequence,re_mb] = dsh_peeExact(mb,block_size,len_map)
% DSH_PEEEMBED Summary of this function goes here
% Ԥ�������չ ��ȡ���ָ�
%   Detailed explanation goes here
% ���룺mb----------Ҫ������ȡ�ľ���
% ���룺block_size----------�ֿ��С
% ���룺len_map----------Ԥ������map
% �����ex_sequence----------��ȡ������
% �����re_mb----------����ָ���ľ���
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
len = ((block_size/2)-1)*(block_size-2); % ���г��� 3*6 =18
ex_sequence = zeros(1,len);% ȡǰwatermark_lenλ
ex_num = 1;
re_mb=mb;
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
	% wpe Ԥ�����(��ˮӡ)
	wpe=double(c-pc);
	% %%%%%%%%%%%%%%%%%%
	% %%%%%��ȡ�ָ�%%%%%
	% %%%%%%%%%%%%%%%%%%
	len=1; % ��ʼlen=1
	wpe_l=abs(wpe);
	while wpe_l>=2
		wpe_l=floor(wpe_l/2);
		len=len+1;
	end
	lx=mod(ex_num-1,3)+1;
	ly=floor((ex_num-1)/3)+1;
	m_len=len_map(lx,ly);

	if m_len==-1  % ����⵽��λ��û��Ƕ��ˮӡʱ�������лָ�
		ex_sequence(ex_num) = -1;
	else
		if m_len==len % ���Ƕ�����0 ����Ҫ�ָ�
			ex_sequence(ex_num) = 0;
			% re_mb(mx,my) = pc;
		else
			ex_sequence(ex_num) = 1;
			if wpe==2
				re_mb(mx,my) = pc;
			else
			re_mb(mx,my) = pc + (wpe/abs(wpe))*floor(abs(wpe)/2);
			end
		end
	end
	ex_num = ex_num+1;
	end
end
end

