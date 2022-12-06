function [feature,des]=calcOri(img,cur_sigma,feat,radius,bins)
% SDIS：尺度视差空间
% feat：特征，格式为[x,y,R,k,octvs,intvls]
% radius：进行特征描述的邻域范围[-radius:radius]
% bins：梯度直方图的柱数
% hist：梯度直方图
o=feat(5);   % 当前特征点所在的组数
x=feat(1);
y=feat(2);
hist1=zeros(1,bins);
hist2=zeros(1,bins);
hist3=zeros(1,bins);
hist4=zeros(1,bins);
descr_mag_thr=0.2; % 去除光照影响进行归一化处理的阈值
for i=-radius:radius
    for j=-radius:radius
        [mag_ori] = calcGrad(img,x+i,y+j);
        d=sqrt(i^2+j^2);      % 邻域内像素距离角点的距离，将其划分到四个同心圆中
        if(mag_ori(1) ~= -1)
%             w = exp( -(i*i+j*j)/(2*cur_sigma*cur_sigma) );   % 平滑因子：该像素点距离特征点的距离进行高斯加权
            w=1;
            bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % 计算邻域中点所在的直方图中的柱
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