% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                 %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Qian yuhan 2021.4.25�޶�
% �Ż�hash����
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [hash_sequence] = dsh_hashcode(rwImg_r,fwImg_b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% �÷�����������hash���룬��Ƕ��³��ˮӡ�ʹ���ˮӡ���Ӵ�һ������Ƕ�����

% ���룺rwImg_r---��Ҫ����hash����Ĳ�1
% ���룺rwImg_b---��Ҫ����hash����Ĳ�2
% �����hash_sequence---�������ɵı����ںϲ�����hash����256λ

% ---------------------------------------------------------

SHA256_1 = hash(rwImg_r,'SHA256');
SHA256_2 = hash(fwImg_b,'SHA256');
% c1=hex2dec(SHA256_1) ;
% b1=dec2bin(c1);
% c2=hex2dec(SHA256_2) ;
% b2=dec2bin(c2);
[n,n]=size(rwImg_r);
str='';
for i=1:n
	for j=1:n
        str1=num2str(rwImg_r(i,j));
        str2=num2str(fwImg_b(i,j));
        str=[str,str1,str2];
    end
end

hash_sequence = get_hash_sequence(SHA256_1,'MD5');



% hash_sequence1 = get_hash_sequence(SHA256_1,'MD5');
% hash_sequence2 = get_hash_sequence(SHA256_2,'MD5');
% 
% hash_sequence = zeros(1,256);
% for n=1:256
% 	hash_sequence(n)=xor(hash_sequence1(n),hash_sequence2(n));
% end
end
