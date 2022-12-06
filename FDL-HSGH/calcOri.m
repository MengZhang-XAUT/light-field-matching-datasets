function [feature,des]=calcOri(img,cur_sigma,feat,radius,bins)
% SDIS���߶��Ӳ�ռ�
% feat����������ʽΪ[x,y,R,k,octvs,intvls]
% radius��������������������Χ[-radius:radius]
% bins���ݶ�ֱ��ͼ������
% hist���ݶ�ֱ��ͼ
o=feat(5);   % ��ǰ���������ڵ�����
x=feat(1);
y=feat(2);
hist1=zeros(1,bins);
hist2=zeros(1,bins);
hist3=zeros(1,bins);
hist4=zeros(1,bins);
descr_mag_thr=0.2; % ȥ������Ӱ����й�һ���������ֵ
for i=-radius:radius
    for j=-radius:radius
        [mag_ori] = calcGrad(img,x+i,y+j);
        d=sqrt(i^2+j^2);      % ���������ؾ���ǵ�ľ��룬���仮�ֵ��ĸ�ͬ��Բ��
        if(mag_ori(1) ~= -1)
%             w = exp( -(i*i+j*j)/(2*cur_sigma*cur_sigma) );   % ƽ�����ӣ������ص����������ľ�����и�˹��Ȩ
            w=1;
            bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % ���������е����ڵ�ֱ��ͼ�е���
            if(bin == bins +1)
                bin = 1;
            end
% %             if d<2*radius/2
% %                 if d>sqrt(3)*radius/2
% %                     hist4(bin) = hist4(bin) + w*mag_ori(1);
% %                 elseif d>sqrt(2)*radius/2
% %                     hist3(bin) = hist3(bin) + w*mag_ori(1);
% %                 elseif d>radius/2
% %                     hist2(bin) = hist2(bin) + w*mag_ori(1);
% %                 else
% %                     hist1(bin) = hist1(bin) + w*mag_ori(1);
% %                 end
% %             else
% %                 
% %             end
            if d<=2
                hist1(bin) = hist1(bin) + w*mag_ori(1);
            elseif d<=4
                hist2(bin) = hist2(bin) + w*mag_ori(1);
            elseif d<=6
                hist3(bin) = hist3(bin) + w*mag_ori(1);
            elseif d<=8
                hist4(bin) = hist4(bin) + w*mag_ori(1);
            else
                
            end
        end
    end
end

HHist=hist1+hist2+hist3+hist4;
[~,index]=max(HHist);

hist1=[hist1(index+1:end) hist1(1:index)];
hist2=[hist2(index+1:end) hist2(1:index)];
hist3=[hist3(index+1:end) hist3(1:index)];
hist4=[hist4(index+1:end) hist4(1:index)];

des=[hist1,hist2,hist3,hist4];
des=des/norm(des);
des=min(descr_mag_thr,des);
des=des/norm(des);
feature=[round(feat(1)*2^(o-2)),round(feat(2)*2^(o-2)),feat(3),cur_sigma];
end