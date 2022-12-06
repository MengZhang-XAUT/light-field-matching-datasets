function Image=render_image(FDL, wx, wy, Disps, Apfft, dWu, dWv, uC, vC, s, radius, u0, v0,xC,yC,even_fft,crop)
    FDL=gpuArray(FDL);
    wx=gpuArray(wx);
    wy=gpuArray(wy);
    Disps=gpuArray(Disps);
    Apfft=gpuArray(Apfft);
    Image_(:,1:xC,:) = RenderHalfFT(FDL, wx, wy, Disps, Apfft, dWu, dWv, uC, vC, s, radius, u0, v0);
    Image_(yC+1:end,xC+1:end,:) = conj(Image_(yC-1:-1:1+even_fft(1),xC-1:-1:1+even_fft(2),:,:));
    Image_(1+even_fft(1):yC, xC+1:end,:) = conj(Image_(end:-1:yC, xC-1:-1:1+even_fft(2),:,:));
    Image_ = ifft2(ifftshift(ifftshift(Image_,1),2));
    Image_(1+crop(3):end-crop(4),1+crop(1):end-crop(2),:) = BT709_gamma(Image_(1+crop(3):end-crop(4),1+crop(1):end-crop(2),:));
    Image = gather( real(uint8(255*Image_(1+crop(3):end-crop(4),1+crop(1):end-crop(2),:))));


end