function [feats,des]=harris_detect_test(SDIS,sigma,image)
features=[];
k=size(SDIS,2);               %傅里叶视差层的层数
octvs=size(SDIS,1);            %  高斯金字塔的组数
intvls=size(SDIS{1,1},3);      % 高斯金字塔的层数
img_border=15;                 % 图像边界为15像素

parfor i=1:k    % parfor
    for p=1:octvs
        for q=1:intvls
            %% Harris角点检测，响应阈值为最大响应值的0.02
            img=SDIS{p,i}(:,:,q);
            iimg=img(1+img_border:end-img_border,1+img_border:end-img_border)*255;
            point=detectHarrisFeatures(iimg,'MinQuality',0.03);
            feature=round(point.Location)+img_border;
            feature(:,3)=point.Metric;
            feature(:,4)=i;
            feature(:,5)=p;
            feature(:,6)=q;
            feature(:,7)=sigma{p,i}(q);
            feature1=nms(img,feature);
            features=[features;feature1];
        end
    end
end
num=size(features,1);      %关键点的数量
bins=36;                   %梯度直方图的条数
ratio=0.8;
feat_index = 1;
for j=1:num
    ddata=features(j,:);
    ori_sigma=1.5*ddata(7);     % 1.5*sigma
    hist=orihist(SDIS{ddata(5),ddata(4)}(:,:,ddata(6)),ddata(1),ddata(2),bins,round(3*ori_sigma),ori_sigma);
    for k = 1:2
        hist=smoothOriHist(hist,bins); % 平滑梯度直方图，[0.25,0.5,0.25]
    end
    [feat_index,feats(j,:)] = addOriFeatures(j,feat_index,ddata,hist,bins,ratio);
end
end





