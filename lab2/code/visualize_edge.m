function visualize_edge(img,linepar)
diagline = sqrt(size(img,1)^2 + size(img,2)^2);      
nlines = size(linepar,2);
for idx=1:nlines
    rho = linepar(1,idx);
    theta = linepar(2,idx);
    x0 = rho*cos(theta);
    y0 = rho*sin(theta);
    dx = diagline*sin(theta);
    dy = -diagline*cos(theta);
    outcurves(1, 4*(idx-1) + 1) = 0; % level, not significant
    outcurves(2, 4*(idx-1) + 1) = 3; % number of points in the curve
    outcurves(2, 4*(idx-1) + 2) = x0-dx;
    outcurves(1, 4*(idx-1) + 2) = y0-dy;
    outcurves(2, 4*(idx-1) + 3) = x0;
    outcurves(1, 4*(idx-1) + 3) = y0;
    outcurves(2, 4*(idx-1) + 4) = x0+dx;
    outcurves(1, 4*(idx-1) + 4) = y0+dy;
end
figure
overlaycurves(img,outcurves);
axis([1 size(img,1) 1 size(img,2)]);
end