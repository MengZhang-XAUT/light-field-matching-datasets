function [mag_ori] = calcGrad(img,x,y)
% 计算邻域中当前点的梯度幅值和方向
img=(img*255);
[height,width] = size(img);
mag_ori = [0 0];
x=round(x);
y=round(y);
if (x > 1 && x < height && y > 1 && y < width)
    % x is vertical, from up to down
    dx = img(x-1,y) - img(x+1,y);
    dy = img(x,y+1) - img(x,y-1);
    mag_ori(1) = sqrt(dx*dx + dy*dy);   % 梯度幅值
    mag_ori(2) = atan2(dx,dy);              % 梯度方向
else
    mag_ori = -1;
end
end