function hist=hist_rotate(hist1,hist2,hist3,hist4,hist5,index)
hist1=[hist1(index+1:end),hist1(1:index)];
hist2=[hist2(index+1:end),hist2(1:index)];
hist3=[hist3(index+1:end),hist3(1:index)];
hist4=[hist4(index+1:end),hist4(1:index)];
hist5=[hist5(index+1:end),hist5(1:index)];
hist=[hist1,hist2,hist3,hist4,hist5];

end