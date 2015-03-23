function [ output_args ] = visualizeTrajectory( trial, left, sampling)
    
    if nargin == 2
    	sampling = 1;
    end

    data = trial{left};
    color = (data(:,9)+pi)/(2*pi);
    [n p] = size(color);
    subset = sort(randsample((1:1:n),round(sampling*n)));
    gray = subset'/n;
    output_args = plot3(data(subset,1), data(subset,2), data(subset,3),'k')%, 30) %[gray gray gray], 'filled');
    xlabel('X (cm)');
    ylabel('Y (cm)');
    zlabel('Z (cm)');
end

