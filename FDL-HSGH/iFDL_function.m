function iFDL=iFDL_function(FDL)
n=size(FDL,4);
c=size(FDL,3);
parfor i=1:n
    for j=1:c
        img=FDL(:,:,j,i);
        iFDL(:,:,j,i)=abs(ifft2(ifftshift(img)));
%         iFDL(:,:,j,i)=abs(ifft2(ifftshift(ifftshift(img,1),2)));
%         iFDL(:,:,j,i)=ifft2(ifftshift(ifftshift(img,1),2));
    end
end

end










