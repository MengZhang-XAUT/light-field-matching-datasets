function hist=calc_hist(feat,img,radius,hist1,hist2,hist3,hist4,hist5)
% feat：[x,y,R,octv,intvl,k]
% img：特征描述所在的图像
% radius：特征描述邻域半径
% hist1,hist2,hist3,hist4,hist5：特征描述邻域从内向外的无个同心圆
% hist：特征描述符
threshold=0.2;
bins=length(hist1);
for p=-radius:radius
    for q=-radius:radius
        dis=sqrt(p^2+q^2);
        mag_ori=calcGrad(img,feat(1)+p,feat(2)+q);
        if mag_ori~=-1
            bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % 计算邻域中点所在的直方图中的柱
            if bin==bins+1
                bin=1;
            end
            w=1;
            if dis<=sqrt(20)
                hist1(bin)=hist1(bin)+w*mag_ori(1);
            elseif dis<=sqrt(20*2)
                hist2(bin)=hist2(bin)+w*mag_ori(1);
            elseif dis<=sqrt(20*3)
                hist3(bin)=hist3(bin)+w*mag_ori(1);
            elseif dis<=sqrt(20*4)
                hist4(bin)=hist4(bin)+w*mag_ori(1);
            elseif dis<=radius
                hist5(bin)=hist5(bin)+w*mag_ori(1);
            else

            end
        end
    end
end
Hist=0.5*hist1+0.2*hist2+0.1*hist3+0.1*hist4+0.1*hist5;
[~,index]=max(Hist);
hist1=[hist1(index+1:end),hist1(1:index)];
hist2=[hist2(index+1:end),hist2(1:index)];
hist3=[hist3(index+1:end),hist3(1:index)];
hist4=[hist4(index+1:end),hist4(1:index)];
hist5=[hist5(index+1:end),hist5(1:index)];
hist=[hist1,hist2,hist3,hist4,hist5];
hist = hist/norm(hist);
hist = min(threshold,hist);
hist = hist/norm(hist);
end


