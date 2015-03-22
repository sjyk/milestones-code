function [ grid ] = getCutVGrid(trial,...
                                                      time_index,...
                                                      cut_threshold, ...
                                                      xlimit, ...
                                                      ylimit)
%GETPENETRATIONGRID Summary of this function goes here
%   Detailed explanation goes here
scale = 1000;
N = round(xlimit*scale)+1;
M = round(ylimit*scale)+1;
grid = zeros(N,M);
[locs d] = size(trial(:,9));
for i=2:1:locs
    if trial(i,9) < 100
        x = abs(round(trial(i,1)*scale))+1;
        y = abs(round(trial(i,2)*scale))+1;
        grid(x,y) = max(abs(trial(i,9)-trial(i-1,9)),grid(x,y)) ;
    end
end

end

