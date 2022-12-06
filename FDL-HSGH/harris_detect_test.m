function [feats,des]=harris_detect_test(SDIS,sigma,image)
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
num=size(features,1);      %�ؼ��������
bins=36;                   %�ݶ�ֱ��ͼ������
ratio=0.8;
feat_index = 1;
for j=1:num
    ddata=features(j,:);
    ori_sigma=1.5*ddata(7);     % 1.5*sigma
    hist=orihist(SDIS{ddata(5),ddata(4)}(:,:,ddata(6)),ddata(1),ddata(2),bins,round(3*ori_sigma),ori_sigma);
    for k = 1:2
        hist=smoothOriHist(hist,bins); % ƽ���ݶ�ֱ��ͼ��[0.25,0.5,0.25]
    end
    [feat_index,feats(j,:)] = addOriFeatures(j,feat_index,ddata,hist,bins,ratio);
end
end





