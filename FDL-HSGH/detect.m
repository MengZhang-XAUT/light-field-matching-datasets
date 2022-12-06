function feats=detect(SDIS)
% SDIS: 尺度-视差空间
k=size(SDIS,2);               % 傅里叶视差层层数
octvs=size(SDIS,1);         % 组数
intvls=size(SDIS{1,1},3);   % 层数
img_border=15;
features=[];
parfor i=1:k    % parfor
    for j=1:octvs
        for l=1:intvls
            img=SDIS{j,i}(:,:,l);
            point=detectHarrisFeatures(255*img(1+img_border:end-img_border,1+img_border:end-img_border),'MinQuality',0.01);
%             point=detectHarrisFeatures(255*img(1+img_border:end-img_border,1+img_border:end-img_border));
            feature=round(point.Location)+img_border;   % 特征格式[y,x]
            feature(:,[1,2])=feature(:,[2,1]);                         % 交换x和y
            feature(:,3)=point.Metric;                                % 角点响应值
            feature(:,4)=j;                                                  % 组数
            feature(:,5)=l;                                                  % 层数
            feature(:,6)=i;                                                  % 傅里叶视差层层数
            feature=nms(img,feature);
            features=[features;feature];
        end
    end
end
features=sortrows(features,-3);
feature=features(:,1:2);
[feats,ia,~]=unique(feature,'rows');
feats(:,3:6)=features(ia,3:6);
end