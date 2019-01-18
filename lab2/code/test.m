testimage1 = triangle128;
scale = 2;
gradmagnthreshold = 5;
nrho = 200;
ntheta = 180;
nlines = 3;
verbose = 0;

figure
verbose_edge = 1;
[linepar,acc] = houghedgeline(testimage1,scale,gradmagnthreshold,nrho,ntheta,nlines,verbose,verbose_edge);
visualize_edge(testimage1,linepar);
