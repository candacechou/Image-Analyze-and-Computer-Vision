
function pixels = LvSmooth(inpic,shape,scale)
    if (nargin < 2)
       shape = 'same';
    end
     inpic = discgaussfft(inpic,scale);

     dxmask = [0 0 0;-1/2 0 1/2;0 0 0];
     dymask = [0 1/2 0;0 0 0;0 -1/2 0];
     Lx = filter2(dxmask, inpic, shape);
     Ly = filter2(dymask, inpic, shape);
     pixels = Lx.^2 + Ly.^2;
end
