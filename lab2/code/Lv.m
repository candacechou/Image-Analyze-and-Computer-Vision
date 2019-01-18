function pixels = Lv(inpic, shape)
     if (nargin < 2)
       shape = 'same';
     end
     dxmask = [0 0 0;-1/2 0 1/2;0 0 0];
     dymask = [0 1/2 0;0 0 0;0 -1/2 0];
     Lx = conv2(inpic,dxmask, shape);
     Ly = conv2(inpic,dymask,  shape);
     pixels = Lx.^2 + Ly.^2;
end