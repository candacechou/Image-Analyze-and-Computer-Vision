phone = phonecalc256;
%image(phone)
%showgrey(phone,256);
vad =whatisthis256;
colormap(cool);
%showgrey(vad,64,2,256);
ninepic = indexpic9;
%image(ninepic);
rawsubsample(ninepic);
%image(ninepic);
nallo = nallo256;
load canoe256
%image(Canoe)
neg1 = - Canoe;
%showgrey(neg1);
neg2 = 255 - Canoe;
%showgrey(neg2);
nallo = nallo256;
%showgrey(nallo.^(1/3));
%showgrey(cos(nallo/10));
hist(neg1(:));
%hist(neg2(:));