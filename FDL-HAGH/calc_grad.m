function [hist1,hist2,hist3,hist4,hist5]=calc_grad(I,bins,radius)
dx=zeros(size(I,1)-2,size(I,2)-2);
dy=zeros(size(I,1)-2,size(I,2)-2);
parfor i=2:size(I,1)-1
    dx(i-1,:)=I(i+1,2:end-1)-I(i-1,2:end-1);
end
parfor i=2:size(I,2)-1
    dy(:,i-1)=I(2:end-1,i+1)-I(2:end-1,i-1);
end
mag1=sqrt(dx.^2+dy.^2);
mag2=atan2(dx,dy);
bin=1 + round( bins*(mag2 + pi)/(2*pi) );  
bin(bin==bins+1)=1;


hist1=zeros(1,bins);
hist2=zeros(1,bins);
hist3=zeros(1,bins);
hist4=zeros(1,bins);
hist5=zeros(1,bins);
cx=round(size(I,1)/2);
rx=-cx+1:cx-1;
ry=rx';
dis=sqrt(rx.^2+ry.^2);
dis(1,:)=[];
dis(end,:)=[];
dis(:,1)=[];
dis(:,end)=[];
bin_index=bin(dis<=sqrt(radius^2/5));   % 第一个圆
mag=mag1(dis<=sqrt(radius^2/5));
for i=1:size(bin_index)    
    hist1(bin_index(i))=hist1(bin_index(i))+mag(i);
end
clear bin_index; clear mag;
bin_index=bin(sqrt(radius^2/5)<dis & dis<=sqrt(radius^2/5*2));    % 第二个圆
mag=mag1(sqrt(radius^2/5)<dis & dis<=sqrt(radius^2/5*2));
for i=1:size(bin_index)
    hist2(bin_index(i))=hist2(bin_index(i))+mag(i);
end
clear bin_index; clear mag;
bin_index=bin(sqrt(radius^2/5*2)<dis & dis<=sqrt(radius^2/5*3));   % 第三个圆
mag=mag1(sqrt(radius^2/5*2)<dis & dis<=sqrt(radius^2/5*3));
for i=1:size(bin_index)
    hist3(bin_index(i))=hist3(bin_index(i))+mag(i);
end
clear bin_index; clear mag;
bin_index=bin(sqrt(radius^2/5*3)<dis & dis<=sqrt(radius^2/5*4));    % 第四个圆
mag=mag1(sqrt(radius^2/5*3)<dis & dis<=sqrt(radius^2/5*4));
for i=1:size(bin_index)
    hist4(bin_index(i))=hist4(bin_index(i))+mag(i);
end
clear bin_index; clear mag;
bin_index=bin(sqrt(radius^2/5*4)<dis & dis<=sqrt(radius^2/5*5));    % 第五个圆
mag=mag1(sqrt(radius^2/5*4)<dis & dis<=sqrt(radius^2/5*5));
for i=1:size(bin_index)
    hist5(bin_index(i))=hist5(bin_index(i))+mag(i);
end
end
