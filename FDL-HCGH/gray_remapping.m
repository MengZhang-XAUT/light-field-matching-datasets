function DIS= gray_remapping(iFDL)
% ��iFDL���лҶȱ任
parfor i=1:size(iFDL,4)    % ����Ҷ�Ӳ��Ĳ���
    img=iFDL(:,:,:,i);
    iimg=img(16:end-15,16:end-15,:);
    img1=iimg/max(iimg(:))*1;
    DIS(:,:,:,i)=img1;
end