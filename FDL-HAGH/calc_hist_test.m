function hist=calc_hist_test(feat,img,radius,hist1,hist2,hist3,hist4,hist5)
% feat：[x,y,R,octv,intvl,k]
% img：特征描述所在的图像
% radius：特征描述邻域半径
% hist1,hist2,hist3,hist4,hist5：特征描述邻域从内向外的无个同心圆
% hist：特征描述符
threshold=0.2;
bins=length(hist1);
parfor p=-radius:radius
    for q=-radius:radius
        dis=sqrt(p^2+q^2);
        mag_ori=calcGrad(img,feat(1)+p,feat(2)+q);   % 计算梯度
        if mag_ori~=-1
            bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % 计算邻域中点所在的直方图中的柱
            if bin==bins+1
                bin=1;
            end
            if dis<=sqrt(radius^2/5)
                hist1(bin)=hist1(bin)+mag_ori(1);
            elseif dis<=sqrt(radius^2/5*2)
                hist_col2(bin)=hist_col2(bin)+mag_ori(1);
            elseif dis<=sqrt(radius^2/5*3)
                hist_col3(bin)=hist_col3(bin)+mag_ori(1);
            elseif dis<=sqrt(radius^2/5*4)
                hist_col4(bin)=hist_col4(bin)+mag_ori(1);
            elseif dis<=radius
                hist_col5(bin)=hist_col5(bin)+mag_ori(1);
            else

            end
        end
        hist1=hist1+hist1;
        hist2=hist2+hist_col2;
        hist3=hist3+hist_col3;
        hist4=hist4+hist_col4;
        hist5=hist5+hist_col5;
    end
end
Hist=0.5*hist1+0.2*hist2+0.1*hist3+0.1*hist4+0.1*hist5;
[~,index]=max(Hist);   % 主方向
hist=hist_rotate(hist1,hist2,hist3,hist4,hist5,index);   %直方图左移位
hist = hist/norm(hist);
hist = min(threshold,hist);
hist = hist/norm(hist);
end



