function LF=zm_loadLF(Infile,name,uRange,vRange)
%% ----------´ýÓÅ»¯£¿£¿£¿----------%%%
% % % image=imread(strcat(Infile,name,'\1_1.jpg'));
% % % [m,n,c]=size(image);
% % % LF=zeros(m-2,n-2,c,length(uRange),length(vRange));
% LF=zeros(m,n,c,length(uRange),length(vRange));
u=uRange;   v=vRange;
for i=u
    for j=v
        img=imread(strcat(Infile,name,'\',num2str(i),'_',num2str(j),'.jpg'));
        LF(:,:,:,j,i)=img;
    end
end