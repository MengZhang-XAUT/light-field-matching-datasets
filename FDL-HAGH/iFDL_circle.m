function iFDL_circle(c, r, nsides, col, varargin)
% c:  ����㣨�Ըõ�Ϊ���Ļ�Բ��
% r:  �뾶
% nsides:  ����ν����еĿ�ѡ����
% col:  ��ѡ��ɫֵ
% varargin:  ��ѡ����
if isempty(nsides)==1
    nsides=16;
end
if isempty(col)==1
    col=[0,0,1];
end
nsides = max(round(nsides),3);   %ȷ������ο�ѡ����Ϊ�������Ҵ���3
a = [0:2*pi/nsides:2*pi];
line(r*cos(a)+c(1), r*sin(a)+c(2), 'color', col, varargin{:});