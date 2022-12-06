function [feats,des]=harris_detect(SDIS,sigma,image)
features=[];
k=size(SDIS,2);               %����Ҷ�Ӳ��Ĳ���
octvs=size(SDIS,1);            %  ��˹������������
intvls=size(SDIS{1,1},3);      % ��˹�������Ĳ���
img_border=15;                 % ͼ��߽�Ϊ15����

parfor i=1:k    % parfor
    for p=1:octvs
        for q=1:intvls
            %% Harris�ǵ��⣬��Ӧ��ֵΪ�����Ӧֵ��0.02
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
num=size(nfeatures,1);    % �ؼ��������
bins=12;    % ֱ��ͼ������
radius=8;     % ����Բ�İ뾶Ϊ4,�����Բ�İ뾶Ϊ8
for i=1:num   % parfor
    feat=nfeatures(i,:);    % ������ʽ[x,y,R,k,octvs,intvl]
    img=SDIS{feat(5),feat(4)}(:,:,feat(6));   % ��ǰ�������ڵ�ͼ��
    cur_sigma=sigma{feat(5),feat(4)}(feat(6));
    [feats(i,:),des(i,:)]=calcOri(img,cur_sigma,feat,radius,bins);
end
end















