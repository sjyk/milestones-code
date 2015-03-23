function [ output ] = getChangePoints( trial, feature_grid, scale )
[n p] = size(trial);
output = [];
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

