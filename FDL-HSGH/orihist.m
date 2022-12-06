function hist=orihist(img,x,y,bins,rad,sigma)
% �����ݶ�ֱ��ͼ
% img����ǰ���������ڵĸ�˹�������Ķ�Ӧ��ͼ��
% x��y����ǰ��������ͼ���е�λ��
% n���ݶ�ֱ��ͼ������
% rad: �ݶ�ֱ��ͼ������Χ��round(3*sigma)
% sigma����ǰ���������ڸ�˹�������ж�Ӧ�ĳ߶ȵ�1.5����sigma=1.5*ddata.scl_octv
hist=zeros(bins,1);
for i=-rad:rad
    for j=-rad:rad
        [mag_ori] = calcGrad(img,x+i,y+j);   %mag_ori(1)Ϊ��ǰ����ݶȷ�ֵ��mag_ori(2)Ϊ��ǰ����ݶȷ���
        if(mag_ori(1) ~= -1)
            w = exp( -(i*i+j*j)/(2*sigma*sigma) );   % ƽ�����ӣ������ص����������ľ�����и�˹��Ȩ
            bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % ���������е����ڵ�ֱ��ͼ�е���
            if(bin == bins +1)
                bin = 1;
            end
            hist(bin) = hist(bin) + w*mag_ori(1);    % ����ǰ���ݶȷ�ֵ����Ȩֵw�ӵ��ݶ�ֱ��ͼ���ڵ���
        end
    end
end
end