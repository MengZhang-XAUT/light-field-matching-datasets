function [feat_index,features] = addOriFeatures(ddata_index,feat_index,ddata,hist,bins,ratio)
% Function: Add good orientation for keypoints
% ddata_index���ڼ���������
% feat_index�������������ڼ�������
% ddata����ǰ���������Ϣ������λ��x,y������octv������intvl��ƫ����x-hat���߶�sigma
% hist����ǰ��������ݶ�ֱ��ͼ��36*1 double 
% n���ݶ�ֱ��ͼ������
% ratio��0.8
% global feature;
omax=max(hist);   % �ݶ�ֱ��ͼ��߷�
for i=1:bins
    if i==1
        l=bins;
        r=2;
    elseif i==bins
        l=bins-1;
        r=1;
    else
        l=i-1;
        r=i+1;
    end
    if hist(i)>hist(l) && hist(i)>hist(r) && hist(i) == omax
        bin=i+0.5*(hist(l)-hist(r))/(hist(l)-2*hist(i)+hist(r));
        if ( bin -1 <= 0 )
            bin = bin + bins;
        elseif ( bin -1 > bins) % �����ϲ�����
            bin = bin - bins;
            disp('###################what the fuck?###################');
        end
        features(feat_index,1)=ddata_index;
        features(feat_index,2)=ddata(1)*2^(ddata(5)-2);% �������������ڵĸ�˹���������������任������ͼ���С������λ��
        features(feat_index,3)=ddata(2)*2^(ddata(5)-2);
        features(feat_index,4)=ddata(7);
        features(feat_index,5)=(bin-1)/bins*2*pi - pi;  %��ֱ��ͼ����Ӧ����Ӧ��-180~180����
        feat_index = feat_index + 1;
    end
end
end







