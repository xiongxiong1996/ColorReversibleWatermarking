function [w_sequence] = dq_prepareWatermark(wImg,a,b,n)
% DQ_PREPAREWATERMARK Summary of this function goes here
% ��ˮӡͼ�����Ԥ����
% DQ_ROBUSTATTACT_TEST Summary of this function goes here
% ³��ˮӡ�������ԣ����Ը���³������
%   Detailed explanation goes here
% ���룺wImg----------ˮӡͼ��
% ���룺a,b,n----------Anorld�����õ��Ĳ���
% �����w_sequence----------ˮӡ����
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ����������С��7���n,a,bĬ��ֵ��
if nargin < 2
	n = 10;
	a=3;
	b=5; 
end
% ����������С��2���n,a,bĬ��ֵ��
w_sequence=zeros(1,n*n); % ����ˮӡ����
thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wbImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
w_Img = dsh_arnold(wbImg,n,a,b); % ˮӡ���Ҵ��� n=10 a=3 b=5


[n n] =size(w_Img); % ��ȡˮӡͼ��Ĵ�С
% %%%%%%%%%%%%%%%%%%%%
% %%% ��дˮӡ���� %%%
% %%%%%%%%%%%%%%%%%%%%
w_s_num=1;
for i=1:n
	for j=1:n
		w_sequence(w_s_num)=w_Img(i,j);
		w_s_num=w_s_num+1;
	end
end


end