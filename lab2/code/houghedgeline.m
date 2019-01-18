 function [linepar acc] = houghedgeline(pic, scale, gradmagnthreshold,nrho, ntheta, nlines, verbose,verbose_edge)
 
 curves = extractedge(pic,scale,gradmagnthreshold,'same');
 magnitude = Lv(pic,'same');
 if (verbose == 1)
     %%%% show the overlay curves
     figure
     overlaycurves(pic,curves);
     title('The overlay of the image');
     %%%% show the magnitude
     figure 
     showgrey(magnitude);
     title('the Magnitude of the image');
 elseif (verbose == 2)
     
     [linepar acc] = houghline(pic,curves,magnitude,nrho,ntheta,gradmagnthreshold,nlines,verbose_edge);
     figure
     subplot(1,2,1)
     showgrey(acc)
     title('acc parameters');
     subplot(1,2,2)
     accsmooth = binsepsmoothiter(acc,1,2);
     showgrey(accsmooth);
     title('smoothed acc');
 elseif (verbose==0)
     [linepar acc] = houghline(pic,curves,magnitude,nrho,ntheta,gradmagnthreshold,nlines,verbose_edge);
     
 else 
     fprintf('wrong verbose');
 end
 
 
     

 