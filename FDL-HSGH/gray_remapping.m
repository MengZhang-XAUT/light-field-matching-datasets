function DIS= gray_remapping(iFDL)
% ��iFDL���лҶȱ任
parfor i=1:size(iFDL,4)    % ����Ҷ�Ӳ��Ĳ���
    img=iFDL(:,:,:,i);
    iimg=img(16:end-15,16:end-15,:);
    img1=iimg/max(iimg(:))*1;
%     img1=imadjust(img,[min(img(:)),max(img(:))],[0,1],0.5); %gammaУ��
%     for j=1:3
%         iiimg=img1(:,:,j);
%         img1(:,:,j)=imadjust(iiimg,[min(iiimg(:)),max(iiimg(:))],[0,1],0.5);
%     end
    DIS(:,:,:,i)=img1;
end