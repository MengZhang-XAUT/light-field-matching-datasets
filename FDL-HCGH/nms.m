function nfeatures=nms(image,nfeatures)
%  nms(Non-Maximum Suppression)：非极大值抑制
%  image：输入图像的大小
%  nfeatures：特征点 [x,y,R,octv,intvl,k]
img=zeros(size(image,1),size(image,2));
nfeatures(:,1:2)=nfeatures(:,1:2);
radius=4;     % 非极大值抑制的窗口大小为6
for i=1:size(nfeatures,1)
    img(nfeatures(i,1),nfeatures(i,2))=nfeatures(i,3);
end
feat=nfeatures;
parfor i=1:size(nfeatures,1)
    x=feat(i,1);  y=feat(i,2);
    R=feat(i,3);
    s=radius*2^(2-feat(i,4));
    block=img(x-s:x+s,y-s:y+s);
    max_block=max(block(:));
    if max_block==R
        nfeatures(i,7)=1;
    else
        nfeatures(i,7)=0;
    end
end
if isempty(nfeatures)~=1
    nfeatures(find(nfeatures(:,7)==0),:)=[];
    nfeatures(:,7)=[];
end
end