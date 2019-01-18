function [linepar acc] = houghline(pic,curves, magnitude, nrho, ntheta, threshold, nlines, verbose)

%%% define an accumulator                                    
acc = zeros(nrho,ntheta);
thetalin = linspace(-pi/2,pi/2,ntheta);
longrho = sqrt(size(pic,1)^2 + size(pic,2)^2);
rholin = linspace(-longrho,longrho,nrho);

insize = size(curves, 2);
trypointer = 1;
numcurves = 0;

while trypointer <= insize
  polylength = curves(2, trypointer);
  numcurves = numcurves + 1;
  trypointer = trypointer + 1;

  for polyidx = 1:polylength
    x = curves(2, trypointer);
    y = curves(1, trypointer);
    trypointer = trypointer + 1;
    %%% threshold
    if magnitude(round(x),round(y)) < threshold
        continue
    end
    magni = abs(magnitude(round(x),round(y)));
    if verbose==1
        delta_s = 1;
    elseif verbose ==2
        delta_s = log(magni);
    elseif verbose ==3
        delta_s = magni^2;
    end
    for thetaidx = 1:ntheta
        theta = thetalin(thetaidx);
        rho = x * cos(theta) + y * sin(theta);
        %%% add it to the accumulator
        %%1.find the index of rho
        rhoindex = find(rholin < rho,1,'last');
        acc(rhoindex,thetaidx) = acc(rhoindex,thetaidx)+ delta_s;
        
    end 
  end
end
%%% DT should be in the interval [0,1/2]
acc = binsepsmoothiter(acc,0.1,20);
%%% smooth the accumolator
%%%detect the local maxima and create an index vector from these:
[pos, value] = locmax8(acc);

[~, indexvector] = sort(value);
nmaxima = size(value, 1);
%%%% extract the lines from acc
linepar = zeros(2,nlines);
for idx = 1:nlines
           rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
           thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);
           rho = rholin(rhoidxacc)
           theta = thetalin(thetaidxacc)
           linepar(:,idx) = [rho;theta];
end
end