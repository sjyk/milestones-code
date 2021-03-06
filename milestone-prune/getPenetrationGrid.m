function [ grid ] = getPenetrationGrid(trial,...
                                                      time_index,...
                                                      threshold_depth, ...
                                                      xlimit, ...
                                                      ylimit)
%GETPENETRATIONGRID Summary of this function goes here
%   Detailed explanation goes here
scale = 1000;
N = abs(round(xlimit*scale))+1;
M = abs(round(ylimit*scale))+1;
grid = zeros(N,M);
ptimes = find(trial(:,3) < threshold_depth);
prior_ptimes = ptimes(find(ptimes <= time_index));
pen_locations = trial(prior_ptimes,:)*scale;
[locs d] = size(pen_locations);
for i=1:1:locs
    grid(abs(round(pen_locations(i,1)))+1,abs(round(pen_locations(i,2)))+1) = max(abs(trial(i,3)-threshold_depth),...
    grid(abs(round(pen_locations(i,1)))+1,abs(round(pen_locations(i,2)))+1));
end

end

