function [] = drawMatched_realLF( matched, img1, img2, loc1, loc2,InFile ,name1,name2 )
% Function: Draw matched points
% Create a new image showing the two images side by side.
img3 = appendimages(img1,img2);

% Show a figure with lines joining the accepted matches.
figure('Position', [100 100 size(img3,2) size(img3,1)]);
colormap gray;
imagesc(img3);
hold on;
cols1 = size(img1,2);
n = size(matched,2);
H=homography_test(name1,name2,InFile);   %计算单应性矩阵
err_count=0;
pair=zeros(n,5);
for i = 1: n
  if (matched(i) > 0)
    P1=[ loc1(i,2) , loc1(i,1) ];
    P2 = WarpH(P1 , H);
    dis=sqrt((P2(2)-loc2(matched(i),1))^2+(P2(1)-loc2(matched(i),2))^2);
    if dis<=30
        line([loc1(i,2) loc2(matched(i),2)+cols1], ...
            [loc1(i,1) loc2(matched(i),1)], 'Color', 'g');
        pair(i,:)=[loc1(i,2),loc1(i,1), loc2(matched(i),2),loc2(matched(i),1),1];
    else
        line([loc1(i,2),loc2(matched(i),2)+cols1], ...
            [loc1(i,1),loc2(matched(i),1)], 'Color', 'r');
        err_count=err_count+1;
        pair(i,:)=[loc1(i,2),loc1(i,1), loc2(matched(i),2),loc2(matched(i),1),0];
    end
  end
end
hold off;
pair=unique(round(pair),'rows');
num=size(pair,1)-1;
error=size(pair(find(pair(:,5)==0),:),1)-1;
fprintf('总匹配对数：%d \n', num);
fprintf('错误匹配对数： %d \n',error);
fprintf('正确匹配率： %d \n', (num-error)/num);
end



function im = appendimages(image1, image2)
% im = appendimages(image1, image2)
%
% Return a new image that appends the two images side-by-side.
% Select the image with the fewest rows and fill in enough empty rows
%   to make it the same height as the other image.
rows1 = size(image1,1);
rows2 = size(image2,1);
if (rows1 < rows2)
     image1(rows2,1) = 0;
else
     image2(rows1,1) = 0;
end
% Now append both images side-by-side.
im = [image1 image2];
end

function P2 = WarpH(P1, H)
x = P1(:, 1);
y = P1(:, 2);
p1 = [x'; y'; ones(1, length(x))];
q1 = H*p1;
q1 = q1./[q1(3, :); q1(3,:); q1(3, :)];
P2 = q1';
end
