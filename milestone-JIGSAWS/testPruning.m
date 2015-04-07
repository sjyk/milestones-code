% testPruning
%       /\
%  _ _ _\/_ _ _ : line, circle1, line

%% Draw curve
%  [~,x1,y1] = freehanddraw();
 [xy1,spcv1] = getcurve; 
 [xy2,spcv2] = getcurve;
 
%  change point pruning

 
%% final plot
C1 = fnplt(cscvn(xy1)); hold on, 
plot(xy1(1,:),xy1(2,:),'o'), hold off
axis equal


