function hist=orihist(img,x,y,bins,rad,sigma)
% 计算梯度直方图
% img：当前特征点所在的高斯金字塔的对应的图像
% x，y：当前特征点在图像中的位置
% n：梯度直方图的条数
% rad: 梯度直方图的邻域范围是round(3*sigma)
% sigma：当前特征点所在高斯金字塔中对应的尺度的1.5倍，sigma=1.5*ddata.scl_octv
hist=zeros(bins,1);
for i=-rad:rad
    for j=-rad:rad
        [mag_ori] = calcGrad(img,x+i,y+j);   %mag_ori(1)为当前点的梯度幅值，mag_ori(2)为当前点的梯度方向
        if(mag_ori(1) ~= -1)
            w = exp( -(i*i+j*j)/(2*sigma*sigma) );   % 平滑因子：该像素点距离特征点的距离进行高斯加权
            bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % 计算邻域中点所在的直方图中的柱
            if(bin == bins +1)
                bin = 1;
            end
            hist(bin) = hist(bin) + w*mag_ori(1);    % 将当前的梯度幅值乘以权值w加到梯度直方图所在的柱
        end
    end
end
end