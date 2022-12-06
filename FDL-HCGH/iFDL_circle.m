function iFDL_circle(c, r, nsides, col, varargin)
% c:  坐标点（以该点为中心画圆）
% r:  半径
% nsides:  多边形近似中的可选边数
% col:  可选颜色值
% varargin:  可选参数
if isempty(nsides)==1
    nsides=16;
end
if isempty(col)==1
    col=[0,0,1];
end
nsides = max(round(nsides),3);   %确定多边形可选边数为整数，且大于3
a = [0:2*pi/nsides:2*pi];
line(r*cos(a)+c(1), r*sin(a)+c(2), 'color', col, varargin{:});