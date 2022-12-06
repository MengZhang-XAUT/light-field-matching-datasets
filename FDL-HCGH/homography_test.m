function H=homography_test(img1,img2,Infile)
%% 单应性矩阵验证
name1=strcat(Infile,'mat\P',num2str(img1),'.mat');
s=load(name1);
P1=s.P1;
name2=strcat(Infile,'mat\P',num2str(img2),'.mat');
s=load(name2);
P2=s.P1;
H = CalcH(P1, P2);
% close(figure(4));
% close(figure(5));
end
%% 子函数
function H = CalcH(P1, P2)
x = P1(:, 1);
y = P1(:, 2);
X = P2(:, 1);
Y = P2(:, 2);
A = zeros(length(x(:))*2,9);
for i = 1:length(x(:))
    a = [x(i),y(i),1];
    b = [0 0 0];
    c = [X(i);Y(i)];
    d = -c*a;
    A((i-1)*2+1:(i-1)*2+2,1:9) = [[a b;b a] d];
end
[U S V] = svd(A);
h = V(:,9);
H = reshape(h,3,3)';
end