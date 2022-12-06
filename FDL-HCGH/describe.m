function [features,des]=describe1(SDIS,sigma,feats)
%  SDIS: 尺度-视差空间
%  feats: 特征[x,y,R,octv,intvl,k]
bins=18;       % 18
radius=10;    % 10
threshold=0.2;
parfor i=1:size(feats,1)     %  parfor
    feat=feats(i,:);                     %   [x,y,R,octv,intvl,k]
    img=SDIS{feat(4),feat(6)}(:,:,feat(5));
    cur_sigma=sigma{feat(4),feat(6)}(feat(5));
    [hist1,hist2,hist3,hist4,hist5]=calc_grad(img(feat(1)-radius-1:feat(1)+radius+1,feat(2)-radius-1:feat(2)+radius+1),bins,radius);
%     calchist(mag1,mag2);
    Hist=0.5*hist1+0.2*hist2+0.1*hist3+0.1*hist4+0.1*hist5;
    [~,index]=max(Hist);   % 主方向
    hist=hist_rotate(hist1,hist2,hist3,hist4,hist5,index);   %直方图左移位
    hist = hist/norm(hist);
    hist = min(threshold,hist);
    hist = hist/norm(hist);
    des(i,:)=hist;
    features(i,:)=[feat(1)*2^(feat(4)-2),feat(2)*2^(feat(4)-2),cur_sigma];
end
end