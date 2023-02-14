function [len_maps] = dsh_2_creatLenMap(hostImg,block_size,bit_len)
% DSH_FRIGLEWATERMARKEMBED Summary of this function goes here
% ��������lenMap
%   Detailed explanation goes here
% ���룺layer----------��Ƕ��Ĳ�
% ���룺block_size----------�ֿ��С
% �����len_maps----------�洢��ÿ����������ȡ�ͻָ���len_map
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Detailed explanation goes here

block_num=1;
block_cell=cell(1,2);
% �ֿ�
[L L] = size(hostImg);

watermark_len = ((block_size/2)-1)*(block_size-2); % ��Ƕ�����еĳ��� 3*6 =18
index=1; % len_map������

% %%%%%%%%%%%%%%%%%%
% %%%%%% �ֿ� %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		% %%%%%%%%%%%%%%%%%%%%%
		% %%%% ����len_map %%%%
		% %%%%%%%%%%%%%%%%%%%%%
		index=1;
		E_m = imcrop(hostImg,[x1,y1,block_size-1,block_size-1]);
		% [len_map] = dsh_2_createBlockLenMap(E_m,block_size,bit_len);
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
						p(p_n)=E_m(r,l);
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
				wpe = (pe/abs(pe))*(abs(pe)*2+1);
				% %%%%%%%%%%%%%%%%%%%
				% %%%%%��len_map%%%%%
				% %%%%%%%%%%%%%%%%%%%
				if pe>(2^bit_len) || pe<-(2^bit_len) || pc+wpe>255 || pc+wpe<0 % ������Ԥ�������󣬺�Ƕ��󳬳���Χ����������ǲ�����Ƕ��
					len=-1; % len_map Ƕ��-1
					len_map(mod(index-1,3)+1,floor((index-1)/3)+1)=len;
				else
					len=1; % ��ʼlen=1
					pe=abs(pe); % ȡ����ֵ����len�ļ���
					% %%%%%%%%%%%%%
					% %% ����len %%
					% %%%%%%%%%%%%%
					while pe>=2
						pe=floor(pe/2);
						len=len+1;
					end
					lx=mod(index-1,3)+1;
					ly=floor((index-1)/3)+1;
					len_map(lx,ly)=len; % ��len����len_map
				end
				index=index+1; % hash��������+1
			end % for
		end % for

		len_maps(block_num,:)={block_num,len_map};
		block_num = block_num+1;
	end % for
end % for
end

