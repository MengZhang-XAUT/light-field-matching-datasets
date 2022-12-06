function [SDIS,sigma]= space_constrction(DIS,D)
%% 参数解释
% DIS:视差空间，大小为（x,y,3,k）,k为傅里叶视差层的层数
% D：视差值列表，大小为k*1
% SDIS：尺度-视差空间
%%
[m,n,c,k]=size(DIS); %#ok<ASGLU>
octvs=3;    %高斯金字塔为3组
intvls=3;    %高斯金字塔为3层
s=2^(1/intvls);     % 比例系数
gDIS=zeros(m,n,k);           % 灰度化的视差空间的大小
SDIS=cell(octvs,k);                  % 尺度视差空间的大小  
sigma=cell(octvs,k);
D=1./D;

for i=1:k
    img=DIS(:,:,:,i);
    gDIS(:,:,i)=rgb2gray(img);
    for p=1:octvs
        for q=1:intvls
            cur_sigma=2^(p-1)*s^(q-1)*0.8;
            sigma{p,i}(q)=cur_sigma;
            gimg=gDIS(:,:,i);
            gimg=imresize(gimg,(1/(2^(p-2))));
            h=fspecial('gaussian',double(round((4*cur_sigma)/2))*2+1,double(cur_sigma));
            gimg=imfilter(gimg,h);
            SDIS{p,i}(:,:,q)=gimg;
        end
    end 
end
end