% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%  revision	     2021  Duan Shaohua <smartJack10101@gmail.com>	     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [taggedImg] = dsh_tamperrCertain2(tagged_map,uncertain_map,taggedImg,block_size,block_t_num)
% DSH_TAMPERRCERTAIN2 Summary of this function goes here
% �Ե�һ�εõ��Ĵ۸ļ��ͼ������һ�λָ�
%   Detailed explanation goes here
% ���룺tagged_map----------�۸Ķ�λͼ��
% ���룺uncertain_map----------���ƿ�ֲ�ͼ
% ���룺taggedImg----------�۸Ķ�λ�ֲ�ͼ
% ���룺block_size----------���С
% ���룺block_t_num----------��һ��3*3�������У���Χ8���飬��block_t_num�鱻�۸ģ�����Ϊ�ÿ�Ҳ���۸���
% �����taggedImg----------�޸ĺ�Ĵ۸Ķ�λͼ��
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% detal ���ڼ����Ե��
detal=0.7;
a1=1; % ��Χ�۸Ŀ�ϵ��
a2=0.4; % ��Χ���ɿ�ϵ��
[m_l m_l] = size(uncertain_map);
for i=1:m_l
	for j=1:m_l
		b_t_num=0;
		block_t_num_c=block_t_num;
        if uncertain_map(i,j)==1
			for n=i-1:i+1
				for m=j-1:j+1
				% Խ��鴦�����ٽ��м���
                    if n<1||m<1||n>m_l||m>m_l
                        if block_t_num>=1
							% ��ȥ��Ӧ����ֵ
							block_t_num_c=block_t_num_c-detal;
                        end
                    else
                        if tagged_map(n,m)==1
                            b_t_num=b_t_num+a1;
                        end
                        if uncertain_map(n,m)==1
                            b_t_num=b_t_num+a2;
                        end
                    end
				end
			end
        end
        if b_t_num>=block_t_num_c
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;
			taggedImg(y1:y2,x1:x2)=1;
        end
    end
end

end

