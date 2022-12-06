function [feat_index,features] = addOriFeatures(ddata_index,feat_index,ddata,hist,bins,ratio)
% Function: Add good orientation for keypoints
% ddata_index：第几个特征点
% feat_index：特征索引，第几个特征
% ddata：当前特征点的信息，包含位置x,y，组数octv，层数intvl，偏移量x-hat，尺度sigma
% hist：当前特征点的梯度直方图，36*1 double 
% n：梯度直方图的柱数
% ratio：0.8
% global feature;
omax=max(hist);   % 梯度直方图最高峰
for i=1:bins
    if i==1
        l=bins;
        r=2;
    elseif i==bins
        l=bins-1;
        r=1;
    else
        l=i-1;
        r=i+1;
    end
    if hist(i)>hist(l) && hist(i)>hist(r) && hist(i) == omax
        bin=i+0.5*(hist(l)-hist(r))/(hist(l)-2*hist(i)+hist(r));
        if ( bin -1 <= 0 )
            bin = bin + bins;
        elseif ( bin -1 > bins) % 理论上不可能
            bin = bin - bins;
            disp('###################what the fuck?###################');
        end
        features(feat_index,1)=ddata_index;
        features(feat_index,2)=ddata(1)*2^(ddata(5)-2);% 根据特征点所在的高斯金字塔的组把坐标变换到输入图像大小的坐标位置
        features(feat_index,3)=ddata(2)*2^(ddata(5)-2);
        features(feat_index,4)=ddata(7);
        features(feat_index,5)=(bin-1)/bins*2*pi - pi;  %将直方图柱对应到相应的-180~180度中
        feat_index = feat_index + 1;
    end
end
end







