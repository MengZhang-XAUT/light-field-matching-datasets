 %% ------------blender���ݼ�------------- %%
 %%% ----------------�ɹ�----------------- %%%
clear all;clc;
tic
Infile='D:\MATLAB\R2016b\bin\Blender_LFdata\data\';
% Infile='E:\MATLAB\R2016b\bin\Blender_database\��ת\';
number='dark office1';
numLayers=9;     % ����Ҷ�Ӳ��Ĳ���
name1=strcat(number,'-L ');
name2=strcat(number,'-R');
[LF1,FDL1,D1]=FDL_function(Infile,name1,numLayers);      %����Ҷ�Ӳ���ʾ
[LF2,FDL2,D2]=FDL_function(Infile,name2,numLayers);     
num1=sum(D1>0);
num2=sum(D2>0);
k=min(num1,num2);   % ����Ҷ�Ӳ��Ĳ���
k0=numLayers-k+1;
FDL1=FDL1(:,:,:,k0:numLayers);
FDL2=FDL2(:,:,:,k0:numLayers);
image1=LF1(:,:,:,5,5);
image2=LF2(:,:,:,5,5);
iFDL1=iFDL_function(FDL1);        % ����Ҷ��任�������Ӳ�ռ�
iFDL2=iFDL_function(FDL2);
% iFDL1_gamma = BT709_gamma(iFDL1(16:end-15,16:end-15,:,:));
DIS1= gray_remapping(iFDL1);     % �Ҷ�ӳ��
DIS2= gray_remapping(iFDL2);
[SDIS1,sigma1]= space_constrction(DIS1,D1);    % �߶�-�Ӳ�ռ乹��
[SDIS2,sigma2]= space_constrction(DIS2,D2);
feats1=detect(SDIS1);    % �������[x,y,R,octv,inyvl,k]
feats2=detect(SDIS2);
[features1,des1]=describe1(SDIS1,sigma1,feats1); %��������
[features2,des2]=describe1(SDIS2,sigma2,feats2);
matched=match(des1,des2);
featshow(image1,features1);
featshow(image2,features2);
drawMatched(matched,image1,image2,features1,features2,Infile,name1,name2)
toc


