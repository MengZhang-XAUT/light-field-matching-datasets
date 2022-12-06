 %% ------------blender数据集------------- %%
 %%% ----------------成功----------------- %%%
clear all;clc;
tic
Infile='E:\MATLAB\R2016b\bin\Blender_LFdata\data\';
number='Chess and shelf';
numLayers=7;     % 傅里叶视差层的层数
name1=strcat(num2str(number),'-L ');
name2=strcat(num2str(number),'-R');
[LF1,FDL1,D1]=FDL_function(Infile,name1,numLayers);      %傅里叶视差层表示
[LF2,FDL2,D2]=FDL_function(Infile,name2,numLayers);     
num1=sum(D1>0);
num2=sum(D2>0);
k=min(num1,num2);   % 傅里叶视差层的层数
k0=numLayers-k+1;
FDL1=FDL1(:,:,:,k0:numLayers);
FDL2=FDL2(:,:,:,k0:numLayers);
image1=LF1(:,:,:,5,5);
image2=LF2(:,:,:,5,5);
iFDL1=iFDL_function(FDL1);        % 傅里叶逆变换，生成视差空间
iFDL2=iFDL_function(FDL2);
DIS1= gray_remapping(iFDL1);     % 灰度映射
DIS2= gray_remapping(iFDL2);
[SDIS1,sigma1]= space_constrction(DIS1,D1);    % 尺度-视差空间构造
[SDIS2,sigma2]= space_constrction(DIS2,D2);
feats1=detect(SDIS1);    % 特征检测[x,y,R,octv,inyvl,k]
feats2=detect(SDIS2);
[features1,des1]=describe(SDIS1,sigma1,feats1); %特征描述
[features2,des2]=describe(SDIS2,sigma2,feats2);
matched=match(des1,des2);
featshow(image1,features1);
featshow(image2,features2);
drawMatched(matched,image1,image2,features1,features2,Infile,name1,name2)
toc


