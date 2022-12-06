function [feats,des]=harris_detect(SDIS,sigma,image)
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
            point=detectHarrisFeatures(iimg,'MinQuality',0.02);
            feature=round(point.Location)+img_border;
            feature(:,3)=point.Metric;
            feature(:,4)=i;
            feature(:,5)=p;
            feature(:,6)=q;
%             feature(:,1:2)=2^(p-2)*(feature(:,1:2)+img_border);
            feature1=nms(img,feature);
            features=[features;feature1];
        end
    end
end
% features[x,y,R,k,o,s]
features=sortrows(features,-3);
nfeature=features(:,1:2);
[nfeatures,ia,~]=unique(nfeature,'rows');
nfeatures(:,3:6)=features(ia,3:6);
clear nfeature;   clear features;    clear ia;
num=size(nfeatures,1);    % 关键点的数量
bins=12;    % 直方图的柱数
radius=8;     % 中心圆的半径为4,最外层圆的半径为8
for i=1:num   % parfor
    feat=nfeatures(i,:);    % 特征格式[x,y,R,k,octvs,intvl]
    img=SDIS{feat(5),feat(4)}(:,:,feat(6));   % 当前特征所在的图像
    cur_sigma=sigma{feat(5),feat(4)}(feat(6));
    [feats(i,:),des(i,:)]=calcOri(img,cur_sigma,feat,radius,bins);
end
end















