function featshow(image,features)
% % % figure; imshow(image,[]); hold on;
% % % num=size(features,1);
% % % for i=1:num
% % %     feat=features(i,:);
% % %     x=round(feat(2));   y=round(feat(1));
% % % %     sigma=feat(4);
% % %     plot(x,y,'g*');
% % % end
[n,~]=size(features);
figure;imshow(image,[]); hold on;
MinSlope = min(features(:,3));                 % 焦点堆栈索引的最小值
SlopeRange = max(1, max(features(:,3)) - MinSlope);    
for i=1:n
    curfeat=features(i,:);   %得到第i行的特征信息
    Color = (curfeat(3)-MinSlope)/SlopeRange;
    RGBColor = [1-Color, 1-2*abs(Color-0.5), Color];
    iFDL_circle( [curfeat(2), curfeat(1)], curfeat(3), [],RGBColor, 'linewidth', 2 );
end
end