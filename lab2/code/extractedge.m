function edgecurves = extractedge(inpic, scale, threshold, shape)
    if (nargin < 4)
        shape = 'same';
    end
    inpicsm = discgaussfft(inpic, scale);
    FD = Lv(inpicsm,shape);
    SD = Lvvtilde(inpicsm,shape);
    TD = Lvvvtilde(inpicsm,shape);
    FD = (FD > threshold) - 0.001;
    
    TDs = (TD < 0) - 0.001;
    
    curves = zerocrosscurves(SD,TDs);
    edgecurves = thresholdcurves(curves,FD);
    overlaycurves(inpic,edgecurves);
end
    