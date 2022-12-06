function DIS= gray_remapping(iFDL)
% 将iFDL进行灰度变换
parfor i=1:size(iFDL,4)    % 傅里叶视差层的层数
    img=iFDL(:,:,:,i);
    iimg=img(16:end-15,16:end-15,:);
    img1=iimg/max(iimg(:))*1;
%     img1=imadjust(img,[min(img(:)),max(img(:))],[0,1],0.5); %gamma校正
%     for j=1:3
%         iiimg=img1(:,:,j);
%         img1(:,:,j)=imadjust(iiimg,[min(iiimg(:)),max(iiimg(:))],[0,1],0.5);
%     end
    DIS(:,:,:,i)=img1;
end