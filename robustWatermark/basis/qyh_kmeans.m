function [re] = qyh_kmeans(data,isdisplay)
% QYH_KMEANS Summary of this function goes here
%   Detailed explanation goes here


% K-means����
N=3;% ���þ�����Ŀ
[m,n]=size(data);
re=zeros(m,n+1);
center=zeros(N,n);% ��ʼ����������
re(:,1:n)=data(:,:);
for x=1:N
    center(x,:)=data( randi(m,1),:);% ��һ�����������������
end
count_num=1;
while count_num<1000
	distence=zeros(1,N);
	num=zeros(1,N);
	new_center=zeros(N,n);
	 
	for x=1:m
	    for y=1:N
	    distence(y)=norm(data(x,:)-center(y,:));% ���㵽ÿ����ľ���
	    end
	    [~, temp]=min(distence);% ����С�ľ���
	    re(x,n+1)=temp;         
	end
	k=0;
	for y=1:N
	    for x=1:m
	        if re(x,n+1)==y
	           new_center(y,:)=new_center(y,:)+re(x,1:n);
	           num(y)=num(y)+1; % ��ÿ�����м���
	        end
	    end
	    new_center(y,:)=new_center(y,:)/num(y);
	    if norm(new_center(y,:)-center(y,:))<0.5
	        k=k+1;
	    end
	end
	if k==N % ����������ҵ������ĵ�
	     break;
	else
	     center=new_center;
	end
	count_num=count_num+1;
end


if isdisplay==1
	% %%%%%%%%%%%%%%%%%%%%
	% %%%%%%% չʾ %%%%%%%
	% %%%%%%%%%%%%%%%%%%%%

	[m, n]=size(re);
	figure;
	hold on;
	for i=1:m
	    if re(i,n)==1 
	         plot(re(i,1),'r+');
	         plot(center(1,1),'ko');
	    elseif re(i,n)==2
	         plot(re(i,1),'b*');
	         plot(center(2,1),'ko');
	    elseif re(i,n)==3
	         plot(re(i,1),'go');
	         plot(center(3,1),'ko');
	    else
	         plot(re(i,1),'m*');
	         plot(center(4,1),'ko');
	    end
	end
end





end



