
function Lvvv = Lvvvtilde(img,shape)
    if(nargin < 2)
        shape = 'same';
    end
Sx = [0,0,0,0,0;
      0,0,0,0,0;
      0,-0.5,0,0.5,0;
      0,0,0,0,0;
      0,0,0,0,0];
Sy = [0,0,0,0,0;
      0,0,-0.5,0,0;
      0,0,0,0,0;
      0,0,0.5,0,0;
      0,0,0,0,0];
Sxx = [0,0,0,0,0;
       0,0,0,0,0;
       0,1,-2,1,0;
       0,0,0,0,0;
       0,0,0,0,0];
Syy = [0,0,0,0,0;
       0,0,1,0,0;
       0,0,-2,0,0;
       0,0,1,0,0;
       0,0,0,0,0];
Sxy = conv2(Sx,Sy,shape);
Sxxy = conv2(Sxx,Sy,shape);
Sxyy = conv2(Sx,Syy,shape);
%Sxxx = [-1,3,-3,1,0];
%Syyy = [-1;3;-3;1;0];
Sxxx = conv2(Sx,Sxx,'same');
Syyy = conv2(Sy,Syy,'same');
Lx = filter2(Sx,img,shape);
Ly = filter2(Sy,img,shape);
Lxx = filter2(Sxx,img,shape);
Lyy = filter2(Syy,img,shape);
Lxy = filter2(Sxy,img,shape);
Lxxy = filter2(Sxxy,img,shape);
Lxyy = filter2(Sxyy,img,shape);
Lxxx = filter2(Sxxx,img,shape);
Lyyy = filter2(Syyy,img,shape);
Lvvv = (Lx.^3).*Lxxx+3*(Lx.^2).*Ly.*Lxxy + 3*Lx.*(Ly.^2).*Lxyy + (Ly.^3).*Lyyy;
end  