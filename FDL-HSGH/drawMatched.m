function [] = drawMatched( matched, img1, img2, loc1, loc2,Infile,  name1, name2 )
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
err_count=0;
pair=zeros(n,5);
load(strcat(Infile,name1,'\mask.mat'));
% mask=mask(2:end-1,2:end-1);
load(strcat(Infile,name1,'\index.mat'));
for i = 1: n
  if (matched(i) > 0)
    P1=[ loc1(i,2) , loc1(i,1) ];                                  % 左图中计算出匹配的点[y,x]
    P2_match=round(loc2(matched(i),2:-1:1));      % 左图中的点在右图中的匹配位置[y,x]
    if P1(1)>0 && P1(2)>0
        P2_truth=mask{ceil(P1(2)),ceil(P1(1))};       % 左图中点在右图中的groundtruth匹配位置[x,y]
        if isempty(P2_truth)~=1  
            dis=sqrt((P2_match(1)-P2_truth(2))^2+(P2_match(2)-P2_truth(1))^2);
            if dis<30
                line([P1(1)+1,P2_match(1)+cols1+1], [P1(2)+1,P2_match(2)+1], 'Color', 'g');
                pair(i,:)=[P1(2),P1(1), P2_match(2),P2_match(1),1];
            else
                line([P1(1)+1,P2_match(1)+cols1+1], [P1(2)+1,P2_match(2)+1], 'Color', 'r');
                err_count=err_count+1;
                pair(i,:)=[P1(2),P1(1), P2_match(2),P2_match(1),0];
            end
        end
    end
  end
end
hold off;
pair=unique(round(pair),'rows');
num=size(pair,1)-1;
error=size(pair(find(pair(:,5)==0),:),1)-1;
% fprintf('Found %d matches.\n', num);
% fprintf('%d error matched.\n',error);
% precision=(num-error)/num;
% recall=(num-error)/sum(index(:));
% fprintf('precision is %d.\n', precision);
% fprintf('recall is %d.\n',recall);
TP=num-error;
FP=error;
FN=sum(index(:))-TP;
precision=TP/(TP+FP);
recall=TP/(TP+FN);
feature1=unique(round(loc1(:,1:2)));
feature2=unique(round(loc2(:,1:2)));
fprintf('image1 feature number: %d \n', size(feature1,1));
fprintf('image2 feature number: %d \n', size(feature2,1));
fprintf('TP: %d \n',TP);
fprintf('FP: %d \n',FP);
fprintf('FN: %d \n',FN);
fprintf('precision is %d.\n', precision);
fprintf('recall is %d.\n',recall);
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
