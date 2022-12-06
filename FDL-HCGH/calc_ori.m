function nfeats=calc_ori(feats,SDIS)
num=size(feats,1);    % �ؼ��������
bins=12;    % ֱ��ͼ������    % ע����20210303
radius=8;                         % ���㵱ǰ��������������Χ
parfor i=1:num
    hist=zeros(bins,1);
    SDS=SDIS;
    feats1=feats;
    img=SDS{feats1(i,5),feats1(i,4)}(:,:,feats1(i,6));
    for x=feats1(i,1)-radius:feats1(i,1)+radius
        for y=feats1(i,2)-radius:feats1(i,2)+radius
            [mag_ori] = calcGrad(img,x,y);
            if(mag_ori(1) ~= -1)
                bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % ���������е����ڵ�ֱ��ͼ�е���
                if(bin == bins +1)
                    bin = 1;
                end
                hist(bin) = hist(bin) + mag_ori(1);
            end
        end
    end
    [~,ori]=max(hist);
    feat(i)=ori;
end
nfeats=[feats,feat'];
end