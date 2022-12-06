function [features,des]=describe1(SDIS,sigma,feats)
%  SDIS: �߶�-�Ӳ�ռ�
%  feats: ����[x,y,R,octv,intvl,k]
bins=12;       % ÿ�����������ֱ��ͼ��Ϊ12��bin
radius=10;
sector=12;    % ��360�Ȼ���Ϊ12������
threshold=0.2;
parfor i=1:size(feats,1)     %  parfor
    feat=feats(i,:);                     %   [x,y,R,octv,intvl,k]
    img=SDIS{feat(4),feat(6)}(:,:,feat(5));
    cur_sigma=sigma{feat(4),feat(6)}(feat(5));
    [hist]=calc_grad(img(feat(1)-radius-1:feat(1)+radius+1,feat(2)-radius-1:feat(2)+radius+1),bins,sector);
%     calchist(mag1,mag2);
    Hist=sum(hist);
    [~,index]=max(Hist);   % ������
    hist=[hist(index:end,:);hist(1:index-1,:)];
    hist=reshape(hist',[1,12*12]);
    hist = hist/norm(hist);
    hist = min(threshold,hist);
    hist = hist/norm(hist);
    des(i,:)=hist;
    features(i,:)=[feat(1)*2^(feat(4)-2),feat(2)*2^(feat(4)-2),cur_sigma];
end
end