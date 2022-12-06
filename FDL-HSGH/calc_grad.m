function [hist]=calc_grad(I,bins,sector)
dx=zeros(size(I,1)-2,size(I,2)-2);
dy=zeros(size(I,1)-2,size(I,2)-2);
parfor i=2:size(I,1)-1
    dx(i-1,:)=I(i+1,2:end-1)-I(i-1,2:end-1);
end
parfor i=2:size(I,2)-1
    dy(:,i-1)=I(2:end-1,i+1)-I(2:end-1,i-1);
end
mag1=sqrt(dx.^2+dy.^2);     %�ݶȷ�ֵ
mag2=atan2(dx,dy);              %�ݶȷ���
bin=1 + round( bins*(mag2 + pi)/(2*pi) );  
bin(bin==bins+1)=1;

for i=-10:10
    for j=-10:10
        [theta,rho]=cart2pol(i,j);
        theta_s(i+11,j+11)=rad2deg(theta)+180;     %������ϵ�еĽǶ�ֵ����Χ[0,360]
        rho_s(i+11,j+11)=rho;                                 %������ϵ�еĳ���
    end
end
hist=zeros(sector,bins);    %360�ȷ�Ϊsector����������ÿ�����������ֱ��ͼbins����
for i=1:size(bin,1)
    for j=1:size(bin,2)
        if rho_s(i,j)<=10
            ibin=floor(theta_s(i,j)/(360/sector))+1;     % ���ĸ�������
            if ibin==bins+1
                ibin=1;
            end
            hist(ibin,bin(i,j))=hist(ibin,bin(i,j))+mag1(i,j);
        end
    end
end
end
