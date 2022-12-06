function IFDL=render_FDL(FDL,D)
radius=single(0);
ApShapes={'polygon','disk','ring','rect'};
ApShapeId = 1;
numBlades = 5;
apThickness = 1;
apAngle = 0;
u0 = 0;
v0 = 0;
s = single(0);
SpatialApRes = 50;       %spatial resolution of the aperture radius.
FreqApResIncrease = 400;
fullSize=[size(FDL,1),size(FDL,2)];   % Í¼Ïñ´óÐ¡
[wx,wy] = meshgrid(1:fullSize(2),1:fullSize(1));
xC = ceil((fullSize(2)+1)/2);
yC = ceil((fullSize(1)+1)/2);
wx=single((wx(:,1:xC)-xC)/(fullSize(2)-1));
wy=single((yC-wy(:,1:xC))/(fullSize(1)-1));
nChan = size(FDL,3);
numDisp = length(D);
even_fft = 1-mod(fullSize(1:2),2);
crop = [15,15,15,15];
FDL=FDL(:,1:xC,:,:);
Disps = zeros(1,1,1,numDisp);
Image_ = gpuArray(zeros([fullSize(1:2), nChan]));
Disps(1,1,1,:)=D;
ApShapeId0 = ApShapeId;
radius0 = radius;
s0 = s;
ApShapeId=4;

[Ap, Apfft, dWu, dWv, uC, vC, radCorrection] = buildAperture(ApShapes{ApShapeId},SpatialApRes,FreqApResIncrease,[apThickness,numBlades,apAngle]);
trueRadius = radius * radCorrection / SpatialApRes;
Apfft = Apfft/Apfft(vC,uC);
Apfft = complex(single(Apfft));

MinErrMap=inf(size(Image_,1),size(Image_,2),2,'single');
DispMap = zeros(size(Image_,1),size(Image_,2));
for k=1:numDisp
    s = Disps(k);
    radius=0;
%         renderImage();
%     Image_(:,1:xC,:) = RenderHalfFT(FDL, wx, wy, Disps, Apfft, dWu, dWv, uC, vC, s, radius, u0, v0);
%     Image_(yC+1:end,xC+1:end,:) = conj(Image_(yC-1:-1:1+even_fft(1),xC-1:-1:1+even_fft(2),:,:));
%     Image_(1+even_fft(1):yC, xC+1:end,:) = conj(Image_(end:-1:yC, xC-1:-1:1+even_fft(2),:,:));
%     Image_ = ifft2(ifftshift(ifftshift(Image_,1),2));
%     Image_(1+crop(3):end-crop(4),1+crop(1):end-crop(2),:) = BT709_gamma(Image_(1+crop(3):end-crop(4),1+crop(1):end-crop(2),:));
%     Image = gather( real(uint8(255*Image_(1+crop(3):end-crop(4),1+crop(1):end-crop(2),:))));
    Image=render_image(FDL, wx, wy, Disps, Apfft, dWu, dWv, uC, vC, s, radius, u0, v0,xC,yC,even_fft,crop);
end



