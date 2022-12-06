function [SDIS,sigma]= space_constrction(DIS,D)
%% ��������
% DIS:�Ӳ�ռ䣬��СΪ��x,y,3,k��,kΪ����Ҷ�Ӳ��Ĳ���
% D���Ӳ�ֵ�б���СΪk*1
% SDIS���߶�-�Ӳ�ռ�
%%
[m,n,c,k]=size(DIS); %#ok<ASGLU>
octvs=3;    %��˹������Ϊ3��
intvls=3;    %��˹������Ϊ3��
s=2^(1/intvls);     % ����ϵ��
gDIS=zeros(m,n,k);           % �ҶȻ����Ӳ�ռ�Ĵ�С
SDIS=cell(octvs,k);                  % �߶��Ӳ�ռ�Ĵ�С  
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