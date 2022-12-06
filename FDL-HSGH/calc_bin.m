function [hist_col1,hist_col2,hist_col3,hist_col4,hist_col5]=calc_bin(mag_ori,bins,dis,radius)
hist_col1=zeros(1,bins);
hist_col2=zeros(1,bins);
hist_col3=zeros(1,bins);
hist_col4=zeros(1,bins);
hist_col5=zeros(1,bins);
if mag_ori~=-1
    bin = 1 + round( bins*(mag_ori(2) + pi)/(2*pi) );  % 计算邻域中点所在的直方图中的柱
    if bin==bins+1
        bin=1;
    end
    if dis<=sqrt(radius^2/5)
        hist_col1(bin)=hist_col1(bin)+mag_ori(1);
    elseif dis<=sqrt(radius^2/5*2)
        hist_col2(bin)=hist_col2(bin)+mag_ori(1);
    elseif dis<=sqrt(radius^2/5*3)
        hist_col3(bin)=hist_col3(bin)+mag_ori(1);
    elseif dis<=sqrt(radius^2/5*4)
        hist_col4(bin)=hist_col4(bin)+mag_ori(1);
    elseif dis<=radius
        hist_col5(bin)=hist_col5(bin)+mag_ori(1);
    else

    end
end




end


