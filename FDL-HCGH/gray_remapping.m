function DIS= gray_remapping(iFDL)
% 将iFDL进行灰度变换
parfor i=1:size(iFDL,4)    % 傅里叶视差层的层数
    img=iFDL(:,:,:,i);
    iimg=img(16:end-15,16:end-15,:);
    img1=iimg/max(iimg(:))*1;
    DIS(:,:,:,i)=img1;
end