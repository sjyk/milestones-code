function [ changePoints, W ] = getChangePointsPhysics( trial, smoothFlag )
% getChangePoints( trial, feature_grid, scale )
% whenever there is a non-zero jerk in the trajectory, we use it as a change point
% we also output the sum of squares of jerk at each changepoint as its
% relative weight

[n p] = size(trial);
output = [];

if nargin<2
    smoothFlag = 0;
end

% Try with and without smoothing
if smoothFlag
    %run smoothing on data for all the dimensions
    for i = 1:n
        trailSmooth (:,i)= smooth(trial(:,i),0.1,'rloess');
    end
end

% calculate jerk
J = diff(trail, 3, 1);
% J_pos= diff(trail(:,13:15),2,1);
% J_ang= diff(trail(:,16:18),2,1);
% J_grip = diff(trail(:,19),3);

for i = 1: p
    J = 
end

%points of non-zero jerk

for i = 2:1:n
   
end



for i=2:1:n
    x2 = abs(round(trial(i,1)*scale))+1;
    y2 = abs(round(trial(i,2)*scale))+1;
    x1 = abs(round(trial(i-1,1)*scale))+1;
    y1 = abs(round(trial(i-1,2)*scale))+1;
    if trial(i,3) < -0.135 && ...
            trial(i-1,3) < -0.135 && ...
            feature_grid(x1,y1) ~= feature_grid(x2,y2) ...
            && feature_grid(x1,y1)*feature_grid(x2,y2) ~= 0
        output =[output;i trial(i,1:3)];
    end
end

end

