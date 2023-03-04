
p=65;
q=65;
Fhat = zeros(128, 128);
Fhat(p, q) = 1;
F = ifft2(Fhat);
%%%% question 1,2,3 and 4:
%% 
figure
fftwave(5,9)
figure
fftwave(1,1)
figure
fftwave(9,5)
figure
fftwave(17,9)
figure
fftwave(121,17)
figure
fftwave(5,1)
figure
fftwave(125,1)
%%
%%%% question 5:

fftwave(64,64)
figure
fftwave(128,128)
figure
fftwave(1,1)
%%
%%%% question 6: explain the code


%%%% question 7,8 and 9:


F = [zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

figure
subplot(3,2,1);
showgrey(F);
title('F');

subplot(3,2,3);
showgrey(G);
title('G');

subplot(3,2,5);
showgrey(H);
title('F+2G');

subplot(3,2,2);
showgrey(log(1 + abs(Fhat)));
%showgrey(log(1 + abs(fftshift(Fhat))));
title('Fhat');

subplot(3,2,4);
showgrey(log(1 + abs(Ghat)));
%showgrey(log(1 + abs(fftshift(Ghat))));
title('Ghat');

subplot(3,2,6);
showgrey(log(1 + abs(Hhat)));
%showgrey(log(1 + abs(fftshift(Hhat))));
title('Hhat');

%%%% question 10:

figure
showgrey(F .* G);
figure
showfs(fft2(F .* G));
figure
%figure
showfs(1/(128*128)*fftshift((conv2(fftshift(fft2(F)),fftshift(fft2(G)),'same'))));
%%% other way:
showfs();

%%%% question 11:
F_11 = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
         [zeros(128, 48) ones(128, 32) zeros(128, 48)];
figure
subplot(2,2,1);
showgrey(F .* G);
title('Original image');

subplot(2,2,2);
showfs(fft2(F .* G));
title('origin image in frequency domain');

subplot(2,2,3);
showgrey(F_11);
title('compression of F');

subplot(2,2,4);
F_11hat = fft2(F_11);
showfs(F_11hat);
title('compressed image in frequency domain');


%%%% question 12:
%original
figure
subplot(2,1,1);
showgrey(F_11);
title('original image of F');
subplot(2,1,2);
showfs(F_11hat);
title('frequency domain of image F');

%rotation 
alpha = 30;
figure
G = rot(F_11, alpha); 
subplot(4,3,1);
showgrey(G)
title('rotation(a=30) of F')
subplot(4,3,2);
% figure
% axis on
Ghat = fft2(G);
showfs(Ghat);
title('rotation(a=30) of F in freq');

subplot(4,3,3);
Hhat = rot(fftshift(Ghat), -alpha);
showgrey(log(1 + abs(Hhat)))
title('rotate back(a=30) of F in freq ');

alpha = 45;
G =rot(F_11,alpha);
subplot(4,3,4);
showgrey(G)
title('rotation(a=45)of F')
subplot(4,3,5);
% figure
% axis on
Ghat = fft2(G);
showfs(Ghat);
title('rotation(a=45)of F in freq');

subplot(4,3,6);
Hhat = rot(fftshift(Ghat), -alpha);
showgrey(log(1 + abs(Hhat)))
title('rotation back(a=45)of F in freq');

alpha = 60;
G = rot(F_11,alpha);
subplot(4,3,7);
showgrey(G)
title('rotation(a=60) of F')
subplot(4,3,8);
% figure
% axis on
Ghat = fft2(G);
showfs(Ghat);
title('rotation(a=60) of F in freq');

subplot(4,3,9);
Hhat = rot(fftshift(Ghat), -alpha);
showgrey(log(1 + abs(Hhat)))
title('rotation back(a=60) of F in freq');

alpha = 90;
G = rot(F_11,alpha);
subplot(4,3,10);
showgrey(G)
title('rotation(a=90) of F')
subplot(4,3,11);
% figure
% axis on
Ghat = fft2(G);
showfs(Ghat);
title('rotation(a=90) of F in freq');

subplot(4,3,12);
Hhat = rot(fftshift(Ghat), -alpha);
showgrey(log(1 + abs(Hhat)))
title('rotation back(a=90) of F in Freq');

% %%%% question 13:
img_1 = phonecalc128;
img_2 = few128;
img_3 = nallo128;
a = 1e-10;
img_1_p2i = pow2image(img_1,a);
img_2_p2i = pow2image(img_2,a);
img_3_p2i = pow2image(img_3,a);
img_1_rpi = randphaseimage(img_1);
img_2_rpi = randphaseimage(img_2);
img_3_rpi = randphaseimage(img_3);
%%% show graph and compare
figure
%%% phonecalc128
subplot(1,3,1);
showgrey(img_1);
title('original image of phonecalc128');
subplot(1,3,2);
showgrey(img_1_p2i);
title('replace power spectrum of phonecalc128');
subplot(1,3,3);
showgrey(img_1_rpi);
title('random phase of phonecalc128');
figure
%%% few128
subplot(1,3,1);
showgrey(img_2);
title('original image of few128');
subplot(1,3,2);
showgrey(img_2_p2i);
title('replace power spectrum of few128');
subplot(1,3,3);
showgrey(img_2_rpi);
title('random phase of few128');
figure
%%% nallo128
subplot(1,3,1);
showgrey(img_3);
title('original image of nallo128');
subplot(1,3,2);
showgrey(img_3_p2i);
title('replace power spectrum of nallo128');
subplot(1,3,3);
showgrey(img_3_rpi);
title('random phase of nallo128');
%%
figure
%%%% case 2: question 14,15 and 16
%1.testing with deltafcn
subplot(1,5,1);
t = 0.1;
psf = gaussfft(deltafcn(128,128),t);
showgrey(psf);
title('t=0.1');
va_01 = variance(psf)
subplot(1,5,2);
t = 0.3;
psf = gaussfft(deltafcn(128,128),t);
showgrey(psf);
title('t=0.3');
va_03 = variance(psf)

subplot(1,5,3);
t = 1.0;
psf = gaussfft(deltafcn(128,128),t);
showgrey(psf);
title('t=1.0');
subplot(1,5,4);
va_10 = variance(psf)

t = 10;
psf = gaussfft(deltafcn(128,128),t);
showgrey(psf);
title('t=10');
va_100 = variance(psf)

subplot(1,5,5);
t = 100;
psf = gaussfft(deltafcn(128,128),t);
showgrey(psf);
title('t=100');
va_1000 = variance(psf)
%%
%%% testing with real picture
%%% first image: phonecalc128
figure
subplot(3,2,1);
showgrey(img_1);
title('phonecal128');
subplot(3,2,2);
t = 1;
psf = gaussfft(img_1,t);
showgrey(psf);
title('t=1');
subplot(3,2,3);
t = 4;
psf = gaussfft(img_1,t);
showgrey(psf);
title('t=4');
subplot(3,2,4);
t = 16;
psf = gaussfft(img_1,t);
showgrey(psf);
title('t=4');
subplot(3,2,5);
t = 64;
psf = gaussfft(img_1,t);
showgrey(psf);
title('t=64');
subplot(3,2,6);
t = 256;
psf = gaussfft(img_1,t);
showgrey(psf);
title('t=256');
%%%% second image : few128
figure
subplot(3,2,1);
showgrey(img_2);
title('phonecalc128');
subplot(3,2,2);
t = 1;
psf = gaussfft(img_2,t);
showgrey(psf);
title('t=1');
subplot(3,2,3);
t = 4;
psf = gaussfft(img_2,t);
showgrey(psf);
title('t=4');
subplot(3,2,4);
t = 16;
psf = gaussfft(img_2,t);
showgrey(psf);
title('t=4');
subplot(3,2,5);
t = 64;
psf = gaussfft(img_2,t);
showgrey(psf);
title('t=64');
subplot(3,2,6);
t = 256;
psf = gaussfft(img_2,t);
showgrey(psf);
title('t=256');
%%% third image: nallo128
figure
subplot(3,2,1);
showgrey(img_3);
title('nallo128');
subplot(3,2,2);
t = 1;
psf = gaussfft(img_3,t);
showgrey(psf);
title('t=1');
subplot(3,2,3);
t = 4;
psf = gaussfft(img_3,t);
showgrey(psf);
title('t=4');
subplot(3,2,4);
t = 16;
psf = gaussfft(img_3,t);
showgrey(psf);
title('t=4');
subplot(3,2,5);
t = 64;
psf = gaussfft(img_3,t);
showgrey(psf);
title('t=64');
subplot(3,2,6);
t = 256;
psf = gaussfft(img_3,t);
showgrey(psf);
title('t=256');
%%

%%%% case 3: question 17 18 19 and 20
office = office256;
add = gaussnoise(office,16);
sap = sapnoise(office,0.1,256);
figure
subplot(1,3,1);
showgrey(office);
title('origin');
subplot(1,3,2);
showgrey(add);
title('add');
subplot(1,3,3);
showgrey(sap);
title('sap');

%%%% reduce noise 
%%
%%%% 1. Gaussian Smoothing
gauadd = gaussfft(add,2);
gausap = gaussfft(sap,2);
figure
subplot(2,1,1);
showgrey(gauadd);
title('gaussian filter with gaussian noise');
subplot(2,1,2);
showgrey(gausap);
%showgrey(gausap);
title('gaussian filter with sap noise');
%%
%%%% 2.median filter
medadd = medfilt(add,3,3);
medsap = medfilt(sap,3,3);
figure
subplot(2,1,1);
showgrey(medadd);
title('median filter with gaussian noise');
subplot(2,1,2);
showgrey(medsap);
title('median filter with sap noise');
%%
%%%% 3.low pass filter
lopasadd = ideal(add,0.3,'l');
lopassap = ideal(add,0.3,'l');
figure
subplot(2,1,1);
showgrey(lopasadd);
title('low pass filter with gaussian noise');
subplot(2,1,2);
showgrey(lopassap);
title('low pass filter with sap noise');
%%
%%%% 3.2 smoothing ans subsampling
img = phonecalc256;
smoothing = img;
N = 4;
%%%% low pass filter
figure
suptitle('low pass filter and subsampling');
for i=1:N
    if i>1
        img = rawsubsample(img);
        smoothing = ideal(smoothing,0.3,'l');
        smoothing = rawsubsample(smoothing);
    end
 
    subplot(2,N,i)
    showgrey(img)
    title(['n = ',num2str(i),' subsampling']);
    subplot(2,N,i+N)
    showgrey(smoothing)
    title(['n = ',num2str(i), ' with smoothing']);
end
%%
%%%% gaussian filter
img = phonecalc256;
smoothing = img;
figure
suptitle('gaussian filter and subsampling');
for i=1:N
    if i>1
        img = rawsubsample(img);
        smoothing = gaussfft(smoothing,0.7);
        smoothing = rawsubsample(smoothing);
    end
    subplot(2,N,i)
    showgrey(img)
    title(['n = ',num2str(i),' subsampling']);
    subplot(2,N,i+N)
    showgrey(smoothing)
    title(['n = ',num2str(i), ' with smoothing']);
end
%%
function revpic = gaussfft(pic,t)
picHat = fft2(pic);
[x,y] = size(picHat);
x1 = 0:x-1;
y1 = 0:y-1;
[x1g,x2g] = meshgrid(x1,y1);
x1g = fftshift(x1g,2);
x2g = fftshift(x2g,1);
gau = (1/(2*pi*t)) * exp(-((x1g - x/2).^2 + (x2g - y/2).^2)/(t*2));
gauHat = fft2(gau);

gxpic = gauHat .* picHat;
revpic = real(ifft2(gxpic));
end
function fftwave(u, v, sz)
  if (nargin <= 0) 
    error('Requires at least two input arguments.') 
  end
  if (nargin == 2) 
    sz = 128; 
  end
  
  Fhat = zeros(sz);
  Fhat(u, v) = 1;
  
  F = ifft2(Fhat);
  Fabsmax = max(abs(F(:)));
  
  subplot(3, 2, 1);
  showgrey(Fhat);
  title(sprintf('Fhat: (u, v) = (%d, %d)', u, v))
  
  % What is done by these instructions?
  if (u <= sz/2)
    uc = u - 1;
  else
    uc = u - 1 - sz;
  end
  if (v <= sz/2)
    vc = v - 1;
  else
    vc = v - 1 - sz;
  end
  
  wavelength = 1/sqrt(1/abs(uc-1)^2+1/abs(vc-1)^2);  % Replace by correct expression 
  amplitude = 1/(128);   % Replace by correct expression

  subplot(3, 2, 2);
  showgrey(fftshift(Fhat));
  title(sprintf('centered Fhat: (uc, vc) = (%d, %d)', uc, vc))
  %disp(uc)
  subplot(3, 2, 3);
  showgrey(real(F), 64, -Fabsmax, Fabsmax);
  title('real(F)')
  
  subplot(3, 2, 4);
  showgrey(imag(F), 64, -Fabsmax, Fabsmax);
  title('imag(F)')
  
  subplot(3, 2, 5);
  showgrey(abs(F), 64, -Fabsmax, Fabsmax);
  title(sprintf('abs(F) (amplitude %f)', amplitude))
  
  subplot(3, 2, 6);
  showgrey(angle(F), 64, -pi, pi);
  title(sprintf('angle(F) (wavelength %f)', wavelength))
  end
 
