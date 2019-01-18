function Lvv = Lvvtilde(img,shape)
    if (nargin < 2)
        shape = 'same';
    end
Sx = [0,0,0,0,0;
      0,0,0,0,0;      
      0,-0.5,0,0.5,0;
      0,0,0,0,0;
      0,0,0,0,0;];
Sy = [0,0,0,0,0;
      0,0,-0.5,0,0;
      0,0,0,0,0;
      0,0,0.5,0,0];
Sxx = [0,0,0,0,0;
       0,0,0,0,0;
       0,1,-2,1,0;
       0,0,0,0,0;
       0,0,0,0,0];
Syy = [0,0,0,0,0;
       0,0,1,0,0;
       0,0,-2,0,0;
       0,0,1,0,0];
Sxy = conv2(Sx,Sy,'same');


Lx = filter2(Sx,img,shape);
Ly = filter2(Sy,img,shape);
Lxx = filter2(Sxx,img,shape);
Lyy = filter2(Syy,img,shape);
Lxy = filter2(Sxy,img,shape);
Lvv = (Lx.^2).* Lxx + 2 * Lx .* Ly .* Lxy + (Ly.^2).*Lyy;
end