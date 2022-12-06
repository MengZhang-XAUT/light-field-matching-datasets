function feats=detect(SDIS)
% SDIS: �߶�-�Ӳ�ռ�
k=size(SDIS,2);               % ����Ҷ�Ӳ�����
octvs=size(SDIS,1);         % ����
intvls=size(SDIS{1,1},3);   % ����
img_border=15;
features=[];
parfor i=1:k    % parfor
    for j=1:octvs
        for l=1:intvls
            img=SDIS{j,i}(:,:,l);
            point=detectHarrisFeatures(255*img(1+img_border:end-img_border,1+img_border:end-img_border),'MinQuality',0.01);
%             point=detectHarrisFeatures(255*img(1+img_border:end-img_border,1+img_border:end-img_border));
            feature=round(point.Location)+img_border;   % ������ʽ[y,x]
            feature(:,[1,2])=feature(:,[2,1]);                         % ����x��y
            feature(:,3)=point.Metric;                                % �ǵ���Ӧֵ
            feature(:,4)=j;                                                  % ����
            feature(:,5)=l;                                                  % ����
            feature(:,6)=i;                                                  % ����Ҷ�Ӳ�����
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